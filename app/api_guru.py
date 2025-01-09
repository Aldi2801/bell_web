from . import app, db
from flask import request, jsonify, url_for, render_template
from itsdangerous import BadSignature, SignatureExpired
import jwt, re, datetime
from bson.objectid import ObjectId
@app.route('/manage_jadwal')
def view_manage_jadwal():
    schedule_collection = db["schedules"]

    # ONLINE
    #schedule_id = ObjectId('67334170f71fdf42ce9446cc')
    #teacher_map_id = ObjectId('673341ddf71fdf42ce9446cd')
    #LOKAL RIZKY
    schedule_id = ObjectId('6776ae66776ad9915a0728d6')
    teacher_map_id = ObjectId('6776ae75776ad9915a0728d7')
    #LOKAL ALDI
    #schedule_id = ObjectId('6765893afbd3a1d8ed2dd985')
    #teacher_map_id = ObjectId('6765895ffbd3a1d8ed2dd986')

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
    kelas = list(db.kelas.find())
    return render_template("manage_jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map, kelas= kelas )

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
