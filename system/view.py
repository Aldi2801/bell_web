from . import app, bcrypt, db, users_collection
from flask import request, jsonify, render_template, redirect, url_for
import jwt
import datetime
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
@app.route('/manage_jadwal')
def view_manage_jadwal():
    schedule_collection = db["schedules"]

    # Query data
    schedule_id = ObjectId('67334170f71fdf42ce9446cc')
    teacher_map_id = ObjectId('673341ddf71fdf42ce9446cd')
    #LOKAL ALDI
    schedule_id = ObjectId('6765893afbd3a1d8ed2dd985')
    teacher_map_id = ObjectId('6765895ffbd3a1d8ed2dd986')

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
    return render_template("manage_jadwal_new.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map )
@app.route('/manage_kehadiran')
def view_manage_kehadiran():
    return render_template("manage_kehadiran.html")
@app.route('/manage_ujian')
def view_manage_ujian():
    return render_template("manage_ujian.html")
@app.route('/menu_pembayaran')
def view_menu_pembayaran():
    return render_template("menu_pembayaran.html")
@app.route('/verif_email')
def view_verif_email():
    return render_template("verif_email.html")
@app.route("/forgot_password")
def view_forgot_password():
    return render_template("forgot_password.html")