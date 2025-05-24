from . import app, bcrypt, db, users_collection, get_semester_and_year
from flask import request, jsonify, render_template, redirect, url_for, session
import jwt, os
from datetime import datetime
from bson.objectid import ObjectId

@app.route('/')
def hello_fly():
    # return 'hello from fly.io'
    return redirect(url_for("view_dashboard"))
@app.route('/login')
def view_login():
    return render_template("login.html")
@app.route('/register')
def view_register():
    return render_template("register.html")
@app.route('/register_guru')
def view_register_guru():
    return render_template("register_guru.html")
@app.route('/tugas')
def view_tugas():
    tugas = list(db.tugas.find())
    print(tugas)
    return render_template("manage_tugas.html", tugas = tugas)
@app.route('/pengumuman')
def view_pengumuman():
    pengumuman = list(db.pengumuman.find())
    print(pengumuman)
    return render_template("manage_pengumuman.html", pengumuman = pengumuman)
@app.route('/manage_tugas')
def view_manage_tugas():
    tugas = list(db.tugas.find())
    print(tugas)
    return render_template("manage_tugas.html", tugas = tugas)
@app.route('/manage_pengumuman')
def view_manage_pengumuman():
    pengumuman = list(db.pengumuman.find())
    print(pengumuman)
    return render_template("manage_pengumuman.html", pengumuman = pengumuman)
@app.route('/manage_laporan')
def view_manage_laporan():
    laporan = list(db.laporan.find())
    print(laporan)
    return render_template("manage_laporan.html", laporan = laporan)
def find_current_period(sesi_list, current_time):
    for sesi in sesi_list:
        jam_mulai, jam_selesai = sesi["jam"].split(" - ")
        start = datetime.strptime(jam_mulai, "%H.%M").time()
        end = datetime.strptime(jam_selesai, "%H.%M").time()
        if start <= current_time <= end:
            return sesi
    return None
@app.route('/dashboard')
def view_dashboard():
    mapel_guru =""
    # if session['role']=='guru':
    #     kode_guru = session['kode_guru']
    #     sekarang = datetime.now()
    #     hari = sekarang.strftime("%A")  # English: Monday, Tuesday
    #     hari_dict = {
    #         "Monday": "Senin",
    #         "Tuesday": "Selasa",
    #         "Wednesday": "Rabu",
    #         "Thursday": "Kamis",
    #         "Friday": "Jum'at",
    #         "Saturday": "Sabtu",
    #         "Sunday": "Minggu"
    #     }
    #     hari = hari_dict.get(hari, hari)

    #     jam_sekarang = sekarang.time()

    #     Ambil jadwal hari ini
    #     print(hari)
            
    #     schedule_collection = db["schedules"]
    #     schedule_id = ObjectId(os.getenv("SCHEDULE_ID"))
    #     teacher_map_id = ObjectId(os.getenv("TEACHER_MAP_ID"))
    #     schedule_data = schedule_collection.find_one({"_id": schedule_id})
    #     teacher_map_data = schedule_collection.find_one({"_id": teacher_map_id})

    #     Format data jadwal
    #     formatted_schedule = [
    #         {
                
    #             "day": day["day"] if day["day"] == hari else '' ,
    #             "sessions": [
    #                 {
    #                     "time": session["time"] if session["time"] == jam_sekarang else '',
    #                     "period": session["period"],
    #                     "subjects": session["subjects"]
    #                 }
    #                 for session in day["sessions"]
    #             ]
    #         }
    #         for day in schedule_data["schedule"]
    #     ]

    #     Format data kode guru dan mapel
    #     formatted_teacher_map = {
    #         "kodeGuru": [
    #             {next(iter(teacher)): teacher[next(iter(teacher))]} for teacher in teacher_map_data["kodeGuru"]
    #         ],
    #         "kodeMapel": [
    #             {next(iter(subject)): subject[next(iter(subject))]} for subject in teacher_map_data["kodeMapel"]
    #         ]
    #     }

    #     print({
    #         "hari": hari,
    #         "jam": sesi["jam"],
    #         "periode": sesi["periode"],
    #         "pengajar": result
    #     })


    return render_template("dashboard.html", mapel_guru= mapel_guru)
@app.route('/daftar_hadir_ujian')
def view_daftar_hadir_ujian():
    return render_template("daftar_hadir_siswa_ujian.html")
@app.route('/daftar_hadir')
def view_daftar_hadir():
    return render_template("daftar_hadir_siswa.html")
@app.route('/jadwal')
def view_jadwal():
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
    kelas = list(db.kelas.find().sort("nama", 1))  # Urutkan berdasarkan nama ASC
    return render_template("jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map, kelas=kelas )

@app.route('/manage_kehadiran')
def view_manage_kehadiran():
    users = list(db.users.find({"role": "murid"}, {"_id": 0}))
    kelas = list(db.kelas.find().sort("nama", 1))  # Urutkan berdasarkan nama ASC
    attendance = list(db.attendance.find())
    print(attendance)
    return render_template("manage_kehadiran.html", users=users, kelas=kelas, attendance=attendance)
@app.route('/coba')
def view_coba():
    return render_template("coba.html")
@app.route('/manage_ujian')
def view_manage_ujian():
    users = list(db.users.find({"role": "murid"}, {"_id": 0}))
    kelas = list(db.kelas.find().sort("nama", 1))  # Urutkan berdasarkan nama ASC
    test_attendance = list(db.test_attendance.find())
    print(test_attendance)
    return render_template("manage_ujian.html", users=users, kelas=kelas, test_attendance=test_attendance)
@app.route('/menu_pembayaran')
def view_menu_pembayaran():
    status = request.args.get('status', 'undefined')
    order_id= request.args.get('order_id', 'undefined')
    status_code = request.args.get('status_code', 'undefined')
    transaction_status = request.args.get('transaction_status', 'undefined')
    if status_code=="200":
        # Perbarui status transaksi di MongoDB
        result = db.transactions.update_one(
            {'order_id': order_id},
            {'$set': {
                'status': transaction_status,
                'updated_at': datetime.utcnow()
            }}
        )
        if result.modified_count > 0:
            print('Transaction updated successfully')
        else:
            print('Transaction not found or already updated')
        
    return render_template("menu_pembayaran.html")
@app.route('/verif_email')
def view_verif_email():
    return render_template("verif_email.html")
@app.route("/forgot_password")
def view_forgot_password():
    return render_template("forgot_password.html")