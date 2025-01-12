from flask import Flask, request, jsonify, render_template, abort
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_mail import Mail
from itsdangerous import URLSafeTimedSerializer
import jwt, os, datetime
from datetime import datetime

app = Flask(__name__)
bcrypt = Bcrypt(app)
CORS(app) 
app.config['SECRET_KEY'] = 'isahc8u2e0921e12osa00-=[./vds]'  # Ganti dengan secret key
app.config['JWT_SECRET_KEY'] = os.getenv('JWT_SECRET_KEY', 'qwdu92y17wesu81')
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT=587,
    MAIL_USE_TLS=True,
    MAIL_USERNAME=os.getenv('MAIL_USERNAME', 'masteraldi2809@gmail.com'),
    MAIL_PASSWORD=os.getenv('MAIL_PASSWORD', 'xthezwlpdajgtlav')
)

mail = Mail(app)
s = URLSafeTimedSerializer(app.config['JWT_SECRET_KEY'])
uri = "mongodb+srv://rizkydwisaputrar1:iqyCCfGc7vg9j_r@halosus.mwdayc6.mongodb.net/?retryWrites=true&w=majority&appName=halosus"
#lokal ALDI
#uri = "mongodb://localhost:27017/"

# Create a new client and connect to the server
client = MongoClient(uri, server_api=ServerApi('1'))

# Send a ping to confirm a successful connection
client.admin.command('ping')
db = client.get_database('web_sekolah')
users_collection = db.users

    
# Data seeder kelas
kelas_data = [
    {"nama": "7A"},
    {"nama": "7B"},
    {"nama": "7C"},
    {"nama": "8A"},
    {"nama": "8B"},
    {"nama": "8C"},
    {"nama": "9A"},
    {"nama": "9B"}
]

# Menghapus data lama dan memasukkan data baru
db.kelas.delete_many({})  # Menghapus semua data dalam koleksi
db.kelas.insert_many(kelas_data)  # Memasukkan data baru

# Fungsi untuk verifikasi token
@app.route('/verify-token', methods=['POST'])
def verify_token():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token is missing'}), 403
    try:
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        print(decoded_token['role'])
        
        return jsonify({'valid': True, 'username': decoded_token['username'],'nama_lengkap': decoded_token['nama_lengkap'],'role': decoded_token['role']})
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

@app.route('/invalid')
def invalid():
    abort(404)

# Fungsi untuk menentukan semester berdasarkan bulan
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
    tagihan_collection = db.tagihan
    semester, tahun_ajaran = get_semester_and_year()

    # Tentukan bulan dan pembayaran
    bulan_mapping = [
        "Januari", "Februari", "Maret", "April", "Mei", "Juni",
        "Juli", "Agustus", "September", "Oktober", "November", "Desember"
    ]
    bulan_sekarang = bulan_mapping[datetime.now().month - 1]

    # Periksa dan buat tagihan bulanan (SPP)
    spp_bulanan = f"SPP Bulanan - {bulan_sekarang} {tahun_ajaran} {semester}"
    if not tagihan_collection.find_one({"jenis_pembayaran": spp_bulanan}):
        tagihan_collection.insert_one({
            "jenis_pembayaran": spp_bulanan,
            "harga": 500000,
            "bulan": bulan_sekarang,
            "semester": semester,
            "tahun_ajaran": tahun_ajaran,
            "created_at": datetime.now()
        })

    # Periksa dan buat tagihan tahunan (Uang Ujian)
    uang_ujian = f"Uang Ujian {tahun_ajaran} {semester}"
    if not tagihan_collection.find_one({"jenis_pembayaran": uang_ujian}):
        tagihan_collection.insert_one({
            "jenis_pembayaran": uang_ujian,
            "harga": 1000000,
            "semester": semester,
            "tahun_ajaran": tahun_ajaran,
            "created_at": datetime.now()
        })

from . import api_guru, api_login, api_murid, view, midtrans
