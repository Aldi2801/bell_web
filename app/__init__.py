from flask import Flask,jsonify,request,session,render_template,g,send_from_directory,abort
from flask_sqlalchemy import SQLAlchemy
from flask_jwt_extended import JWTManager
from flask_cors import CORS
from flask_mail import Mail
from itsdangerous import URLSafeTimedSerializer
from flask_security import Security, SQLAlchemyUserDatastore, UserMixin, RoleMixin
from flask_bcrypt import Bcrypt
from datetime import timedelta, datetime
import jwt, os, re

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
mail = Mail(app)
s = URLSafeTimedSerializer(app.config['JWT_SECRET_KEY'])
ALLOWED_EXTENSIONS = {'xlsx'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

db = SQLAlchemy(app)
bcrypt = Bcrypt(app)

# Define the 'user_roles' class before 'User' class
class UserRoles(db.Model):
    id = db.Column(db.Integer(), primary_key=True)
    user_id = db.Column(db.Integer(), db.ForeignKey('user.id'))
    role_id = db.Column(db.Integer(), db.ForeignKey('role.id'))

class Role(db.Model, RoleMixin):
    id = db.Column(db.Integer(), primary_key=True)
    name = db.Column(db.String(80), unique=True)
    
class User(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True)
    username = db.Column(db.String(255), unique=True, nullable=False)
    password = db.Column(db.String(255), nullable=False)
    nis = db.Column(db.Integer, nullable=True)
    nip = db.Column(db.String(25), nullable=True)
    email = db.Column(db.String(255), unique=True, nullable=False)  # Fix disini
    active = db.Column(db.Boolean, default=True)
    fs_uniquifier = db.Column(db.String(64), unique=True, nullable=False)

    roles = db.relationship('Role', secondary='user_roles', 
                            primaryjoin='User.id == UserRoles.user_id',
                            secondaryjoin='Role.id == UserRoles.role_id',
                            backref=db.backref('users', lazy='dynamic'))

class ampuMapel(db.Model):
    id_ampu = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date)
    id_semester = db.Column(db.String(1), db.ForeignKey('semester.id_semester'), nullable=False)
    id_mapel = db.Column(db.String(3), db.ForeignKey('mapel.id_mapel'), nullable=False)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip'), nullable=False)
    id_tahun_akademik = db.Column(db.String(4), db.ForeignKey('tahun_akademik.id_tahun_akademik'), nullable=False)
    id_pembagian = db.Column(db.Integer, db.ForeignKey('pembagian_kelas.id_pembagian'))

class berita(db.Model):
    id_berita = db.Column(db.Integer, primary_key=True)
    judul = db.Column(db.String(35), nullable=False)
    isi = db.Column(db.String(255), nullable=False)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip'), nullable=False)

class gender(db.Model):
    id_gender = db.Column(db.String(1), primary_key=True)
    gender = db.Column(db.String(9), nullable=False)

class guru(db.Model):
    nip = db.Column(db.String(25), primary_key=True)
    inisial = db.Column(db.String(4))
    nama = db.Column(db.String(50), nullable=False)
    tempat_lahir = db.Column(db.String(20), nullable=False)
    tanggal_lahir = db.Column(db.Date, nullable=False)
    alamat = db.Column(db.String(125), nullable=False)
    no_hp = db.Column(db.String(15), nullable=False)
    email = db.Column(db.String(30), nullable=False)
    spesialisasi = db.Column(db.String(20))
    id_gender = db.Column(db.String(1), db.ForeignKey('gender.id_gender'), nullable=False)
    id_status = db.Column(db.String(1), db.ForeignKey('status.id_status'), nullable=False)

    gender_rel = db.relationship("gender", backref="guru_list")
    status_rel = db.relationship("status", backref="guru_list")

    user = db.relationship(
        "User",
        primaryjoin="foreign(User.nip) == guru.nip",
        uselist=False,
        viewonly=True
    )
class kbm(db.Model):
    id_kbm = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date, nullable=False)
    materi = db.Column(db.String(35), nullable=False)
    sub_materi = db.Column(db.String(100))
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu'), nullable=False)

class kehadiran(db.Model):
    id_kehadiran = db.Column(db.Integer, primary_key=True)
    id_keterangan = db.Column(db.String(1), db.ForeignKey('keterangan.id_keterangan'), nullable=False)
    id_kbm = db.Column(db.Integer, db.ForeignKey('kbm.id_kbm'), nullable=False)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis'), nullable=False)

class kelas(db.Model):
    id_kelas = db.Column(db.String(6), primary_key=True)
    nama_kelas = db.Column(db.String(15), nullable=False)
    tingkat = db.Column(db.String(1), nullable=False)

class keterangan(db.Model):
    id_keterangan = db.Column(db.String(1), primary_key=True)
    keterangan = db.Column(db.String(5), nullable=False)

class mapel(db.Model):
    id_mapel = db.Column(db.String(3), primary_key=True)
    nama_mapel = db.Column(db.String(35), nullable=False)

class pembagianKelas(db.Model):
    id_pembagian = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis'), nullable=False)
    id_kelas = db.Column(db.String(6), db.ForeignKey('kelas.id_kelas'), nullable=False)
    id_tahun_akademik = db.Column(db.String(4), db.ForeignKey('tahun_akademik.id_tahun_akademik'), nullable=False)
    nip = db.Column(db.String(25), db.ForeignKey('guru.nip'), nullable=False)

class penilaian(db.Model):
    id_penilaian = db.Column(db.Integer, primary_key=True)
    tugas = db.Column(db.Integer)
    uts = db.Column(db.Integer)
    uas = db.Column(db.Integer)
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu'), nullable=False)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis'), nullable=False)

class semester(db.Model):
    id_semester = db.Column(db.String(1), primary_key=True)
    semester = db.Column(db.String(6), nullable=False)

class siswa(db.Model):
    nis = db.Column(db.Integer, primary_key=True)
    nisn = db.Column(db.String(10))
    nama = db.Column(db.String(50), nullable=False)
    id_gender = db.Column(db.String(1), db.ForeignKey('gender.id_gender'), nullable=False)
    tempat_lahir = db.Column(db.String(20), nullable=False)
    tanggal_lahir = db.Column(db.Date, nullable=False)
    alamat = db.Column(db.String(125), nullable=False)
    no_hp = db.Column(db.String(15), nullable=False)
    email = db.Column(db.String(30),unique=True, nullable=False)
    nama_ayah = db.Column(db.String(35), nullable=False)
    nama_ibu = db.Column(db.String(35), nullable=False)
    penghasilan_ayah = db.Column(db.Integer, nullable=False)
    penghasilan_ibu = db.Column(db.Integer, nullable=False)
    asal_sekolah = db.Column(db.String(30), nullable=False)
    id_status = db.Column(db.String(1), db.ForeignKey('status.id_status'), nullable=False)

class status(db.Model):
    id_status = db.Column(db.String(1), primary_key=True)
    status = db.Column(db.String(20), nullable=False)

class tahunAkademik(db.Model):
    id_tahun_akademik = db.Column(db.String(4), primary_key=True)
    tahun_akademik = db.Column(db.String(9), nullable=False)
    mulai = db.Column(db.Date, nullable=False)
    sampai = db.Column(db.Date, nullable=False)

class tagihan(db.Model):
    id_tagihan = db.Column(db.Integer, primary_key=True)
    user_email = db.Column(db.String(120), nullable=False)
    semester = db.Column(db.String(10))
    tahun_ajaran = db.Column(db.String(10))
    deskripsi = db.Column(db.String(255))
    total = db.Column(db.Float, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class transaksi(db.Model):
    id_transaksi = db.Column(db.Integer, primary_key=True)
    kode_order = db.Column(db.String(100), unique=True, nullable=False)
    id_tagihan = db.Column(db.Integer, db.ForeignKey('tagihan.id_tagihan'), nullable=True)
    email = db.Column(db.String(120),  db.ForeignKey('siswa.email'), nullable=False)
    total = db.Column(db.Float, nullable=False)
    status = db.Column(db.String(50), default="pending")
    fraud_status = db.Column(db.String(50), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

class tugas(db.Model):
    id_tugas = db.Column(db.Integer, primary_key=True)
    jenis_tugas = db.Column(db.String(50))
    deskripsi =  db.Column(db.String(255))
    id_mapel = db.Column(db.String(3), db.ForeignKey('mapel.id_mapel'), nullable=False)
    nip = db.Column(db.String(25),  db.ForeignKey('guru.nip'), nullable=False)
class JadwalPelajaran(db.Model):
    id_jadwal = db.Column(db.Integer, primary_key=True)
    day = db.Column(db.String(10), nullable=False)
    time = db.Column(db.String(15), nullable=False)
    period = db.Column(db.Integer, nullable=False)
    subject = db.Column(db.Text, nullable=False)

# seeder
# seeder_siswa.py

from faker import Faker
import random
import uuid
from datetime import datetime
from werkzeug.security import generate_password_hash

fake = Faker('id_ID')
def clean_nama(nama):
    # Hilangkan gelar umum dari nama
    gelar = ['S.Pd', 'S.Kom', 'M.Pd', 'Dr.','dr','hj','Hj','M.M',',','.', 'Drs.', 'H.', 'Ir.', 'S.E.', 'S.H.', 'S.T.', 'M.Kom', 'Ph.D']
    for g in gelar:
        nama = nama.replace(g, '')
    return nama.strip()

def generate_siswa_data(start_nis=20001, jumlah=50):
    generated = 0
    for i in range(jumlah):
        nis = start_nis + i
        nisn = f"9900{str(i+1).zfill(4)}"
        raw_nama = fake.name_male() if i % 2 == 0 else fake.name_female()
        nama = clean_nama(raw_nama)  # gunakan fungsi clean
        id_gender = 'L' if i % 2 == 0 else 'P'
        tempat_lahir = fake.city()
        tanggal_lahir = fake.date_of_birth(minimum_age=14, maximum_age=16)
        alamat = fake.address().replace("\n", ", ")
        no_hp = f"08{random.randint(1000000000, 9999999999)}"
        email = f"{nama.lower().replace(' ', '').replace('.', '').replace(',', '')}{i}@mail.com"
        nama_ayah = fake.first_name_male()
        nama_ibu = fake.first_name_female()
        penghasilan_ayah = random.randint(3000000, 7000000)
        penghasilan_ibu = random.randint(2000000, 6000000)
        asal_sekolah = f"SDN {random.randint(1, 50)} {fake.city()}"
        id_status = '1'

        # Username berbasis nama
        username = nama.lower().split()[0] + str(i)

        # Cek apakah siswa sudah ada berdasarkan NIS atau email
        if siswa.query.filter_by(nis=nis).first() or siswa.query.filter_by(email=email).first():
            continue

        # Cek apakah user sudah ada
        if User.query.filter_by(email=email).first():
            continue

        hashed_password = bcrypt.generate_password_hash("password123").decode('utf-8')

        new_user = User(
            username=username,
            password=hashed_password,
            email=email,
            active=True,
            fs_uniquifier=str(uuid.uuid4()),
            nis=nis
        )

        new_siswa = siswa(
            nis=nis,
            nisn=nisn,
            nama=nama,
            id_gender=id_gender,
            tempat_lahir=tempat_lahir,
            tanggal_lahir=tanggal_lahir,
            alamat=alamat,
            no_hp=no_hp,
            email=email,
            nama_ayah=nama_ayah,
            nama_ibu=nama_ibu,
            penghasilan_ayah=penghasilan_ayah,
            penghasilan_ibu=penghasilan_ibu,
            asal_sekolah=asal_sekolah,
            id_status=id_status
        )

        db.session.add(new_user)
        db.session.add(new_siswa)
        generated += 1

    db.session.commit()
    print(f"{generated} data siswa berhasil ditambahkan.")

#seeder guru 
from datetime import date
def import_data_guru():
    guru_list = [
        {
            "nama": "H. Jamar, S.Pd.I",
            "inisial": "JMR",
            "tempat_lahir": "Tegal",
            "tanggal_lahir": date(1980, 5, 12),
            "alamat": "Jl. Merdeka No. 1, Tegal",
            "no_hp": "081234567801",
            "email": "jamar@example.com",
            "spesialisasi": "PAI",
            "id_gender": "L",
            "id_status": "1"
        },
        {
            "nama": "H. Hurwiyati, S.Pd",
            "inisial": "HRW",
            "tempat_lahir": "Brebes",
            "tanggal_lahir": date(1982, 8, 20),
            "alamat": "Jl. Mawar No. 3, Brebes",
            "no_hp": "081234567802",
            "email": "hurwiyati@example.com",
            "spesialisasi": "PKn",
            "id_gender": "P",
            "id_status": "1"
        },
        {
            "nama": "Titik Eko Purwati, S.Pd",
            "inisial": "TEP",
            "tempat_lahir": "Slawi",
            "tanggal_lahir": date(1985, 2, 15),
            "alamat": "Jl. Melati No. 5, Slawi",
            "no_hp": "081234567803",
            "email": "titikeko@example.com",
            "spesialisasi": "B. Indonesia",
            "id_gender": "P",
            "id_status": "1"
        },
        {
            "nama": "Biyanto, S.Pd",
            "inisial": "BYT",
            "tempat_lahir": "Tegal",
            "tanggal_lahir": date(1984, 11, 10),
            "alamat": "Jl. Kenanga No. 7, Tegal",
            "no_hp": "081234567804",
            "email": "biyanto@example.com",
            "spesialisasi": "Matematika",
            "id_gender": "L",
            "id_status": "1"
        },
        {
            "nama": "Ulinnuha S.Pd.I",
            "inisial": "ULN",
            "tempat_lahir": "Brebes",
            "tanggal_lahir": date(1983, 4, 7),
            "alamat": "Jl. Anggrek No. 9, Brebes",
            "no_hp": "081234567805",
            "email": "ulinnuha@example.com",
            "spesialisasi": "PAI",
            "id_gender": "P",
            "id_status": "1"
        },
        {
            "nama": "Purnadi, S.Pd.S",
            "inisial": "PRN",
            "tempat_lahir": "Slawi",
            "tanggal_lahir": date(1979, 1, 27),
            "alamat": "Jl. Flamboyan No. 10, Slawi",
            "no_hp": "081234567806",
            "email": "purnadi@example.com",
            "spesialisasi": "Penjas",
            "id_gender": "L",
            "id_status": "1"
        },
        {
            "nama": "Nur Arifin, S.Pd.I",
            "inisial": "NAR",
            "tempat_lahir": "Tegal",
            "tanggal_lahir": date(1986, 6, 5),
            "alamat": "Jl. Sawo No. 11, Tegal",
            "no_hp": "081234567807",
            "email": "nurarifin@example.com",
            "spesialisasi": "PAI",
            "id_gender": "L",
            "id_status": "1"
        },
        {
            "nama": "Riski Arofiyah, S.Pd",
            "inisial": "RA",
            "tempat_lahir": "Brebes",
            "tanggal_lahir": date(1990, 12, 30),
            "alamat": "Jl. Semangka No. 12, Brebes",
            "no_hp": "081234567808",
            "email": "riskiarofiyah@example.com",
            "spesialisasi": "IPA",
            "id_gender": "P",
            "id_status": "1"
        },
    ]

    # Simpan ke DB
    generated = 0
    for data in guru_list:
        existing = guru.query.filter_by(email=data["email"]).first()
        if existing:
            continue
        new_guru = guru(
            inisial=data["inisial"],
            nama=data["nama"],
            tempat_lahir=data["tempat_lahir"],
            tanggal_lahir=data["tanggal_lahir"],
            alamat=data["alamat"],
            no_hp=data["no_hp"],
            email=data["email"],
            spesialisasi=data["spesialisasi"],
            id_gender=data["id_gender"],
            id_status=data["id_status"]
        )
        db.session.add(new_guru)
        generated += 1

    db.session.commit()
    print(f"{generated} data guru berhasil ditambahkan.")

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
@app.route('/verify-token', methods=['POST'])
def verify_token():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token is missing'}), 403
    try:
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        print(decoded_token['role'])
        
        return jsonify({'valid': True, 'username': decoded_token['username'],'role': decoded_token['role']})
    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403
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
    semester = "Ganjil" if month < 7 else "Genap"
    if month < 7:
        tahun_ajaran = f"{year-1}/{year}"
    else:
        tahun_ajaran = f"{year}/{year+1}"
    return semester, tahun_ajaran

@app.before_request
def create_automatic_bills():
    semester, tahun_ajaran = get_semester_and_year()

    bulan_mapping = [
        "Januari", "Februari", "Maret", "April", "Mei", "Juni",
        "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ]
    bulan_sekarang = bulan_mapping[datetime.now().month - 1]

    spp_bulanan = f"SPP Bulanan - {bulan_sekarang} {tahun_ajaran} {semester}"
    ujian_tahunan = f"Uang Ujian {tahun_ajaran} {semester}"

    semua_siswa = siswa.query.all()

    for s in semua_siswa:
        # Cek apakah tagihan SPP sudah ada untuk siswa ini
        existing_spp = tagihan.query.filter_by(
            user_email=s.email,
            deskripsi=spp_bulanan,
            semester=semester,
            tahun_ajaran=tahun_ajaran
        ).first()

        if not existing_spp:
            tagihan_spp = tagihan(
                user_email=s.email,
                deskripsi=spp_bulanan,
                total=10000,
                semester=semester,
                tahun_ajaran=tahun_ajaran,
                created_at=datetime.now()
            )
            db.session.add(tagihan_spp)

        # Cek apakah tagihan Ujian sudah ada untuk siswa ini
        existing_ujian = tagihan.query.filter_by(
            user_email=s.email,
            deskripsi=ujian_tahunan,
            semester=semester,
            tahun_ajaran=tahun_ajaran
        ).first()

        if not existing_ujian:
            tagihan_ujian = tagihan(
                user_email=s.email,
                deskripsi=ujian_tahunan,
                total=1000000,
                semester=semester,
                tahun_ajaran=tahun_ajaran,
                created_at=datetime.now()
            )
            db.session.add(tagihan_ujian)

    db.session.commit()

def is_valid_email(email):
    regex = r'^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w+$'
    return re.match(regex, email)

from . import api_admin, login, midtrans, view, api_guru, api_murid
