from . import app, bcrypt, db, User, Berita, Kelas, Kbm, Siswa, Guru, Mapel
from flask import request, jsonify, render_template, redirect, url_for, session
import jwt, os, json
from datetime import datetime
from bson.objectid import ObjectId

@app.route('/register')
def view_register():
    return render_template("register.html")
@app.route('/register_guru')
def view_register_guru():
    data_guru = Guru.query.all()
    data_fix = []

    for i in data_guru:
        user = i.user  # ambil user yang sesuai nip
        data_fix.append({
            'username': user.username if user else '-',
            'nip': i.nip,
            'inisial': i.inisial,
            'nama': i.nama,
            'tempat_lahir': i.tempat_lahir,
            'tanggal_lahir': i.tanggal_lahir.strftime('%Y-%m-%d'),
            'alamat': i.alamat,
            'no_hp': i.no_hp,
            'email': i.email,
            'spesialisasi': i.spesialisasi,
            'gender': i.gender_rel.gender if i.gender_rel else '-',
            'status': i.status_rel.status if i.status_rel else '-'
        })
    return render_template("register_guru.html",guru=data_fix)
@app.route('/pengumuman')
def view_pengumuman():
    pengumuman = Berita.query.all()
    print(pengumuman)
    return render_template("manage_pengumuman.html", pengumuman = pengumuman)

@app.route('/manage_pengumuman')
def view_manage_pengumuman():
    pengumuman = Berita.query.all()
    return render_template("manage_pengumuman.html", pengumuman=pengumuman)
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
    return render_template("dashboard.html")
@app.route('/daftar_hadir_ujian')
def view_daftar_hadir_ujian():
    return render_template("daftar_hadir_siswa_ujian.html")
@app.route('/daftar_hadir')
def view_daftar_hadir():
    return render_template("daftar_hadir_siswa.html")
@app.route('/jadwal')
def view_jadwal():    
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
    formatted_teacher_map = {}
    data_guru = Guru.query.order_by(Guru.nama.asc()).all() # Urutkan berdasarkan nama ASC
    formatted_teacher_map["kodeGuru"] = [
        { k.inisial : k.nama}
        for k in data_guru
    ]
    data_mapel = Mapel.query.order_by(Mapel.nama_mapel.asc()).all() # Urutkan berdasarkan nama ASC
    formatted_teacher_map["kodeMapel"] = [
        { k.id_mapel : k.nama_mapel}
        for k in data_mapel
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
    # Output hasil
    print("Formatted Schedule:")
    print(formatted_schedule)

    print("\nFormatted Teacher Map:")
    print(formatted_teacher_map)
    users = Siswa.query.all()
    data_kelas = Kelas.query.order_by(Kelas.nama_kelas.asc()).all() # Urutkan berdasarkan nama ASC
    kelas_dict = [
        {"id_kelas": k.id_kelas, "nama_kelas": k.nama_kelas}
        for k in data_kelas
    ]
    print(kelas_dict)

    return render_template("jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map["kodeGuru"], kode_mapel=formatted_teacher_map["kodeMapel"], users=users, kelas=kelas_dict)

@app.route('/manage_kehadiran')
def view_manage_kehadiran():
    from sqlalchemy.orm import aliased
    from sqlalchemy.sql import or_

    # results = db.session.query(
    #     siswa,
    #     User
    # ).outerjoin(
    #     User, siswa.nis == User.nip
    # ).all()

    # # Bisa juga filter untuk siswa tertentu
    # # .filter(siswa.nama == 'Nama Siswa')

    # output = []
    # for s, u in results:
    #     output.append({
    #         'nama_siswa': s.nama,
    #         'nis': s.nis,
    #         'nip_user': u.nip if u else None,
    #         'username_user': u.username if u else None
    #     })

    data_siswa = Siswa.query.all()
        
    data_kelas = Kelas.query.order_by(Kelas.nama_kelas.asc()).all()
    data_kbm = Kbm.query.all()
    return render_template("manage_kehadiran.html", siswa=data_siswa, kelas=data_kelas, kbm=data_kbm)
@app.route('/coba')
def view_coba():
    return render_template("coba.html")
@app.route('/verif_email')
def view_verif_email():
    return render_template("verif_email.html")
@app.route("/forgot_password")
def view_forgot_password():
    return render_template("forgot_password.html")