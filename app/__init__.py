from flask import Flask,jsonify,request,session,render_template,g,send_from_directory,abort
from flask_sqlalchemy import SQLAlchemy
from flask_mysqldb import MySQL
from flask_jwt_extended import JWTManager
from flask_security import Security, SQLAlchemyUserDatastore, UserMixin, RoleMixin
from flask_bcrypt import Bcrypt
from datetime import timedelta, datetime
import os

app = Flask(__name__)
app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = ''
app.config['MYSQL_DB'] = 'bell_web_sistem'
project_directory = os.path.abspath(os.path.dirname(__file__))
upload_folder = os.path.join(project_directory, 'static', 'image')
upload_nota = os.path.join(project_directory, 'static', 'nota')
app.config['UPLOAD_FOLDER'] = upload_folder 
app.config['UPLOAD_NOTA'] = upload_nota
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root@localhost/bell_web_sistem'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
app.config['SECRET_KEY'] = 'bukan rahasia'
app.config['SECURITY_PASSWORD_HASH'] = 'bcrypt'
app.config['SECURITY_PASSWORD_SALT'] = b'asahdjhwquoyo192382qo'
# Nonaktifkan rute login bawaan
app.config['SECURITY_LOGIN_URL'] = None
app.config['SECURITY_LOGOUT_URL'] = '/logout'  
app.config['JWT_SECRET_KEY'] = 'qwdu92y17dqsu81'
app.config['JWT_ACCESS_TOKEN_EXPIRES'] = timedelta(days=1)
app.config['PERMANENT_SESSION_LIFETIME'] = timedelta(days=1)

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
    email = db.Column(db.String(255), unique=True, nullable=False)  # Fix disini
    active = db.Column(db.Boolean, default=True)
    fs_uniquifier = db.Column(db.String(64), unique=True, nullable=False)

    roles = db.relationship('Role', secondary='user_roles', 
                            primaryjoin='User.id == UserRoles.user_id',
                            secondaryjoin='Role.id == UserRoles.role_id',
                            backref=db.backref('users', lazy='dynamic'))
 
class Pengumuman(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    judul_pengumuman = db.Column(db.String(100), unique=True)
    penulis_pengumuman = db.Column(db.String(100))
    jenis_pengumuman = db.Column(db.String(100))
    isi_pengumuman = db.Column(db.Text)

class Laporan(db.Model, UserMixin):
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    judul_laporan = db.Column(db.String(100), unique=True)
    penulis_laporan = db.Column(db.String(100))
    jenis_laporan = db.Column(db.String(100))
    isi_laporan = db.Column(db.Text)

class AmpuMapel(db.Model):
    id_ampu = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date)
    id_semester = db.Column(db.String(1), db.ForeignKey('semester.id_semester'), nullable=False)
    id_mapel = db.Column(db.String(3), db.ForeignKey('mapel.id_mapel'), nullable=False)
    nip = db.Column(db.Integer, db.ForeignKey('guru.nip'), nullable=False)
    id_tahun_akademik = db.Column(db.String(4), db.ForeignKey('tahun_akademik.id_tahun_akademik'), nullable=False)
    id_pembagian = db.Column(db.Integer, db.ForeignKey('pembagian_kelas.id_pembagian'))

class Berita(db.Model):
    id_berita = db.Column(db.Integer, primary_key=True)
    judul = db.Column(db.String(35), nullable=False)
    isi = db.Column(db.String(255), nullable=False)
    nip = db.Column(db.Integer, db.ForeignKey('guru.nip'), nullable=False)

class Gender(db.Model):
    id_gender = db.Column(db.String(1), primary_key=True)
    gender = db.Column(db.String(9), nullable=False)

class Guru(db.Model):
    nip = db.Column(db.Integer, primary_key=True)
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

class Kbm(db.Model):
    id_kbm = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date, nullable=False)
    materi = db.Column(db.String(35), nullable=False)
    sub_materi = db.Column(db.String(100))
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu'), nullable=False)

class Kehadiran(db.Model):
    id_kehadiran = db.Column(db.Integer, primary_key=True)
    id_keterangan = db.Column(db.String(1), db.ForeignKey('keterangan.id_keterangan'), nullable=False)
    id_kbm = db.Column(db.Integer, db.ForeignKey('kbm.id_kbm'), nullable=False)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis'), nullable=False)

class Kelas(db.Model):
    id_kelas = db.Column(db.String(6), primary_key=True)
    nama_kelas = db.Column(db.String(15), nullable=False)
    tingkat = db.Column(db.String(1), nullable=False)

class Keterangan(db.Model):
    id_keterangan = db.Column(db.String(1), primary_key=True)
    keterangan = db.Column(db.String(5), nullable=False)

class Mapel(db.Model):
    id_mapel = db.Column(db.String(3), primary_key=True)
    nama_mapel = db.Column(db.String(35), nullable=False)

class PembagianKelas(db.Model):
    id_pembagian = db.Column(db.Integer, primary_key=True)
    tanggal = db.Column(db.Date)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis'), nullable=False)
    id_kelas = db.Column(db.String(6), db.ForeignKey('kelas.id_kelas'), nullable=False)
    id_tahun_akademik = db.Column(db.String(4), db.ForeignKey('tahun_akademik.id_tahun_akademik'), nullable=False)
    nip = db.Column(db.Integer, db.ForeignKey('guru.nip'), nullable=False)

class Penilaian(db.Model):
    id_penilaian = db.Column(db.Integer, primary_key=True)
    tugas = db.Column(db.Integer)
    uts = db.Column(db.Integer)
    uas = db.Column(db.Integer)
    id_ampu = db.Column(db.Integer, db.ForeignKey('ampu_mapel.id_ampu'), nullable=False)
    nis = db.Column(db.Integer, db.ForeignKey('siswa.nis'), nullable=False)

class Semester(db.Model):
    id_semester = db.Column(db.String(1), primary_key=True)
    semester = db.Column(db.String(6), nullable=False)

class Siswa(db.Model):
    nis = db.Column(db.Integer, primary_key=True)
    nisn = db.Column(db.String(10))
    nama = db.Column(db.String(50), nullable=False)
    id_gender = db.Column(db.String(1), db.ForeignKey('gender.id_gender'), nullable=False)
    tempat_lahir = db.Column(db.String(20), nullable=False)
    tanggal_lahir = db.Column(db.Date, nullable=False)
    alamat = db.Column(db.String(125), nullable=False)
    no_hp = db.Column(db.String(15), nullable=False)
    email = db.Column(db.String(30), nullable=False)
    nama_ayah = db.Column(db.String(35), nullable=False)
    nama_ibu = db.Column(db.String(35), nullable=False)
    penghasilan_ayah = db.Column(db.Integer, nullable=False)
    penghasilan_ibu = db.Column(db.Integer, nullable=False)
    asal_sekolah = db.Column(db.String(30), nullable=False)
    id_status = db.Column(db.String(1), db.ForeignKey('status.id_status'), nullable=False)

class Status(db.Model):
    id_status = db.Column(db.String(1), primary_key=True)
    status = db.Column(db.String(20), nullable=False)

class TahunAkademik(db.Model):
    id_tahun_akademik = db.Column(db.String(4), primary_key=True)
    tahun_akademik = db.Column(db.String(9), nullable=False)
    mulai = db.Column(db.Date, nullable=False)
    sampai = db.Column(db.Date, nullable=False)

class Invoice(db.Model):
    __tablename__ = 'invoices'
    id = db.Column(db.Integer, primary_key=True)
    user_email = db.Column(db.String(120), nullable=False)
    description = db.Column(db.String(255))
    amount = db.Column(db.Float, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)

class Transaction(db.Model):
    __tablename__ = 'transactions'
    id = db.Column(db.Integer, primary_key=True)
    order_id = db.Column(db.String(100), unique=True, nullable=False)
    tagihan_id = db.Column(db.Integer, db.ForeignKey('invoices.id'), nullable=True)
    email = db.Column(db.String(120), nullable=False)
    amount = db.Column(db.Float, nullable=False)
    status = db.Column(db.String(50), default="pending")
    fraud_status = db.Column(db.String(50), nullable=True)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

jwt = JWTManager(app)
mysql = MySQL()
mysql.init_app(app)

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

from . import api_admin, login, midtrans, view
