from . import app, bcrypt, db, users_collection, get_semester_and_year
from flask import request, jsonify, render_template, redirect, url_for
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
@app.route('/dashboard')
def view_dashboard():
    return render_template("dashboard.html")
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
    return render_template("manage_kehadiran.html", users=users, kelas=kelas)
@app.route('/coba')
def view_coba():
    return render_template("coba.html")
@app.route('/manage_ujian')
def view_manage_ujian():
    users = list(db.users.find({"role": "murid"}, {"_id": 0}))
    kelas = list(db.kelas.find().sort("nama", 1))  # Urutkan berdasarkan nama ASC
    return render_template("manage_ujian.html", users=users, kelas=kelas)
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