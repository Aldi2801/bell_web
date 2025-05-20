from . import app, db, get_semester_and_year
from flask import request, jsonify, render_template, redirect, url_for
import jwt
from bson.objectid import ObjectId
@app.route('/get_menu_pembayaran')
def get_menu_pembayaran():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token is missing'}), 403
    try:
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        print(decoded_token['role'])
        tagihan_collection = db.tagihan
        transaction_collection = db.transactions

        # Ambil semester dan tahun ajaran saat ini
        semester, tahun_ajaran = get_semester_and_year()

        # Dapatkan semua data tagihan dan konversi ObjectId ke string
        all_tagihan = [
            {**tagihan, "_id": str(tagihan["_id"])}
            for tagihan in tagihan_collection.find({"semester": semester, "tahun_ajaran": tahun_ajaran})
        ]

        # Cari tagihan yang sudah dibayar
        paid_transactions = transaction_collection.find({"status": "settlement", "email": decoded_token['email']})
        paid_tagihan_ids = {str(transaction["tagihan_id"]) for transaction in paid_transactions}

        # Filter tagihan yang belum dibayar dan konversi ObjectId ke string
        unpaid_tagihan = [
            tagihan for tagihan in all_tagihan if tagihan["_id"] not in paid_tagihan_ids
        ]

        return jsonify(unpaid_tagihan)
    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403