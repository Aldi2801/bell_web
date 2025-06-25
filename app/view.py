from . import app, bcrypt, db, User, Berita, Kelas,TahunAkademik, Kbm, Siswa, Guru, Mapel,Penilaian, JadwalPelajaran, PembagianKelas, Siswa
from flask import request, jsonify, render_template, redirect, url_for, session
import jwt, re, datetime, os, json, ast, uuid
from datetime import datetime, timedelta
from sqlalchemy import func, extract, case
from collections import defaultdict

@app.route('/register')
def view_register():
    return render_template("register.html")
@app.route('/tambah_guru')
def view_register_guru():
    data_guru = Guru.query.all()
    data_fix = []
    btn_tambah = True
    title = "Manage Guru"
    title_data = "Tambah Guru"
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
    return render_template("admin/tambah_guru.html",guru=data_fix, btn_tambah=btn_tambah, title=title, title_data=title_data   )

def find_current_period(sesi_list, current_time):
    for sesi in sesi_list:
        jam_mulai, jam_selesai = sesi["jam"].split(" - ")
        start = datetime.strptime(jam_mulai, "%H.%M").time()
        end = datetime.strptime(jam_selesai, "%H.%M").time()
        if start <= current_time <= end:
            return sesi
    return None
from flask_login import current_user
from flask import render_template, session

@app.route('/dashboard')
def dashboard():
    role = session.get('role')
    user = User.query.filter_by(username=session.get('username')).first()
    print(session.get('username'))
    print(session.get('role'))
    print(user)
    # Ambil berita terbaru < 14 hari
    batas_waktu = datetime.utcnow() - timedelta(days=14)
  
    profil = {}
    if role == 'admin':
        berita_terbaru =''
        profil = {
            'username': user.username,
            'email': user.email,
            'role': 'Admin'
        }
        # Jumlah data
        jumlah_siswa = db.session.query(Siswa).count()
        jumlah_guru = db.session.query(Guru).count()
        jumlah_kelas = db.session.query(Kelas).count()
        # Ambil tahun akademik terbaru berdasarkan tanggal mulai
        tahun_terbaru = db.session.query(TahunAkademik).order_by(TahunAkademik.mulai.desc()).first()

        if tahun_terbaru:
            # Hitung jumlah siswa dalam setiap kelas untuk tahun akademik terbaru
            kelas_counts = (
                db.session.query(PembagianKelas.id_kelas, db.func.count(PembagianKelas.nis))
                .filter(PembagianKelas.id_tahun_akademik == tahun_terbaru.id_tahun_akademik)
                .group_by(PembagianKelas.id_kelas)
                .all()
            )

            if kelas_counts:
                total_siswa = sum([jml for _, jml in kelas_counts])
                jumlah_kelas_terbaru = len(kelas_counts)
                rata_siswa_per_kelas = round(total_siswa / jumlah_kelas_terbaru, 2)
            else:
                rata_siswa_per_kelas = 0
        else:
            rata_siswa_per_kelas = 0

        # Jadwal KBM hari ini
        hari_ini = datetime.now().strftime('%A')  # 'Monday', 'Tuesday', etc
        jadwal_hari_ini = JadwalPelajaran.query.filter_by(day=hari_ini).all()

        # Siswa terbaru (berdasarkan ID User karena ada relasi user_id)
        siswa_terbaru = db.session.query(Siswa).join(User).order_by(User.id.desc()).limit(10).all()

        # Rata-rata nilai penilaian per bulan (12 bulan terakhir)
        chart_bulan = []
        chart_rata = []
        now = datetime.now()

        for i in range(11, -1, -1):
            target_date = now.replace(day=1) - timedelta(days=30*i)
            bulan = target_date.strftime('%b %Y')
            avg_nilai = db.session.query(func.avg(Penilaian.nilai)).filter(
                extract('month', Penilaian.tanggal) == target_date.month,
                extract('year', Penilaian.tanggal) == target_date.year
            ).scalar()

            chart_bulan.append(bulan)
            chart_rata.append(round(avg_nilai, 2) if avg_nilai else 0)
        print(chart_bulan)
        print(chart_rata)
        chart_data={
                'bulan': chart_bulan,
                'rata_rata': chart_rata
            }
        return render_template('dashboard.html', 
            jumlah_siswa=jumlah_siswa,
            jumlah_guru=jumlah_guru,
            jumlah_kelas=jumlah_kelas,
            rata_siswa_per_kelas=rata_siswa_per_kelas,
            jadwal_hari_ini=jadwal_hari_ini,
            siswa_terbaru=siswa_terbaru,
            chart_data=chart_data,
            profil=profil, berita=berita_terbaru
        )

    elif role == 'guru':
        berita_terbaru = Berita.query.filter(Berita.tanggal_dibuat >= batas_waktu, Berita.pengumuman_untuk == 'guru').order_by(Berita.tanggal_dibuat.desc()).first()

        guru = Guru.query.filter_by(nip=user.nip).first()
        profil = {
            'nama': guru.nama,
            'nip': guru.nip,
            'tempat_lahir': guru.tempat_lahir,
            'tanggal_lahir': guru.tanggal_lahir,
            'alamat': guru.alamat,
            'no_hp': guru.no_hp,
            'email': guru.email,
            'gender': guru.gender_rel.gender,
            'status': guru.status_rel.status,
            'spesialisasi': guru.spesialisasi,
            'role': 'Guru'
        }

    elif role == 'murid':
        berita_terbaru = Berita.query.filter(Berita.tanggal_dibuat >= batas_waktu, Berita.pengumuman_untuk == 'murid').order_by(Berita.tanggal_dibuat.desc()).first()

        siswa = Siswa.query.filter_by(nis=user.nis).first()
        kelas_aktif = PembagianKelas.query.filter_by(nis=siswa.nis).order_by(PembagianKelas.tanggal.desc()).first()
        profil = {
            'nama': siswa.nama,
            'nis': siswa.nis,
            'tempat_lahir': siswa.tempat_lahir,
            'tanggal_lahir': siswa.tanggal_lahir,
            'alamat': siswa.alamat,
            'no_hp': siswa.no_hp,
            'email': session.get('email',''),
            'gender': siswa.gender_rel.gender,
            'kelas': kelas_aktif.kelas_rel.nama_kelas if kelas_aktif else 'Belum dibagi',
            'role': 'Murid'
        }
    
    return render_template('dashboard.html', profil=profil, berita=berita_terbaru)

@app.route('/daftar_hadir_ujian')
def view_daftar_hadir_ujian():
    return render_template("daftar_hadir_siswa_ujian.html")
@app.route('/daftar_hadir')
def view_daftar_hadir():
    return render_template("daftar_hadir_siswa.html")
@app.route('/jadwal')
def view_jadwal():    
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
    users = Siswa.query.all()
    data_kelas = Kelas.query.order_by(Kelas.nama_kelas.asc()).all() # Urutkan berdasarkan nama ASC
    kelas_dict = [
        {"id_kelas": k.id_kelas, "nama_kelas": k.nama_kelas}
        for k in data_kelas
    ]
    print(kelas_dict)

    return render_template("murid/jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map["kodeGuru"], kode_mapel=formatted_teacher_map["kodeMapel"], users=users, kelas=kelas_dict,
                           
    btn_tambah = False,
    title = "Jadwal Pelajaran",
    title_data = "Jadwal Pelajaran")

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
@app.route('/verif_email')
def view_verif_email():
    return render_template("verif_email.html")
@app.route("/forgot_password")
def view_forgot_password():
    return render_template("forgot_password.html")