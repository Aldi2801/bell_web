from . import app, db, is_valid_email, bcrypt, mail, s, User, kelas, siswa, guru, mapel, JadwalPelajaran
from flask import request, jsonify, url_for, render_template, render_template_string,session
from flask_mail import Message
from sqlalchemy import case
from itsdangerous import BadSignature, SignatureExpired
import jwt, re, datetime, os, json, ast
from bson.objectid import ObjectId
from collections import defaultdict

@app.route('/manage_jadwal')
def view_manage_jadwal():
    # Urutan hari
    hari_order = case(
        (JadwalPelajaran.day == 'Senin', 1),
        (JadwalPelajaran.day == 'Selasa', 2),
        (JadwalPelajaran.day == 'Rabu', 3),
        (JadwalPelajaran.day == 'Kamis', 4),
        (JadwalPelajaran.day == 'Jumat', 5),
        (JadwalPelajaran.day == 'Sabtu', 6),
        (JadwalPelajaran.day == 'Minggu', 7),
        else_=8
    )

    # Ambil semua jadwal dalam 1 query
    results = JadwalPelajaran.query.order_by(hari_order, JadwalPelajaran.period).all()

    # Buat struktur data jadwal terformat
    grouped_schedule = defaultdict(list)
    for r in results:
        grouped_schedule[r.day].append({
            "time": r.time,
            "period": r.period,
            "subjects": ast.literal_eval(r.subject) if isinstance(r.subject, str) else r.subject
        })

    formatted_schedule = [
        {"day": day, "sessions": grouped_schedule[day]}
        for day in sorted(grouped_schedule, key=lambda d: ['Senin','Selasa','Rabu','Kamis','Jumat','Sabtu','Minggu'].index(d))
    ]

    # Ambil guru dan mapel
    guru_list = guru.query.order_by(guru.nama.asc()).all()
    mapel_list = mapel.query.order_by(mapel.nama_mapel.asc()).all()

    formatted_teacher_map = {
        "kodeGuru": [{"inisial": g.inisial, "nama": g.nama} for g in guru_list],
        "kodeMapel": [{"id_mapel": m.id_mapel, "nama": m.nama_mapel} for m in mapel_list],
    }

    # Ambil siswa dan kelas
    users = siswa.query.all()
    data_kelas = kelas.query.order_by(kelas.nama_kelas.asc()).all()
    kelas_dict = [{"id_kelas": k.id_kelas, "nama_kelas": k.nama_kelas} for k in data_kelas]

    return render_template(
        "manage_jadwal.html",
        schedule=formatted_schedule,
        kode_guru=formatted_teacher_map["kodeGuru"],
        kode_mapel=formatted_teacher_map["kodeMapel"],
        users=users,
        kelas=kelas_dict
    )

# Endpoint untuk menyimpan data kehadiran
@app.route('/tambah_kehadiran', methods=['POST'])
def save_attendance():
    data = request.json
    if not all(key in data for key in ("studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400
    
    db.attendance.insert_one(data)
    return jsonify({"message": "Attendance saved successfully"}), 201

@app.route('/edit_kehadiran/<id>', methods=['PUT'])
def edit_attendance(id):
    data = request.json
    if not all(key in data for key in ("studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400

    result = db.attendance.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
            "studentName": data["studentName"],
            "class": data["class"],
            "date": data["date"],
            "status": data["status"]
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_kehadiran/<id>', methods=['DELETE'])
def delete_attendance(id):
    result = db.attendance.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200

# Endpoint untuk menyimpan data kehadiran Ujian
@app.route('/tambah_kehadiran_ujian', methods=['POST'])
def save_test_attendance():
    data = request.json
    if not all(key in data for key in ("testName","subject","studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400
    
    db.test_attendance.insert_one(data)
    return jsonify({"message": "Attendance saved successfully"}), 201

@app.route('/edit_kehadiran_ujian/<id>', methods=['PUT'])
def edit_test_attendance(id):
    data = request.json
    if not all(key in data for key in ("testName","subject","studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400

    result = db.test_attendance.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
            "testName":data["testName"],
            "subject":data["subject"],
            "studentName": data["studentName"],
            "class": data["class"],
            "date": data["date"],
            "status": data["status"]
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_kehadiran_ujian/<id>', methods=['DELETE'])
def delete_test_attendance(id):
    result = db.test_attendance.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200

# Endpoint untuk menyimpan data guru
@app.route('/tambah_guru', methods=['POST'])
def save_guru():
    data = request.get_json()

    username = data['username']
    password = data['password']

    nama_lengkap = data['nama_lengkap']
    email = data['email']

    re_password = data['re_password']

    if not username or not email or not password or not re_password:
        return jsonify({"msg": "All fields are required"}), 400

    if not is_valid_email(email):
        return jsonify({"msg": "Invalid email format"}), 400

    if password != re_password:
        return jsonify({"msg": "Passwords do not match"}), 400
    cek_username =  User.query.find(username=username)
    if cek_username:
        return jsonify({"msg": "Username already exists"}), 400
    cek_email =  User.query.find(email=email)
    if cek_email:
        return jsonify({"msg": "Email already exists"}), 400
    # Hash password
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    
    # Simpan user baru
    user = User(
        username= username,
        password= hashed_password,
        nama_lengkap= nama_lengkap,
        email= email,
        verify_email= False,
        role='guru'
    )
    try:
        token = s.dumps(email, salt='email-confirm')
        conf_email_url = url_for('confirm_email', token=token, _external=True)
        email_body = render_template_string('''
            Hello {{ username }},
            
            Anda menerima email ini, karena kami memerlukan verifikasi email untuk akun Anda agar aktif dan dapat digunakan.
            
            Silakan klik tautan di bawah ini untuk verifikasi email Anda. Tautan ini akan kedaluwarsa dalam 1 jam.
            
            confirm your email: {{ conf_email_url }}
            
            hubungi dukungan jika Anda memiliki pertanyaan.
            
            Untuk bantuan lebih lanjut, silakan hubungi tim dukungan kami di developer masteraldi2809@gmail.com .
            
            Salam Hangat,
            
            Admin
        ''', username=username,  conf_email_url=conf_email_url)

        msg = Message('Confirmasi Email Anda',
                    sender='masteraldi2809@gmail.com', recipients=[email])

        msg.body = email_body
        mail.send(msg)
        db.session.add(user)
        db.session.commit()
        return jsonify({'msg': 'User registered successfully, Please check your email for validation'}), 201
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500

@app.route('/edit_guru/<id>', methods=['PUT'])
def edit_guru(id):
    data = request.json
    hashed_password = bcrypt.generate_password_hash(data["password"]).decode('utf-8')
    result = User.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
            "username":data['username'],
            "password":hashed_password,
            "nama_lengkap":data['nama_lengkap'],
            "email":data['email']

        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_guru/<id>', methods=['DELETE'])
def delete_guru(id):
    result = Users.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200

# Endpoint untuk menyimpan data guru Ujian
@app.route('/tambah_guru_ujian', methods=['POST'])
def save_test_guru():
    data = request.json
    if not all(key in data for key in ("testName","subject","studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400
    
    db.test_attendance.insert_one(data)
    return jsonify({"message": "Attendance saved successfully"}), 201

@app.route('/edit_guru_ujian/<id>', methods=['PUT'])
def edit_test_guru(id):
    data = request.json
    if not all(key in data for key in ("testName","subject","studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400

    result = db.test_attendance.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
            "testName":data["testName"],
            "subject":data["subject"],
            "studentName": data["studentName"],
            "class": data["class"],
            "date": data["date"],
            "status": data["status"]
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_guru_ujian/<id>', methods=['DELETE'])
def delete_test_guru(id):
    result = db.test_attendance.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200


@app.route('/tambah_ubah_jadwal', methods=['POST'])
def tambah_ubah_jadwal():
    data = request.get_json()

    day = data.get('day')
    time = data.get('time')
    period = data.get('period')
    subject = data.get('subject')  # list of strings

    if not (day and time and period is not None and subject):
        return jsonify({'status': 'error', 'message': 'Data tidak lengkap'}), 400

    # Cek apakah data dengan day + period sudah ada
    existing = JadwalPelajaran.query.filter_by(day=day, period=period).first()

    if existing:
        # Update
        existing.time = time
        existing.subject = json.dumps(subject)  # simpan sebagai string JSON
        msg = "Jadwal berhasil diperbarui"
    else:
        # Insert baru
        new_schedule = JadwalPelajaran(
            day=day,
            time=time,
            period=period,
            subject=json.dumps(subject)
        )
        db.session.add(new_schedule)
        msg = "Jadwal berhasil ditambahkan"

    db.session.commit()
    return jsonify({'status': 'success', 'message': msg})

