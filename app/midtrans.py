from flask import request, jsonify, render_template, session
import os, uuid, base64, json, requests, jwt
from . import app, db, Tagihan, Transaksi , Siswa, TahunAkademik,User
print(os.getenv('ENV') )
if os.getenv('ENV') == 'production':
    url = "https://app.midtrans.com/snap/v1/transactions"
    server_key = os.getenv('Server_Key_Production')
else:
    url = "https://app.sandbox.midtrans.com/snap/v1/transactions"
    server_key = os.getenv('Server_Key_Sandbox')

@app.route('/create-transaction', methods=['POST'])
def create_transaction():
    try:
        token = request.headers.get('Authorization')
        data = {}
        if token:
            decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            email = decoded_token.get('email', 'anonymous@mail.co')
            data_user = User.query.filter_by(email=email).first()
            data_siswa = Siswa.query.filter_by(user_id=data_user.id).first()
            full_name = data_siswa.nama
            if not full_name:
                return jsonify({'valid': False, 'message': 'Full name missing in token'}), 400

            data['first_name'] = full_name.split()[0]
            data['last_name'] = full_name.split()[-1] if len(full_name.split()) > 1 else ''
            data['email'] = email
            data['amount'] = request.json.get('amount', 0)
            tagihan_id = request.json.get('tagihan_id', 0)
        else:
            data = request.json
            data_user = User.query.filter_by(email=email).first()
            new_tagihan = Tagihan(
                user_id=data_user.id,
                deskripsi="SPP dan biaya lainnya",
                total=data['amount']
            )
            db.session.add(new_tagihan)
            db.session.commit()
            tagihan_id = new_tagihan.id

        if not data.get('amount'):
            return jsonify({'error': 'Amount is required'}), 400

        order_id = f"ORDER-{uuid.uuid4()}"
        callback_url = f"http://127.0.0.1:4040/menu_pembayaran?status_code=200&order_id={order_id}&transaction_status=paid"
        payload = {
            "transaction_details": {
                "order_id": order_id,
                "gross_amount": data['amount']
            },
            "customer_details": {
                "first_name": data['first_name'],
                "last_name": data['last_name'],
                "email": data['email']
            },
            "callbacks": {
                "finish": callback_url
            }
        }

        headers = {
            "Authorization": f"Basic {base64.b64encode(server_key.encode()).decode()}",
            "Content-Type": "application/json"
        }

        response = requests.post(url, headers=headers, data=json.dumps(payload))

        if response.status_code == 201:
            transaction = response.json()
            new_transaction = Transaksi(
                kode_order = order_id,
                id_tagihan = tagihan_id,
                email = data['email'],
                total = data['amount'],
                status = "pending"
            )
            db.session.add(new_transaction)
            db.session.commit()
            return jsonify({"redirect_url": transaction['redirect_url']})

        return jsonify({"error": "Failed to create transaction", "details": response.json()}), response.status_code

    except jwt.ExpiredSignatureError:
        return jsonify({'error': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'error': 'Invalid token'}), 403
    except Exception as e:
        print("Error:", e)
        return jsonify({"error": "Internal server error", "details": str(e)}), 500

@app.route('/midtrans-webhook', methods=['POST'])
def midtrans_webhook():
    try:
        data = request.json
        order_id = data.get('order_id')
        status = data.get('transaction_status')
        fraud_status = data.get('fraud_status')

        if not order_id:
            return jsonify({'error': 'Invalid notification'}), 400

        transaction = Transaksi.query.filter_by(kode_order=order_id).first()
        if transaction:
            transaction.status = status
            transaction.fraud_status = fraud_status
            db.session.commit()
            return jsonify({'message': 'Transaction updated successfully'}), 200
        else:
            return jsonify({'message': 'Transaction not found'}), 404
    except Exception as e:
        print("Webhook Error:", e)
        return jsonify({'error': 'Internal server error', 'details': str(e)}), 500

@app.route('/menu_pembayaran')
def view_menu_pembayaran():
    status_code = request.args.get('status_code', 'undefined')
    order_id = request.args.get('order_id', 'undefined')
    transaction_status = request.args.get('transaction_status', 'undefined')

    if status_code == "200":
        transaction = Transaksi.query.filter_by(kode_order=order_id).first()
        if transaction:
            transaction.status = transaction_status
            db.session.commit()
            print('Transaction updated successfully')
        else:
            print('Transaction not found or already updated')
    data_siswa = Siswa.query.all()
    tahun_ajaran = TahunAkademik.query.all()
    role = session.get('role')
    if role != 'murid':        
        btn_tambah = True
        title = "Manage pembayaran"
        title_data = "Pembayaran"
    else:
        btn_tambah = False
        title = "Pembayaran"
        title_data = "Pembayaran"
    return render_template("menu_pembayaran.html", siswa = data_siswa, tahun_ajaran = tahun_ajaran, 
    btn_tambah = btn_tambah, title = title, title_data = title_data)

