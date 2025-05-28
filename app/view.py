from . import app, bcrypt, db, User, tugas, berita, kelas, kbm
from flask import request, jsonify, render_template, redirect, url_for, session
import jwt, os
from datetime import datetime
from bson.objectid import ObjectId

@app.route('/')
def hello_fly():
    return redirect(url_for("view_dashboard"))
@app.route('/register')
def view_register():
    return render_template("register.html")
@app.route('/register_guru')
def view_register_guru():
    return render_template("register_guru.html")
@app.route('/tugas')
def view_tugas():
    tugas = tugas.query.all()
    print(tugas)
    return render_template("manage_tugas.html", tugas = tugas)
@app.route('/pengumuman')
def view_pengumuman():
    pengumuman = Berita.query.all()
    print(pengumuman)
    return render_template("manage_pengumuman.html", pengumuman = pengumuman)

@app.route('/manage_tugas')
def view_manage_tugas():
    tugas = tugas.query.all()
    return render_template("manage_tugas.html", tugas=tugas)
@app.route('/manage_pengumuman')
def view_manage_pengumuman():
    pengumuman = Berita.query.all()
    return render_template("manage_pengumuman.html", pengumuman=pengumuman)
@app.route('/manage_laporan')
def view_manage_laporan():
    laporan = Laporan.query.all()
    return render_template("manage_laporan.html", laporan=laporan)
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
    mapel_guru = ""

    return render_template("dashboard.html", mapel_guru= mapel_guru)
@app.route('/daftar_hadir_ujian')
def view_daftar_hadir_ujian():
    return render_template("daftar_hadir_siswa_ujian.html")
@app.route('/daftar_hadir')
def view_daftar_hadir():
    return render_template("daftar_hadir_siswa.html")
@app.route('/jadwal')
def view_jadwal():
    kelas = kelas.query.order_by(kelas.nama_kelas.asc()).all()  # Urutkan berdasarkan nama ASC
    return render_template("jadwal.html", kelas=kelas )

@app.route('/manage_kehadiran')
def view_manage_kehadiran():
    users = User.query.filter_by(role="murid").all()
    kelas = kelas.query.order_by(kelas.nama_kelas.asc()).all()
    kbm = kbm.query.all()
    return render_template("manage_kehadiran.html", users=users, kelas=kelas, kbm=kbm)
@app.route('/coba')
def view_coba():
    return render_template("coba.html")
@app.route('/verif_email')
def view_verif_email():
    return render_template("verif_email.html")
@app.route("/forgot_password")
def view_forgot_password():
    return render_template("forgot_password.html")