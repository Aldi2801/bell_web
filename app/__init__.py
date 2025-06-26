from flask import Flask,jsonify,request,session,render_template,g,send_from_directory,abort
from flask_sqlalchemy import SQLAlchemy
from flask_cors import CORS
from flask_mail import Mail, Message
from itsdangerous import URLSafeTimedSerializer
from flask_security import Security, SQLAlchemyUserDatastore, UserMixin, RoleMixin
from flask_bcrypt import Bcrypt
from datetime import timedelta, datetime
import jwt, os, re
from flask_jwt_extended import JWTManager

app = Flask(__name__)
project_directory = os.path.abspath(os.path.dirname(__file__))
upload_folder = os.path.join(project_directory, 'static', 'image')
upload_nota = os.path.join(project_directory, 'static', 'nota')
app.config['UPLOAD_FOLDER'] = upload_folder 
app.config['UPLOAD_NOTA'] = upload_nota
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root@localhost/bell_web_sistem'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'isahc8u2e0921e12osa00-=[./vds]'
app.config['SECURITY_PASSWORD_HASH'] = 'bcrypt'
app.config['SECURITY_PASSWORD_SALT'] = b'asahdjhwquoyo192382qo'
# Nonaktifkan rute login bawaan
app.config['SECURITY_LOGIN_URL'] = None
app.config['SECURITY_LOGOUT_URL'] = '/logout'  
app.config['JWT_SECRET_KEY'] = 'qwdu92y17dqsu81'
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(days=1)
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(days=1)
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=587,
    MAIL_USE_TLS=True,
    MAIL_USERNAME=os.getenv('MAIL_USERNAME', 'masteraldi2809@gmail.com'),
    MAIL_PASSWORD=os.getenv('MAIL_PASSWORD', 'xthezwlpdajgtlav')
)
jwt = JWTManager(app)
mail = Mail(app)
mail.init_app(app)
s = URLSafeTimedSerializer(app.config['JWT_SECRET_KEY'])
ALLOWED_EXTENSIONS = {'xlsx'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)

# Define the 'user_roles' class before 'User' class
class UserRoles(db.Model):
    id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete='CASCADE'))
    role_id = db.Column(db.Integer, db.ForeignKey('role.id', ondelete='CASCADE'))

class Role(db.Model, RoleMixin):
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(80), unique=True)

class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), unique=True, nullable=True)
    password = db.Column(db.String(255), nullable=True)
    nis = db.Column(db.Integer, nullable=True)
    nip = db.Column(db.String(25), nullable=True)
    email = db.Column(db.String(255), unique=True, nullable=True)
    active = db.Column(db.Boolean, default=True)
    reset_token = db.Column(db.String(255), nullable=True)
    roles = db.relationship('Role', secondary='user_roles',
                            primaryjoin='User.id == UserRoles.user_id',
                            secondaryjoin='Role.id == UserRoles.role_id',
                            backref=db.backref('users', lazy='dynamic'),
                            passive_deletes=True)

    siswa = db.relationship("Siswa", back_populates="user", uselist=False, passive_deletes=True)
    tagihan = db.relationship("Tagihan", backref="user", passive_deletes=True)

class Gender(db.Model):
    id_gender = db.Column(db.CHAR(1), primary_key=True)
    gender = db.Column(db.String(9), nullable=True)

class Guru(db.Model):
    nip = db.Column(db.String(25), primary_key=True)
    inisial = db.Column(db.String(4))
    nama = db.Column(db.String(50), nullable=True)
    tempat_lahir = db.Column(db.String(20), nullable=True)
    tanggal_lahir = db.Column(db.Date, nullable=True)
    alamat = db.Column(db.String(125), nullable=True)
    no_hp = db.Column(db.String(15), nullable=True)
    email = db.Column(db.String(30), nullable=True)
    spesialisasi = db.Column(db.String(20))
    id_gender = db.Column(db.CHAR(1), db.ForeignKey('gender.id_gender', ondelete='CASCADE'), nullable=True)
    id_status = db.Column(db.CHAR(1), db.ForeignKey('status.id_status', ondelete='CASCADE'), nullable=True)

    gender_rel = db.relationship("Gender", backref="guru_list", passive_deletes=True)
    status_rel = db.relationship("Status", backref="guru_list", passive_deletes=True)
    berita = db.relationship("Berita", backref="guru", passive_deletes=True)
    pembagian_list = db.relationship("PembagianKelas", backref="guru_rel", passive_deletes=True)

    user = db.relationship("User", primaryjoin="foreign(User.nip) == Guru.nip", uselist=False, viewonly=True)

class Berita(db.Model):
    id_berita = db.Column(db.Integer, primary_key=True)
    judul = db.Column(db.String(35), nullable=True)
    isi = db.Column(db.String(255), nullable=True)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip', ondelete='SET NULL'), nullable=True)
    tanggal_dibuat = db.Column(db.DateTime, default=datetime.utcnow)
    pengumuman_untuk = db.Column(db.String(10), nullable=True)  # 'murid' atau 'guru'
    
class Mapel(db.Model):
    id_mapel = db.Column(db.CHAR(3), primary_key=True)
    nama_mapel = db.Column(db.String(35), nullable=True)

class Semester(db.Model):
    id_semester = db.Column(db.CHAR(1), primary_key=True)
    semester = db.Column(db.String(6), nullable=True)

class TahunAkademik(db.Model):
    id_tahun_akademik = db.Column(db.Integer, primary_key=True, autoincrement=True)
    tahun_akademik = db.Column(db.String(9), unique=True, nullable=True)  # e.g., "2024/2025"
    mulai = db.Column(db.Date, nullable=True)
    sampai = db.Column(db.Date, nullable=True)

class Status(db.Model):
    id_status = db.Column(db.CHAR(1), primary_key=True)
    status = db.Column(db.String(20), nullable=True)

class Kelas(db.Model):
    id_kelas = db.Column(db.String(6), primary_key=True)
    nama_kelas = db.Column(db.String(15), nullable=True)
    tingkat = db.Column(db.CHAR(1), nullable=True)

class AmpuMapel(db.Model):
    id_ampu = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date)
    id_semester = db.Column(db.CHAR(1), db.ForeignKey('semester.id_semester', ondelete='CASCADE'), nullable=True)
    id_mapel = db.Column(db.CHAR(3), db.ForeignKey('mapel.id_mapel', ondelete='CASCADE'), nullable=True)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip', ondelete='CASCADE'), nullable=True)
    id_tahun_akademik = db.Column(db.Integer, db.ForeignKey('tahun_akademik.id_tahun_akademik', ondelete='CASCADE'), nullable=True)
    id_pembagian = db.Column(db.Integer, db.ForeignKey('pembagian_kelas.id_pembagian', ondelete='SET NULL'), nullable=True)

    guru_rel = db.relationship("Guru", backref="ampu_mapel_list", passive_deletes=True)
    mapel_rel = db.relationship("Mapel", backref="ampu_mapel_list", passive_deletes=True)
    semester_rel = db.relationship("Semester", backref="ampu_mapel", passive_deletes=True)
    tahun_akademik_rel = db.relationship("TahunAkademik", backref="ampu_mapel", passive_deletes=True)
    pembagian_rel = db.relationship("PembagianKelas", backref="ampu_mapel", passive_deletes=True, uselist=False)
class Kbm(db.Model):
    __tablename__ = 'kbm'

    id_kbm = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date, nullable=True)
    materi = db.Column(db.String(35), nullable=True)
    sub_materi = db.Column(db.String(100))
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu'), nullable=False)

    # Relasi ke AmpuMapel
    ampu_rel = db.relationship('AmpuMapel', backref='kbm_list', lazy=True)

class Keterangan(db.Model):
    id_keterangan = db.Column(db.CHAR(1), primary_key=True)
    keterangan = db.Column(db.String(5), nullable=True)

class Kehadiran(db.Model):
    __tablename__ = 'kehadiran'

    id_kehadiran = db.Column(db.Integer, primary_key=True)
    id_keterangan = db.Column(db.CHAR(1), db.ForeignKey('keterangan.id_keterangan', ondelete='CASCADE'), nullable=True)
    id_kbm = db.Column(db.Integer, db.ForeignKey('kbm.id_kbm', ondelete='CASCADE'), nullable=True)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis', ondelete='CASCADE'), nullable=True)

    # Relasi ke tabel Keterangan
    keterangan_rel = db.relationship('Keterangan', backref='kehadiran_list', lazy=True)

    # Relasi ke tabel Kbm
    kbm_rel = db.relationship('Kbm', backref='kehadiran_list', lazy=True)

    # Relasi ke tabel Siswa
    siswa_rel = db.relationship('Siswa', backref='kehadiran_list', lazy=True)  

class Siswa(db.Model):
    nis = db.Column(db.Integer, primary_key=True)
    nisn = db.Column(db.String(10))
    nama = db.Column(db.String(50), nullable=True)
    id_gender = db.Column(db.CHAR(1), db.ForeignKey('gender.id_gender', ondelete='CASCADE'), nullable=True)
    tempat_lahir = db.Column(db.String(20), nullable=True)
    tanggal_lahir = db.Column(db.Date, nullable=True)
    alamat = db.Column(db.String(125), nullable=True)
    no_hp = db.Column(db.String(15), nullable=True)
    nama_ayah = db.Column(db.String(35), nullable=True)
    nama_ibu = db.Column(db.String(35), nullable=True)
    penghasilan_ayah = db.Column(db.Integer, nullable=True)
    penghasilan_ibu = db.Column(db.Integer, nullable=True)
    asal_sekolah = db.Column(db.String(30), nullable=True)
    id_status = db.Column(db.CHAR(1), db.ForeignKey('status.id_status', ondelete='CASCADE'), nullable=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete='SET NULL'), unique=True, nullable=True)

    gender_rel = db.relationship("Gender", backref="siswa_list", passive_deletes=True)
    status_rel = db.relationship("Status", backref="siswa_list", passive_deletes=True)
    user = db.relationship("User", back_populates="siswa", passive_deletes=True)
    pembagian_rel = db.relationship("PembagianKelas", back_populates="siswa_rel", passive_deletes=True)
class PembagianKelas(db.Model):
    id_pembagian = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis', ondelete='CASCADE'), nullable=True)
    id_kelas = db.Column(db.String(6), db.ForeignKey('kelas.id_kelas', ondelete='CASCADE'), nullable=True)
    id_tahun_akademik = db.Column(db.Integer, db.ForeignKey('tahun_akademik.id_tahun_akademik', ondelete='CASCADE'), nullable=True)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip', ondelete='CASCADE'), nullable=True)

    kelas_rel = db.relationship("Kelas", backref="pembagian_list", passive_deletes=True)
    siswa_rel = db.relationship("Siswa", back_populates="pembagian_rel", passive_deletes=True)
    ida_rel = db.relationship("TahunAkademik", backref="pembagian_list", passive_deletes=True)

class Tagihan(db.Model):
    id_tagihan = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete='CASCADE'), nullable=True)
    semester = db.Column(db.String(10))
    tahun_ajaran = db.Column(db.String(10))
    deskripsi = db.Column(db.String(255))
    total = db.Column(db.Float, nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class Transaksi(db.Model):
    id_transaksi = db.Column(db.Integer, primary_key=True)
    kode_order = db.Column(db.String(100), unique=True, nullable=True)
    id_tagihan = db.Column(db.Integer, db.ForeignKey('tagihan.id_tagihan', ondelete='SET NULL'), nullable=True)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis', ondelete='SET NULL'), nullable=True)
    email = db.Column(db.String(120), nullable=True)
    total = db.Column(db.Float, nullable=True)
    status = db.Column(db.String(50), default="pending")
    fraud_status = db.Column(db.String(50), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

class JadwalPelajaran(db.Model):
    id_jadwal = db.Column(db.Integer, primary_key=True)
    day = db.Column(db.String(10), nullable=True)
    time = db.Column(db.String(15), nullable=True)
    period = db.Column(db.Integer, nullable=True)
    subject = db.Column(db.Text, nullable=True)

class Penilaian(db.Model):
    id_penilaian = db.Column(db.Integer, primary_key=True)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis', ondelete='CASCADE'), nullable=False)
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu', ondelete='CASCADE'), nullable=True)
    jenis_penilaian = db.Column(db.String(20), nullable=False)  # Contoh: 'UH', 'UTS', 'UAS', 'Tugas'
    nilai = db.Column(db.Float, nullable=False)
    tanggal = db.Column(db.Date, default=datetime.utcnow)

    siswa_rel = db.relationship("Siswa", backref="penilaian_list", passive_deletes=True)
    ampu_rel = db.relationship("AmpuMapel", backref="penilaian_list", passive_deletes=True)

class EvaluasiGuru(db.Model):
    __tablename__ = 'evaluasi_guru'

    id = db.Column(db.Integer, primary_key=True)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip', ondelete='CASCADE'), nullable=False)
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu', ondelete='SET NULL'), nullable=True)

    evaluator_id = db.Column(db.Integer, db.ForeignKey('user.id', ondelete='SET NULL'), nullable=True)
    evaluator_role = db.Column(db.String(10), nullable=False)  # 'murid', 'admin', 'guru'

    aspek = db.Column(db.String(50), nullable=False)
    skor = db.Column(db.Integer, nullable=False)
    komentar = db.Column(db.Text, nullable=True)
    tanggal = db.Column(db.DateTime, default=datetime.utcnow)

    # Relasi
    guru = db.relationship("Guru", backref="evaluasi_list", passive_deletes=True)
    ampu = db.relationship("AmpuMapel", backref="evaluasi_list", passive_deletes=True)
    evaluator = db.relationship("User", backref="evaluasi_dibuat", passive_deletes=True)


# allow CORS biar api yang dibuat bisa dipake website lain
from flask_cors import CORS
CORS(app)
# Import rute dari modul-modul Anda

@app.route('/sitemap.xml')
def sitemap():
    # Logika untuk menghasilkan sitemap.xml
    # Misalnya, jika sitemap.xml adalah file statis, Anda bisa mengembalikan file secara langsung
    return send_from_directory(app.static_folder, 'sitemap.xml')

@app.route('/robots.txt')
def robots():
    # Logika untuk menghasilkan robots.txt
    return """
    User-agent: *
    Disallow: /private/
    Disallow: /cgi-bin/
    Disallow: /images/
    Disallow: /pages/thankyou.html
    """
# Fungsi untuk menangani kesalahan 404
@app.errorhandler(404)
def page_not_found(error):
    # Cek apakah klien meminta JSON
    if request.accept_mimetypes.accept_json and not request.accept_mimetypes.accept_html:
        # Jika klien meminta JSON, kirim respons dalam format JSON
        response = jsonify({'error': 'Not found'})
        response.status_code = 404
        return response
    # Jika tidak, kirim respons dalam format HTML
    return render_template('404.html'), 404

# Route untuk halaman yang tidak ada
@app.route('/invalid')
def invalid():
    # Menggunakan abort untuk memicu kesalahan 404
    abort(404)
# Fungsi untuk verifikasi token
@app.errorhandler(404)
def page_not_found(error):
    if request.accept_mimetypes.accept_json and not request.accept_mimetypes.accept_html:
        response = jsonify({'error': 'Not found'})
        response.status_code = 404
        return response
    return render_template('404.html'), 404

def get_semester_and_year():
    now = datetime.now()
    year = now.year
    month = now.month

    if month < 7:
        semester = "genap"
        tahun_ajaran = f"{year-1}/{year}"
        mulai = datetime(year-1, 7, 1)     # 1 Juli tahun sebelumnya
        selesai = datetime(year, 6, 30)    # 30 Juni tahun ini
    else:
        semester = "ganjil"
        tahun_ajaran = f"{year}/{year+1}"
        mulai = datetime(year, 7, 1)       # 1 Juli tahun ini
        selesai = datetime(year+1, 6, 30)  # 30 Juni tahun depan

    return semester, tahun_ajaran, mulai, selesai

def is_valid_email(email):
    regex = r'^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w+$'
    return re.match(regex, email)

@app.before_request
def create_automatic_tahun_ajaran():
    semester, tahun_ajaran, mulai, selesai = get_semester_and_year()

    # Cek apakah data tahun akademik dan semester ini sudah ada
    existing = TahunAkademik.query.filter_by(
        tahun_akademik = tahun_ajaran,
    ).first()

    if not existing:
        # Buat entri baru
        new_ta = TahunAkademik(
            tahun_akademik=tahun_ajaran,
            mulai=mulai,
            sampai=selesai
        )
        db.session.add(new_ta)
        db.session.commit()

from . import api_admin, login, midtrans, view, api_guru, api_murid

# @app.before_request
# def create_automatic_bills():
    # semester, tahun_ajaran = get_semester_and_year()

    # bulan_mapping = [
        # "Januari", "Februari", "Maret", "April", "Mei", "Juni",
        # "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    # ]
    # bulan_sekarang = bulan_mapping[datetime.now().month - 1]

    # spp_bulanan = f"SPP Bulanan - {bulan_sekarang} {tahun_ajaran} {semester}"
    # ujian_tahunan = f"Uang Ujian {tahun_ajaran} {semester}"

    # semua_siswa = Siswa.query.all()

    # for s in semua_siswa:
        # # Cek apakah tagihan SPP sudah ada untuk siswa ini
        # existing_spp = Tagihan.query.filter_by(
            # user_email=s.email,
            # deskripsi=spp_bulanan,
            # semester=semester,
            # tahun_ajaran=tahun_ajaran
        # ).first()

        # if not existing_spp:
            # tagihan_spp = Tagihan(
                # user_email=s.email,
                # deskripsi=spp_bulanan,
                # total=10000,
                # semester=semester,
                # tahun_ajaran=tahun_ajaran,
                # created_at=datetime.now()
            # )
            # db.session.add(tagihan_spp)

        # # Cek apakah tagihan Ujian sudah ada untuk siswa ini
        # existing_ujian = Tagihan.query.filter_by(
            # user_email=s.email,
            # deskripsi=ujian_tahunan,
            # semester=semester,
            # tahun_ajaran=tahun_ajaran
        # ).first()

        # if not existing_ujian:
            # tagihan_ujian = Tagihan(
                # user_email=s.email,
                # deskripsi=ujian_tahunan,
                # total=1000000,
                # semester=semester,
                # tahun_ajaran=tahun_ajaran,
                # created_at=datetime.now()
            # )
            # db.session.add(tagihan_ujian)

    # db.session.commit()

