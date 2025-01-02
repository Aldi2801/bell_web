from flask import Flask, request, jsonify, render_template, abort
from pymongo.mongo_client import MongoClient
from pymongo.server_api import ServerApi
from flask_bcrypt import Bcrypt
from flask_cors import CORS
from flask_mail import Mail
from itsdangerous import URLSafeTimedSerializer
import jwt, os, datetime

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
# uri = "mongodb+srv://rizkydwisaputrar1:iqyCCfGc7vg9j_r@halosus.mwdayc6.mongodb.net/?retryWrites=true&w=majority&appName=halosus"
# #lokal ALDI
# #uri = "mongodb://localhost:27017/"

# # Create a new client and connect to the server
# client = MongoClient(uri, server_api=ServerApi('1'))

# # Send a ping to confirm a successful connection
# client.admin.command('ping')
# db = client.get_database('web_sekolah')
# users_collection = db.users

    
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

@app.route('/invalid')
def invalid():
    abort(404)
    
from flask import Flask, request, jsonify, render_template
import midtransclient
from .database import insert_transaction, get_transaction_by_id
from .config import MIDTRANS_SERVER_KEY, MIDTRANS_CLIENT_KEY

app = Flask(__name__)

if os.getenv('ENV') == 'production':
    url = "https://app.midtrans.com/snap/v1/transactions"
    server_key = os.getenv('Server_Key_Production')
else:
    url = "https://app.sandbox.midtrans.com/snap/v1/transactions"
    server_key = os.getenv('Server_Key_Sandbox')
import requests
import json
import base64
import time 


@app.route('/create-transaction', methods=['POST'])
def create_transaction():
    try:
        # Ambil data dari request
        data = request.json

        # Payload untuk Midtrans
        payload = {
            "transaction_details": {
                "order_id": f"ORDER-{int(time.time())}",
                "gross_amount": data['amount']
            },
            "customer_details": {
                "first_name": data['first_name'],
                "last_name": data['last_name'],
                "email": data['email']
            }
        }

        # Header untuk Midtrans
        headers = {
            "Authorization": f"Basic {base64.b64encode(server_key.encode()).decode()}",
            "Content-Type": "application/json"
        }

        # Kirim request ke Midtrans

        response = requests.post(
            url,
            headers=headers,
            data=json.dumps(payload)
        )

        # Debug response Midtrans
        print("Response status:", response.status_code)
        print("Response body:", response.json())

        # Jika sukses, kembalikan URL Redirect
        if response.status_code == 201:
            transaction = response.json()
            return jsonify({"redirect_url": transaction['redirect_url']})

        # Jika gagal, kembalikan error
        return jsonify({"error": "Failed to create transaction", "details": response.json()}), response.status_code

    except Exception as e:
        print("Error:", e)
        return jsonify({"error": "Internal server error", "details": str(e)}), 500
    
@app.route('/transaction/<transaction_id>', methods=['GET'])
def transaction_status(transaction_id):
    transaction = get_transaction_by_id(transaction_id)
    if not transaction:
        return jsonify({'error': 'Transaction not found'}), 404
    return jsonify(transaction)

@app.route('/payment-success', methods=['GET'])
def payment_success():
    return render_template('payment_success.html')

@app.route('/')
def index():
    return render_template('coba.html')
