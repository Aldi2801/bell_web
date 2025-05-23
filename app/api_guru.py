from . import app, db, is_valid_email, bcrypt, users_collection, mail, s
from flask import request, jsonify, url_for, render_template, render_template_string,session
from flask_mail import Message
from itsdangerous import BadSignature, SignatureExpired
import jwt, re, datetime, os 
from bson.objectid import ObjectId
@app.route('/manage_jadwal')
def view_manage_jadwal():
    schedule_collection = db["schedules"]
    schedule_id = ObjectId(os.getenv("SCHEDULE_ID"))
    teacher_map_id = ObjectId(os.getenv("TEACHER_MAP_ID"))
    schedule_data = schedule_collection.find_one({"_id": schedule_id})
    teacher_map_data = schedule_collection.find_one({"_id": teacher_map_id})

    # Format data jadwal
    formatted_schedule = [
        {
            "day": day["day"],
            "sessions": [
                {
                    "time": session["time"],
                    "period": session["period"],
                    "subjects": session["subjects"]
                }
                for session in day["sessions"]
            ]
        }
        for day in schedule_data["schedule"]
    ]

    # Format data kode guru dan mapel
    formatted_teacher_map = {
        "kodeGuru": [
            {next(iter(teacher)): teacher[next(iter(teacher))]} for teacher in teacher_map_data["kodeGuru"]
        ],
        "kodeMapel": [
            {next(iter(subject)): subject[next(iter(subject))]} for subject in teacher_map_data["kodeMapel"]
        ]
    }


    # Output hasil
    print("Formatted Schedule:")
    print(formatted_schedule)

    print("\nFormatted Teacher Map:")
    print(formatted_teacher_map)
    users = list(db.users.find({"role": "murid"}, {"_id": 0}))
    kelas = list(db.kelas.find().sort("nama", 1))  # Urutkan berdasarkan nama ASC
    return render_template("manage_jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map, users=users, kelas=kelas)

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
    cek_username =  users_collection.find_one({'username':username})
    if cek_username:
        return jsonify({"msg": "Username already exists"}), 400
    cek_email =  users_collection.find_one({'email':email})
    if cek_email:
        return jsonify({"msg": "Email already exists"}), 400
    # Hash password
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    
    # Simpan user baru
    user = {
        'username': username,
        'password': hashed_password,
        'nama_lengkap': nama_lengkap,
        'email': email,
        'verify_email': False,
        'role':'guru'
    }
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
        result = users_collection.insert_one(user)
        if result.inserted_id:
            return jsonify({'msg': 'User registered successfully, Please check your email for validation'}), 201
        else:
            return jsonify({'error': 'Failed to register user'}), 500
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500

@app.route('/edit_guru/<id>', methods=['PUT'])
def edit_guru(id):
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

@app.route('/hapus_guru/<id>', methods=['DELETE'])
def delete_guru(id):
    result = db.attendance.delete_one({"_id": ObjectId(id)})

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