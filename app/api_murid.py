from . import app, db, get_semester_and_year, tagihan, transaksi
from flask import request, jsonify
import jwt

@app.route('/get_menu_pembayaran')
def get_menu_pembayaran():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token is missing'}), 403

    try:
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        user_email = decoded_token['email']
        role = decoded_token['role']
        # Ambil semester dan tahun ajaran saat ini
        semester, tahun_ajaran = get_semester_and_year()

        # Ambil semua tagihan user untuk semester dan tahun ajaran aktif
        all_tagihan = tagihan.query.filter_by(
            user_email=user_email,
            semester=semester,
            tahun_ajaran=tahun_ajaran
        ).all()
        if role == 'murid':
            # Ambil transaksi yang sudah lunas
            paid_transactions = transaksi.query.filter_by(
                email=user_email,
                status='settlement'
            ).all()
        else:
            paid_transactions = transaksi.query.filter_by(
                status='settlement'
            ).all()            

        # Ambil id_tagihan yang sudah lunas
        paid_tagihan_ids = {tr.id_tagihan for tr in paid_transactions if tr.id_tagihan is not None}

        # Siapkan daftar tagihan lengkap dengan status
        result_tagihan = [
            {
                'id_tagihan': t.id_tagihan,
                'deskripsi': t.deskripsi,
                'total': t.total,
                'semester': t.semester,
                'tahun_ajaran': t.tahun_ajaran,
                'created_at': t.created_at.isoformat(),
                'status': 'Lunas' if t.id_tagihan in paid_tagihan_ids else 'Belum Lunas'
            }
            for t in all_tagihan
        ]

        return jsonify(result_tagihan)

    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403
