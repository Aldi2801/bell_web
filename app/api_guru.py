from . import AmpuMapel, Kehadiran, Keterangan, PembagianKelas, Penilaian, app, db, is_valid_email, bcrypt, Kbm, mail, s, User, Kelas, Siswa, Guru, Mapel, JadwalPelajaran, Role, Tagihan, Transaksi, Semester, TahunAkademik
from flask import flash, redirect, request, jsonify, url_for, render_template, render_template_string,session, abort
from flask_mail import Message
from sqlalchemy import case
from itsdangerous import BadSignature, SignatureExpired
import jwt, re, datetime, os, json, ast, uuid
from collections import defaultdict
from sqlalchemy.orm import joinedload

@app.route('/manage_jadwal')
def view_manage_jadwal():
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

    # Ambil guru dan mapel
    guru_list = Guru.query.order_by(Guru.nama.asc()).all()
    mapel_list = Mapel.query.order_by(Mapel.nama_mapel.asc()).all()

    formatted_teacher_map = {
        "kodeGuru": [{"inisial": g.inisial, "nama": g.nama} for g in guru_list],
        "kodeMapel": [{"id_mapel": m.id_mapel, "nama": m.nama_mapel} for m in mapel_list],
    }

    # Ambil siswa dan kelas
    users = Siswa.query.all()
    data_kelas = Kelas.query.order_by(Kelas.nama_kelas.asc()).all()
    kelas_dict = [{"id_kelas": k.id_kelas, "nama_kelas": k.nama_kelas} for k in data_kelas]

    return render_template(
        "guru/manage_jadwal.html",
        schedule=formatted_schedule,
        kode_guru=formatted_teacher_map["kodeGuru"],
        kode_mapel=formatted_teacher_map["kodeMapel"],
        users=users,
        kelas=kelas_dict,
        
    )

# Endpoint untuk menyimpan data guru
@app.route('/tambah_guru/tambah', methods=['POST'])
def save_guru():
    data = request.get_json()

    username = data['username']
    password = data['password']

    nama_lengkap = data['nama_lengkap']
    email = data['email']

    re_password = data['re-password']

    if not username or not email or not password or not re_password:
        return jsonify({"msg": "All fields are required"}), 400

    if not is_valid_email(email):
        return jsonify({"msg": "Invalid email format"}), 400

    if password != re_password:
        return jsonify({"msg": "Passwords do not match"}), 400
    cek_username =  User.query.filter_by(username=username).first()
    if cek_username:
        return jsonify({"msg": "Username already exists"}), 400
    cek_email =  User.query.filter_by(email=email).first()
    if cek_email:
        return jsonify({"msg": "Email already exists"}), 400
    # Hash password
    hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
    
    # Simpan user baru
    user = User(
            username=username,
            password=hashed_password,
            email=email,
            nip = data['nip'],
            active=True,
        )
    # Simpan user baru
    new_guru = Guru(
            nama= nama_lengkap,
            email=email,
            nip = data['nip'],
            inisial = data['inisial'],
            tempat_lahir = data['tempat_lahir'],
            tanggal_lahir = data['tanggal_lahir'],
            alamat = data['alamat'],
            no_hp = data['no_hp'],
            spesialisasi = data['spesialisasi'],
            id_gender = data['id_gender'],
            id_status = data['id_status']
        )
    new_role = Role.query.filter_by(name='guru').first()
    if new_role:
        user.roles.append(new_role)
        
    try:
        # token = s.dumps(email, salt='email-confirm')
        # conf_email_url = url_for('confirm_email', token=token, _external=True)
        # email_body = render_template_string('''
        #     Hello {{ username }},
            
        #     Anda menerima email ini, karena kami memerlukan verifikasi email untuk akun Anda agar aktif dan dapat digunakan.
            
        #     Silakan klik tautan di bawah ini untuk verifikasi email Anda. Tautan ini akan kedaluwarsa dalam 1 jam.
            
        #     confirm your email: {{ conf_email_url }}
            
        #     hubungi dukungan jika Anda memiliki pertanyaan.
            
        #     Untuk bantuan lebih lanjut, silakan hubungi tim dukungan kami di developer masteraldi2809@gmail.com .
            
        #     Salam Hangat,
            
        #     Admin
        # ''', username=username,  conf_email_url=conf_email_url)

        # msg = Message('Confirmasi Email Anda',
        #             sender='masteraldi2809@gmail.com', recipients=[email])

        # msg.body = email_body
        # mail.send(msg)
        db.session.add(user)
        db.session.add(new_guru)
        db.session.commit()
        return jsonify({'msg': 'User registered successfully'}), 201
        #return jsonify({'msg': 'User registered successfully, Please check your email for validation'}), 201
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500


# Endpoint untuk menyimpan data guru Ujian
@app.route('/tambah_guru_ujian', methods=['POST'])
def save_test_guru():
    data = request.json
    if not all(key in data for key in ("testName","subject","studentName", "class", "date", "status")):
        return jsonify({"error": "Invalid data"}), 400
    
    db.test_attendance.insert_one(data)
    return jsonify({"message": "Attendance saved successfully"}), 201

@app.route('/tambah_ubah_jadwal', methods=['POST'])
def tambah_ubah_jadwal():
    data = request.get_json()

    day = data.get('day')
    time = data.get('time')
    period = data.get('period')
    subject = data.get('subject')  # list of strings

    if not (day and time and period is not None and subject):
        return jsonify({'status': 'error', 'message': 'Data tidak lengkap'}), 400

    # Cek apakah data dengan day + period sudah ada
    existing = JadwalPelajaran.query.filter_by(day=day, period=period).first()

    if existing:
        # Update
        existing.time = time
        existing.subject = json.dumps(subject)  # simpan sebagai string JSON
        msg = "Jadwal berhasil diperbarui"
    else:
        # Insert baru
        new_schedule = JadwalPelajaran(
            day=day,
            time=time,
            period=period,
            subject=json.dumps(subject)
        )
        db.session.add(new_schedule)
        msg = "Jadwal berhasil ditambahkan"

    db.session.commit()
    return jsonify({'status': 'success', 'message': msg})

@app.route("/kbm/list")
def list_kbm():
    if 'role' not in session or session['role'] != 'guru':
        return redirect(url_for('login'))

    guru = Guru.query.filter_by(nip=session['nip']).first()


    # Ambil data untuk tampilan
    data_ampu = AmpuMapel.query.filter_by(nip=guru.nip).all()
    daftar_mapel = Mapel.query.all()
    daftar_semester = Semester.query.all()
    daftar_tahun = TahunAkademik.query.all()
    daftar_pembagian = PembagianKelas.query.filter_by(nip=guru.nip).all()

    return render_template("guru/list_ampu.html",
                           title="Pelajaran Diampu",
                           btn_tambah=True,
                           data_ampu=data_ampu,
                           daftar_mapel=daftar_mapel,
                           daftar_semester=daftar_semester,
                           daftar_tahun=daftar_tahun,
                           daftar_pembagian=daftar_pembagian)

@app.route("/kbm/list/tambah", methods=["POST"])
def kbm_tambah():
     # Tambah data baru
        new_ampu = AmpuMapel(
            nip=guru.nip,
            id_mapel=request.form['id_mapel'],
            id_pembagian=request.form['id_pembagian'],
            id_semester=request.form['id_semester'],
            id_tahun_akademik=request.form['id_tahun_akademik'],
            tanggal=datetime.utcnow()  # meskipun tidak ditampilkan
        )
        db.session.add(new_ampu)
        db.session.commit()
        flash("Data pelajaran berhasil ditambahkan", "success")
        return redirect(url_for('list_kbm'))
@app.route("/kbm/edit/<int:id>", methods=["PUT"])
def edit_ampu(id):
        ampu = AmpuMapel.query.get_or_404(id)
        ampu.id_mapel = request.form['id_mapel']
        ampu.id_pembagian = request.form['id_pembagian']
        ampu.id_semester = request.form['id_semester']
        ampu.id_tahun_akademik = request.form['id_tahun_akademik']
        db.session.commit()
        flash("Data berhasil diupdate", "success")
        return redirect(url_for('list_kbm'))
@app.route("/kbm/hapus/<int:id>", methods=["DELETE"])
def hapus_ampu(id):
    ampu = AmpuMapel.query.get_or_404(id)
    db.session.delete(ampu)
    db.session.commit()
    flash("Data berhasil dihapus", "success")
    return redirect(url_for('list_kbm'))

@app.route("/kbm/<int:id_ampu>/daftar")
def daftar_kbm(id_ampu):
    daftar = Kbm.query.filter_by(id_ampu=id_ampu).all()
    return render_template("daftar_kbm.html", daftar=daftar)
def get_siswa_by_kbm(id_kbm):
    kbm = Kbm.query.get_or_404(id_kbm)
    ampu = AmpuMapel.query.get_or_404(kbm.id_ampu)
    if not ampu.id_pembagian:
        return []  # Kalau belum ada pembagian kelas, kembalikan list kosong
    siswa_list = Siswa.query.join(PembagianKelas, Siswa.nis == PembagianKelas.nis) \
        .filter(PembagianKelas.id_pembagian == ampu.id_pembagian).all()
    return siswa_list

@app.route('/kehadiran/form/<int:id_kbm>')
def form_kehadiran(id_kbm):
    kbm = Kbm.query.get_or_404(id_kbm)
    siswa_list = get_siswa_by_kbm(id_kbm)
    keterangan_list = Keterangan.query.all()

    # Ambil data kehadiran sebelumnya buat kbm ini, simpan dalam dict {nis: id_keterangan}
    kehadiran_data = Kehadiran.query.filter_by(id_kbm=id_kbm).all()
    kehadiran_dict = {k.nis: k.id_keterangan for k in kehadiran_data}

    return render_template('form_kehadiran.html', kbm=kbm, siswa_list=siswa_list,
                           keterangan_list=keterangan_list, kehadiran_dict=kehadiran_dict)

@app.route('/kehadiran/simpan', methods=['POST'])
def simpan_kehadiran():
    id_kbm = request.form.get('id_kbm')
    data_kehadiran = request.form.getlist('kehadiran')
    print(data_kehadiran)
    kehadiran_data = {}
    for key, value in request.form.items():
        if key.startswith("kehadiran["):
            nis = key.split("[")[1].split("]")[0]  # Ambil NIS dari nama field
            kehadiran_data[int(nis)] = value
    for nis, id_keterangan in kehadiran_data.items():
        hadir = Kehadiran(nis=nis, id_keterangan=id_keterangan, id_kbm=id_kbm)
        db.session.add(hadir)

    db.session.commit()
    flash("Kehadiran berhasil disimpan", "success")

    return redirect(url_for('form_kehadiran', id_kbm=id_kbm))

@app.route('/bayar_offline', methods=['POST'])
def bayar_offline():
    data = request.json
    id_tagihan = data.get('id_tagihan')
    total = data.get('total')
    user = session.get('username')  # atau session['username']

    if not id_tagihan or not total:
        return jsonify(success=False, message="Data tidak lengkap")

    tagihan = Tagihan.query.options(joinedload(Tagihan.user)).filter_by(id_tagihan=id_tagihan).first()
    kode_order = f"offline_{user}"
    transaksi = Transaksi(
        id_tagihan=id_tagihan,
        kode_order=kode_order,
        email= tagihan.user.email,
        total=total,
        fraud_status = 0,
        status="settlement",
        created_at=datetime.datetime.now()
    )
    db.session.add(transaksi)

    db.session.commit()
    return jsonify(success=True)
@app.route('/menu_pembayaran/tambah', methods=['POST'])
def tambah_tagihan():
    if session.get('role') == 'murid':
        abort(403)
    nis = request.json.get('nis')
    if 'role' not in session or session['role'] == 'murid':
        return jsonify({'error': 'Akses ditolak'}), 403

    data = request.get_json()
    if not data:
        return jsonify({'error': 'Format request tidak valid'}), 400

    email_target = data.get('user_email')
    if email_target == 'semua_siswa':
        siswa_list = Siswa.query.all()
        for siswa in siswa_list:
            user = User.query.filter_by(nis=siswa.nis).first()
           
            tagihan = Tagihan(
                semester=request.json.get('semester'),
                user_id = user.id,
                tahun_ajaran=request.json.get('tahun_ajaran'),
                deskripsi=request.json.get('deskripsi'),
                total=request.json.get('total'),
                user_email=siswa.email
            )
            db.session.add(tagihan)
        db.session.commit()
        return jsonify({'msg': 'Tagihan berhasil ditambahkan ke semua siswa'})
    else:
        user = User.query.filter_by(nis=nis).first()
        tagihan = Tagihan(
            semester=request.json.get('semester'),
            user_id = user.id,
            tahun_ajaran=request.json.get('tahun_ajaran'),
            deskripsi=request.json.get('deskripsi'),
            total=request.json.get('total'),
            user_email=email_target,
        )
        db.session.add(tagihan)
        db.session.commit()
        return jsonify({'msg': 'Tagihan berhasil ditambahkan'})
@app.route('/get_tagihan/<int:id_tagihan>', methods=['GET'])
def get_tagihan(id_tagihan):
    tagihan = Tagihan.query.options(joinedload(Tagihan.user)).filter_by(id_tagihan=id_tagihan).first()
    if not tagihan:
        return jsonify({'error': 'Tagihan tidak ditemukan'}), 404

    # Cari transaksi yang terhubung ke tagihan ini
    transaksi = Transaksi.query.filter_by(id_tagihan=id_tagihan).first()

    # Jika transaksi ditemukan dan statusnya 'paid', ubah jadi 'lunas'
    if transaksi and transaksi.status == 'paid':
        status = 'Lunas'
    else:
        status = "Belum Lunas"
    print(status)
    return jsonify({
        'id_tagihan': tagihan.id_tagihan,
        'user_email': tagihan.user.email,
        'semester': tagihan.semester,
        'tahun_ajaran': tagihan.tahun_ajaran,
        'deskripsi': tagihan.deskripsi,
        'total': tagihan.total,
        'status': status
        
    })

@app.route('/menu_pembayaran/edit/<int:id_tagihan>', methods=['PUT'])
def edit_tagihan(id_tagihan):
    if session.get('role') == 'murid':
        abort(403)

    tagihan = Tagihan.query.filter_by(id_tagihan=id_tagihan).first()
    if not tagihan:
        return jsonify({'error': 'Tagihan tidak ditemukan'}), 404

    tagihan.semester = request.json.get('semester')
    tagihan.tahun_ajaran = request.json.get('tahun_ajaran')
    tagihan.deskripsi = request.json.get('deskripsi')
    tagihan.total = request.json.get('total')

    db.session.commit()
    flash('Tagihan berhasil diperbarui')
    return jsonify({'msg': 'Tagihan berhasil diperbarui'})
@app.route('/menu_pembayaran/hapus/<int:id_tagihan>', methods=['DELETE'])
def hapus_tagihan(id_tagihan):
    if session.get('role') == 'murid':
        abort(403)

    tagihan = Tagihan.query.filter_by(id_tagihan=id_tagihan).first()
    if not tagihan:
        return jsonify({'error': 'Tagihan tidak ditemukan'}), 404

    db.session.delete(tagihan)
    db.session.commit()
    flash('Tagihan berhasil dihapus')
    return jsonify({'msg': 'Tagihan berhasil dihapus'})

@app.route('/guru/penilaian')
def penilaian_list():
    print(session.get('role'))
    if session.get('role') != 'guru':
        abort(403)
    penilaian = Penilaian.query.all()
    data_siswa = Siswa.query.all()
    data_ampu = AmpuMapel.query.filter_by(nip=session['nip']).all()
    btn_tambah = True
    title = "Nilai Siswa"
    title_data = "Nilai Siswa"
    return render_template('guru/penilaian.html', penilaian=penilaian,data_siswa=data_siswa,data_ampu=data_ampu, btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/guru/penilaian/tambah', methods=['POST'])
def tambah_penilaian():
    print(session.get('role'))
    if session.get('role') != 'guru':
        abort(403)
    penilaian = Penilaian(
            id_penilaian=request.json.get('id_penilaian'),
            penilaian=request.json.get('nama_penilaian')
    )
    db.session.add(penilaian)
    db.session.commit()
    flash('penilaian berhasil ditambahkan')
    return jsonify({'msg':'penilaian berhasil ditambahkan'})

@app.route('/guru/penilaian/edit/<id_penilaian_old>', methods=['PUT'])
def edit_penilaian(id_penilaian_old):
    if session.get('role') != 'guru':
        abort(403)
    penilaian = Penilaian.query.filter_by(id_penilaian=id_penilaian_old).first()
    if not penilaian:
        return jsonify({'error': 'penilaian tidak ditemukan'}), 404
    penilaian.id_penilaian = request.json.get('id_penilaian')
    penilaian.penilaian = request.json.get('nama_penilaian')
    db.session.commit()
    flash('penilaian berhasil diperbarui')
    return jsonify({'msg': 'penilaian berhasil diperbarui'})

@app.route('/guru/penilaian/hapus/<id_penilaian>', methods=['DELETE'])
def hapus_penilaian(id_penilaian):
    if session.get('role') != 'guru':
        abort(403)
    penilaian = penilaian.query.filter_by(id_penilaian=id_penilaian).first()
    if not penilaian:
        return jsonify({'error': 'penilaian tidak ditemukan'}), 404
    db.session.delete(penilaian)
    db.session.commit()
    flash('penilaian berhasil dihapus')
    return jsonify({'msg': 'penilaian berhasil dihapus'})
