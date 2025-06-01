from . import app, db, is_valid_email, bcrypt, mail, s, User
from flask import request, jsonify, url_for, render_template, render_template_string,session
from flask_mail import Message
from itsdangerous import BadSignature, SignatureExpired
import jwt, re, datetime, os, json
from bson.objectid import ObjectId
@app.route('/manage_jadwal')
def view_manage_jadwal():
    schedule_data = {}
    # Ambil path absolut dari direktori saat ini (tempat file python ini berada)
    BASE_DIR = os.path.dirname(os.path.abspath(__file__))

    # Gabungkan dengan nama file JSON
    JADWAL_PATH = os.path.join(BASE_DIR, 'jdwal.json')

    # Baca isi file JSON
    with open(JADWAL_PATH, 'r', encoding='utf-8') as f:
        schedule_data = {}
        schedule_data['schedule'] = json.load(f)
    teacher_map_data = {}
    teacher_map_data["kodeGuru"]= [
        {
        "K1": "H. Jamar, S.Pd.I"
        },
        {
        "K8": "H. Hurwiyati, S.Pd"
        },
        {
        "K11": "Titik Eko Purwati, S.Pd"
        },
        {
        "K15": "Biyanto, S.Pd"
        },
        {
        "L6": "Ulinnuha, S.Pd.I"
        },
        {
        "L9": "Purnadi, S.Pd.S"
        },
        {
        "L10": "Nur Arifin, S.Pd.I"
        },
        {
        "F15": "Riski Arofiyah, S.Pd"
        }
    ],
    teacher_map_data["kodeMapel"]= [
        {
        "K1": "Bahasa Indonesia"
        },
        {
        "K8": "Matematika"
        },
        {
        "K11": "IPA"
        },
        {
        "K15": "IPS"
        },
        {
        "L6": "Bahasa Inggris"
        },
        {
        "L9": "Bahasa Daerah"
        },
        {
        "L10": "Seni Budaya"
        },
        {
        "L12": "PJOK"
        },
        {
        "G4": "Keterampilan (Khot)"
        },
        {
        "G15": "Tahfidz"
        },
        {
        "H12": "Nahwu"
        },
        {
        "F7": "Amaliyah Ibadah"
        },
        {
        "F9": "Kitab Kuning"
        }
    ]
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
    users = list(db.users.query.all())
    kelas = list(db.kelas.query.order_by(kelas.nama_kelas.asc()).all()) # Urutkan berdasarkan nama ASC
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
    cek_username =  users.query.find(username=username)
    if cek_username:
        return jsonify({"msg": "Username already exists"}), 400
    cek_email =  users.query.find(email=email)
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
    result = db.users.update_one(
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
    result = db.users.delete_one({"_id": ObjectId(id)})

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
    data = request.json
    if not all(key in data for key in ("day", "time", "period", "subject" )):
        return jsonify({"error": "Invalid data"}), 400

    result = db.test_attendance.update_one(
        {"day": day,
        "time": time},
        {"$set": {
            "period":data["testName"],
            "subject":data["subject"],
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200
