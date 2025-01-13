from . import app, db
from flask import request, jsonify, url_for, render_template
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

# Endpoint untuk mendapatkan data murid dan kelas
@app.route('/get-data', methods=['GET'])
def get_data():
    users = list(db.users.find({"role": "murid"}, {"_id": 0}))
    kelas = list(db.kelas.find())
    return jsonify({"students": users, "classes": kelas})

# Endpoint untuk menyimpan data kehadiran
@app.route('/save-attendance', methods=['POST'])
def save_attendance():
    data = request.json
    if not all(key in data for key in ("studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400
    
    db.attendance.insert_one(data)
    return jsonify({"message": "Attendance saved successfully"}), 201

# Endpoint untuk mendapatkan data kehadiran
@app.route('/get-attendance', methods=['GET'])
def get_attendance():
    attendance = list(db.attendance.find({}, {"_id": 0}))
    return jsonify(attendance)
