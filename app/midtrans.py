from flask import Flask, request, jsonify, render_template
import midtransclient
from .database import insert_transaction, get_transaction_by_id
import os, jwt, requests, json, base64, time 
from . import app, db

if os.getenv('ENV') == 'production':
    url = "https://app.midtrans.com/snap/v1/transactions"
    server_key = os.getenv('Server_Key_Production')
else:
    url = "https://app.sandbox.midtrans.com/snap/v1/transactions"
    server_key = os.getenv('Server_Key_Sandbox')

from datetime import datetime

invoices = db['invoices']
transactions = db['transactions']

@app.route('/create-transaction', methods=['POST'])
def create_transaction():
    try:
        # Periksa token dari header
        token = request.headers.get('Authorization')
        data = {}

        if token:
            # Decode token untuk mendapatkan detail user
            decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            full_name = decoded_token.get('nama_lengkap', '')

            if not full_name:
                return jsonify({'valid': False, 'message': 'Full name missing in token'}), 400

            data['first_name'] = full_name.split()[0] if len(full_name.split()) > 0 else ''
            data['last_name'] = full_name.split()[-1] if len(full_name.split()) > 1 else ''
            data['email'] = decoded_token.get('email', 'anonymous@mail.co')
            data['amount'] = request.json.get('amount', 0)  # Pastikan nilai amount tersedia
            invoice_id = request.json.get('tagihan_id', 0)
        else:
            # Ambil data langsung dari request jika token tidak tersedia
            data = request.json
            # Simpan tagihan ke MongoDB (koleksi invoices)
            invoice = {
                "user_email": data['email'],
                "description": "SPP dan biaya lainnya",
                "amount": data['amount'],
                "created_at": datetime.utcnow()
            }
            invoice_id = invoices.insert_one(invoice).inserted_id
        print(invoice_id)
        # Validasi amount
        if not data.get('amount'):
            return jsonify({'error': 'Amount is required'}), 400

        # Payload untuk Midtrans
        order_id = f"ORDER-{int(time.time())}"
        payload = {
            "transaction_details": {
                "order_id": order_id,
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
        response = requests.post(url, headers=headers, data=json.dumps(payload))

        # Debug response Midtrans
        print("Response status:", response.status_code)
        print("Response body:", response.json())

        # Jika sukses, simpan transaksi ke MongoDB (koleksi transactions)
        if response.status_code == 201:
            transaction = response.json()
            transaction_data = {
                "order_id": order_id,
                "tagihan_id": invoice_id,
                "email": data['email'],
                "amount": data['amount'],
                "status": "pending",
                "created_at": datetime.utcnow(),
                "updated_at": datetime.utcnow()
            }
            transactions.insert_one(transaction_data)
            return jsonify({"redirect_url": transaction['redirect_url']})

        # Jika gagal, kembalikan error
        return jsonify({"error": "Failed to create transaction", "details": response.json()}), response.status_code

    except jwt.ExpiredSignatureError:
        return jsonify({'error': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'error': 'Invalid token'}), 403
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
@app.route('/midtrans-webhook', methods=['POST'])
def midtrans_webhook():
    try:
        # Ambil data notifikasi dari Midtrans
        data = request.json
        order_id = data.get('order_id')
        status = data.get('transaction_status')
        fraud_status = data.get('fraud_status')

        # Validasi notifikasi (Opsional: periksa signature/key dari Midtrans)
        if not order_id:
            return jsonify({'error': 'Invalid notification'}), 400

        # Perbarui status transaksi di MongoDB
        result = transactions.update_one(
            {'order_id': order_id},
            {'$set': {
                'status': status,
                'fraud_status': fraud_status,
                'updated_at': datetime.utcnow()
            }}
        )

        if result.modified_count > 0:
            return jsonify({'message': 'Transaction updated successfully'}), 200
        else:
            return jsonify({'message': 'Transaction not found or already updated'}), 404
    except Exception as e:
        print("Webhook Error:", e)
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500
