# Import library bawaan Python
from collections import defaultdict
import datetime, ast, os, uuid
# Import library pihak ketiga
from flask import abort, render_template, request, jsonify, session, redirect, url_for
# Fungsi untuk mengubah angka menjadi teks (terbilang)
from flask import flash
# Import dari aplikasi lokal
from . import AmpuMapel,Kelas, Mapel,allowed_file_img_profile, EvaluasiGuru,Role,PembagianKelas, Semester, Tagihan, TahunAkademik, Transaksi, app, db, User, Siswa, Guru, Role, bcrypt, JadwalPelajaran,Berita, Gender, Status, is_valid_email
from sqlalchemy import case
from sqlalchemy.orm import joinedload
from itertools import zip_longest
        
@app.route('/admin/semester')
def semester_list():
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.all()
    btn_tambah = True
    title = "Manage Semester"
    title_data = "Semester"
    return render_template('admin/semester.html', semester=semester, btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/semester/tambah', methods=['POST'])
def tambah_semester():
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester(
            id_semester=request.json.get('id_semester'),
            semester=request.json.get('nama_semester')
    )
    db.session.add(semester)
    db.session.commit()
    flash('Semester berhasil ditambahkan')
    return jsonify({'msg':'Semester berhasil ditambahkan'})

@app.route('/admin/semester/edit/<id_semester_old>', methods=['PUT'])
def edit_semester(id_semester_old):
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.filter_by(id_semester=id_semester_old).first()
    if not semester:
        return jsonify({'error': 'Semester tidak ditemukan'}), 404
    semester.id_semester = request.json.get('id_semester')
    semester.semester = request.json.get('nama_semester')
    db.session.commit()
    flash('Semester berhasil diperbarui')
    return jsonify({'msg': 'Semester berhasil diperbarui'})

@app.route('/admin/semester/hapus/<id_semester>', methods=['DELETE'])
def hapus_semester(id_semester):
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.filter_by(id_semester=id_semester).first()
    if not semester:
        return jsonify({'error': 'Semester tidak ditemukan'}), 404
    db.session.delete(semester)
    db.session.commit()
    flash('Semester berhasil dihapus')
    return jsonify({'msg': 'Semester berhasil dihapus'})

@app.route('/admin/kelas')
def kelas_list():
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas.query.all()
    btn_tambah = True
    title = "Manage Kelas"
    title_data = "Kelas"
    return render_template('admin/kelas.html', kelas=kelas,btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/kelas/tambah', methods=['POST'])
def tambah_kelas():
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas(
        id_kelas=request.json.get('id_kelas'),
        nama_kelas=request.json.get('nama_kelas'),
        tingkat=request.json.get('tingkat')
    )
    db.session.add(kelas)
    db.session.commit()
    flash('Kelas berhasil ditambahkan')
    return jsonify({'msg': 'Kelas berhasil ditambahkan'})

@app.route('/admin/kelas/hapus/<id_kelas>', methods=['DELETE'])
def hapus_kelas(id_kelas):
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas.query.filter_by(id_kelas=id_kelas).first()
    if not kelas:
        return jsonify({'error': 'Kelas tidak ditemukan'}), 404
    db.session.delete(kelas)
    db.session.commit()
    flash('Kelas berhasil dihapus')
    return jsonify({'msg': 'Kelas berhasil dihapus'})

@app.route('/admin/mapel')
def mapel_list():
    if session.get('role') != 'admin':
        abort(403)
    mapel = Mapel.query.all()
    btn_tambah = True
    title = "Manage Mapel"
    title_data = "Mapel"
    return render_template('admin/mapel.html', mapel=mapel, btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/mapel/tambah', methods=['POST'])
def tambah_mapel():
    if session.get('role') != 'admin':
        abort(403)
    mapel = Mapel(
            id_mapel=request.json.get('id_mapel'),
            nama_mapel=request.json.get('nama_mapel')
    )
    db.session.add(mapel)
    db.session.commit()
    flash('Mapel berhasil ditambahkan')
    return jsonify({'msg':'Mapel berhasil ditambahkan'})

@app.route('/admin/mapel/hapus/<id_mapel>', methods=['DELETE'])
def hapus_mapel(id_mapel):
    if session.get('role') != 'admin':
        abort(403)
    mapel = Mapel.query.filter_by(id_mapel=id_mapel).first()
    if not mapel:
        return jsonify({'error': 'Mapel tidak ditemukan'}), 404
    db.session.delete(mapel)
    db.session.commit()
    flash('Mapel berhasil dihapus')
    return jsonify({'msg': 'Mapel berhasil dihapus'})
# Model Siswa tetap, tidak diubah

@app.route('/admin/siswa')
def view_admin_siswa():
    siswa_list = Siswa.query.all()
    gender_list = Gender.query.all()
    status_list = Status.query.all()
    btn_tambah = True
    title = "Manage Siswa"
    title_data = "Siswa"
    return render_template('admin/siswa.html', siswa_list=siswa_list,gender_list=gender_list,status_list=status_list,
    btn_tambah=btn_tambah, title=title, title_data=title_data)


@app.route('/admin/siswa/tambah', methods=['POST'])
def tambah_admin_siswa():
    if session.get('role') == 'murid':
        abort(403)
    data = request.json

    # Create User
    user = User(
        username=data.get('username_tambah'),
        nis=int(data.get('nis')),
        email=data.get('email'),
        password=bcrypt.generate_password_hash(data.get('password_tambah')).decode('utf-8'),
        active=True,
    )

    # Assign role
    new_role = Role.query.filter_by(name='murid').first()
    if new_role:
        user.roles.append(new_role)

    # Add user to DB first so it has an ID
    db.session.add(user)
    db.session.flush()  # Ensures user.id is populated

    # Create Siswa linked to User
    siswa = Siswa(
        nis=int(data.get('nis')),
        nisn=data.get('nisn'),
        nama=data.get('nama'),
        id_gender=data.get('id_gender'),
        tempat_lahir=data.get('tempat_lahir'),
        tanggal_lahir=data.get('tanggal_lahir'),
        alamat=data.get('alamat'),
        no_hp=data.get('no_hp'),
        nama_ayah=data.get('nama_ayah'),
        nama_ibu=data.get('nama_ibu'),
        penghasilan_ayah=data.get('penghasilan_ayah'),
        penghasilan_ibu=data.get('penghasilan_ibu'),
        asal_sekolah=data.get('asal_sekolah'),
        id_status=data.get('id_status'),
        user_id=user.id,  # Ensure user.id is available
    )

    # Add siswa and commit all
    db.session.add(siswa)
    db.session.commit()

    flash('Siswa berhasil ditambahkan')
    return jsonify({'msg': 'Siswa berhasil ditambahkan'})

@app.route('/admin/siswa/edit/<int:nis>', methods=['PUT'])
def edit_admin_siswa(nis):
    siswa = Siswa.query.get(nis)
    if not siswa:
        return jsonify({'error': 'Siswa tidak ditemukan'})

    data = request.json
    siswa.nis = data.get('nis')
    siswa.nisn = data.get('nisn')
    siswa.nama = data.get('nama')
    siswa.id_gender = data.get('id_gender')
    siswa.tempat_lahir = data.get('tempat_lahir')
    siswa.tanggal_lahir = data.get('tanggal_lahir')
    siswa.alamat = data.get('alamat')
    siswa.no_hp = data.get('no_hp')
    user = User.query.get(siswa.user_id)
    user.nis=int(data.get('nis'))
    if data.get('password','') != '':
        user.password=bcrypt.generate_password_hash(data.get('password')).decode('utf-8')
    user.email = data.get('email')
    user.username = data.get('username')
    siswa.nama_ayah = data.get('nama_ayah')
    siswa.nama_ibu = data.get('nama_ibu')
    siswa.penghasilan_ayah = int(data.get('penghasilan_ayah'))
    siswa.penghasilan_ibu = int(data.get('penghasilan_ibu'))
    siswa.asal_sekolah = data.get('asal_sekolah')
    siswa.id_status = data.get('id_status')

    db.session.commit()
    flash('Siswa berhasil diperbarui')
    return jsonify({'msg': 'Siswa berhasil diperbarui'})


@app.route('/admin/siswa/hapus/<int:nis>', methods=['DELETE'])
def hapus_admin_siswa(nis):
    if session.get('role') == 'murid':
        abort(403)

    siswa = Siswa.query.get(nis)
    if not siswa:
        return jsonify({'error': 'Siswa tidak ditemukan'}), 404

    db.session.delete(siswa)
    db.session.commit()
    flash('Siswa berhasil dihapus')
    return jsonify({'msg': 'Siswa berhasil dihapus'})

@app.route('/admin/guru')
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

# Endpoint untuk menyimpan data guru
@app.route('/admin/guru/tambah', methods=['POST'])
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
        db.session.add(user)
        db.session.add(new_guru)
        db.session.commit()
        return jsonify({'msg': 'User registered successfully'}), 201
        #return jsonify({'msg': 'User registered successfully, Please check your email for validation'}), 201
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500
@app.route('/get_guru/<nip>')
def get_guru(nip):
    data_guru = Guru.query.filter_by(nip=nip).first()
    user = User.query.filter_by(nip=nip).first()
    role = user.roles[0].name if user and user.roles else 'guru'
    if not data_guru or not user:
        return jsonify({'error': 'Guru tidak ditemukan'}), 404

    return jsonify({
        'nip': nip,
        'email': data_guru.email,
        'nip': nip,
        'username': user.username if user else '',
        'role': role
    })
@app.route('/admin/guru/edit/<nip>', methods=['PUT'])
def edit_guru(nip):
    nip_baru = request.json.get('nip')
    username = request.json.get('username')
    email = request.json.get('email')
    nip = request.json.get('nip')
    password = request.json.get('password','')
    role = request.json.get('role')

    user = User.query.filter_by(nip=nip).first()
    # Cek jika username/email yang baru mau diganti ke milik orang lain
    if User.query.filter(User.username == username, User.id != user.id).first():
            flash('Username sudah digunakan oleh user lain', 'danger')
            return jsonify({'msg': 'Username sudah digunakan oleh user lain'}), 400
    if User.query.filter(User.email == email, User.id != user.id).first():
            flash('Email sudah digunakan oleh user lain', 'danger')
            return jsonify({'msg': 'Email sudah digunakan oleh user lain'}), 400

    user.username = username
    user.email = email
    if password != '':
            user.password = bcrypt.generate_password_hash(password).decode('utf-8')
    file = request.files.get('img_profile')
    if not file or not allowed_file_img_profile(file.filename):
        flash('File tidak valid atau belum diunggah', 'danger')

    # Hapus file lama jika ada
    if user.img_profile:
        old_path = os.path.join(app.config['UPLOAD_IMG_PROFILE'], user.img_profile)
        if os.path.exists(old_path):
            os.remove(old_path)

    # Simpan file baru
    ext = file.filename.rsplit('.', 1)[1].lower()
    filename = f"{uuid.uuid4().hex}.{ext}"
    filepath = os.path.join(app.config['UPLOAD_IMG_PROFILE'], filename)
    file.save(filepath)

    user.img_profile = filename
    db.session.commit()
    
    # Simpan data terbaru
    guru = Guru.query.filter_by(nip=nip).first()
    guru.nama = request.json.get('nama_lengkap')
    guru.email=email
    guru.nip = nip_baru
    guru.inisial = request.json.get('inisial')
    guru.tempat_lahir = request.json.get('tempat_lahir')
    guru.tanggal_lahir = request.json.get('tanggal_lahir')
    guru.alamat = request.json.get('alamat')
    guru.no_hp = request.json.get('no_hp')
    guru.spesialisasi = request.json.get('spesialisasi')
    guru.id_gender = request.json.get('id_gender')
    guru.id_status = request.json.get('id_status')
    db.session.commit()
    
    flash('Data guru berhasil diperbarui', 'success')

    return jsonify({'msg': 'Data guru berhasil diperbarui'})

@app.route('/admin/guru/hapus/<nip>', methods=['DELETE'])
def hapus_guru(nip):
    user = User.query.filter_by(nip=nip).first()
    data_guru = Guru.query.filter_by(nip=nip).first()
    if user:
        db.session.delete(user)
    if data_guru:
        db.session.delete(data_guru)
    db.session.commit()
    flash('Data guru berhasil dihapus', 'success')
    return jsonify({'msg': 'Data guru berhasil dihapus'})


@app.route('/admin/pembagian_kelas')
def pembagian_kelas_list():
    if session.get('role') != 'admin':
        abort(403)
    data = PembagianKelas.query.all()
    siswa = Siswa.query.all()
    guru = Guru.query.all()
    tahunakademik = TahunAkademik.query.all()
    kelas = Kelas.query.all()
    btn_tambah = True
    title = "Manage Pembagian Kelas"
    title_data = "Pembagian Kelas"
    return render_template('admin/pembagian_kelas_list.html', pembagian_kelas=data, btn_tambah=btn_tambah, title=title, title_data=title_data
                           , siswa = siswa , guru = guru , tahunakademik = tahunakademik, kelas = kelas)

@app.route('/admin/pembagian_kelas/tambah', methods=['POST'])
def tambah_pembagian_kelas():
    if session.get('role') != 'admin':
        abort(403)
    pembagian = PembagianKelas(
        tanggal=request.json.get('tanggal'),
        nis=request.json.get('nis'),
        id_kelas=request.json.get('id_kelas'),
        id_tahun_akademik=request.json.get('id_tahun_akademik'),
        nip=request.json.get('nip')
    )
    db.session.add(pembagian)
    db.session.commit()
    flash('Pembagian kelas berhasil ditambahkan')
    return jsonify({'msg': 'Pembagian kelas berhasil ditambahkan'})

@app.route('/admin/pembagian_kelas/edit/<id_pembagian>', methods=['PUT'])
def edit_pembagian_kelas(id_pembagian):
    if session.get('role') != 'admin':
        abort(403)
    pembagian = PembagianKelas.query.filter_by(id_pembagian=id_pembagian).first()
    if not pembagian:
        return jsonify({'error': 'Pembagian kelas tidak ditemukan'}), 404
    pembagian.tanggal = request.json.get('tanggal')
    pembagian.nis = request.json.get('nis')
    pembagian.id_kelas = request.json.get('id_kelas')
    pembagian.id_tahun_akademik = request.json.get('id_tahun_akademik')
    pembagian.nip = request.json.get('nip')
    db.session.commit()
    flash('Pembagian kelas berhasil diperbarui')
    return jsonify({'msg': 'Pembagian kelas berhasil diperbarui'})

@app.route('/admin/pembagian_kelas/hapus/<id_pembagian>', methods=['DELETE'])
def hapus_pembagian_kelas(id_pembagian):
    if session.get('role') != 'admin':
        abort(403)
    pembagian = PembagianKelas.query.filter_by(id_pembagian=id_pembagian).first()
    if not pembagian:
        return jsonify({'error': 'Pembagian kelas tidak ditemukan'}), 404
    db.session.delete(pembagian)
    db.session.commit()
    flash('Pembagian kelas berhasil dihapus')
    return jsonify({'msg': 'Pembagian kelas berhasil dihapus'})

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
        btn_tambah=False,
        title='Jadwal',
        title_data='Jadwal'
    )
@app.route('/tambah_ubah_jadwal', methods=['POST'])
def tambah_ubah_jadwal():
    data = request.get_json()

    day = data.get('day')
    time = data.get('time')
    period = data.get('period')
    subject = data.get('subject')  # list of strings, bisa berisi ' - '

    if not (day and time and period is not None and subject):
        return jsonify({'status': 'error', 'message': 'Data tidak lengkap'}), 400

    existing = JadwalPelajaran.query.filter_by(day=day, period=period).first()

    if existing:
        # Ambil dan evaluasi subject lama dari DB
        try:
            subject_lama = ast.literal_eval(existing.subject) if existing.subject else []
        except Exception:
            subject_lama = []

        # Gabungkan: jika elemen baru bukan '-' dan bukan kosong, pakai yang baru
        subject_final = [
            baru.strip() if baru.strip() != "-" and baru.strip() != "" else lama
            for lama, baru in zip_longest(subject_lama, subject, fillvalue="")
        ]

        existing.time = time
        existing.subject = str(subject_final)
        msg = "Jadwal berhasil diperbarui"
    else:
        # Simpan data baru
        new_schedule = JadwalPelajaran(
            day=day,
            time=time,
            period=period,
            subject=str(subject)
        )
        db.session.add(new_schedule)
        msg = "Jadwal berhasil ditambahkan"

    db.session.commit()
    return jsonify({'status': 'success', 'message': msg})

# === LIST EVALUASI GURU ===
@app.route('/evaluasi_guru')
def evaluasi_guru_list():
    if session.get('role') == 'admin':
        btn_tambah = False
        evaluasi_list = EvaluasiGuru.query.all()
    guru = Guru.query.all()
    users = User.query.all()
    ampu = AmpuMapel.query.all()
    title = "Manage Evaluasi Guru"
    title_data = "Evaluasi Guru"
    if session.get('role') == 'siswa':
        btn_tambah = True
        evaluasi_list = EvaluasiGuru.query.filter_by(nis=session.get('nis',''))
    return render_template('admin/evaluasi_guru.html', ampu=ampu, guru=guru,users=users, btn_tambah=False, evaluasi=evaluasi_list, title=title, title_data=title_data)


# === HAPUS EVALUASI GURU ===
@app.route('/evaluasi_guru/hapus/<int:id>', methods=['DELETE'])
def hapus_evaluasi_guru(id):
    if session.get('role') != 'admin':
        abort(403)
    
    evaluasi = EvaluasiGuru.query.get(id)
    if not evaluasi:
        return jsonify({'error': 'Evaluasi tidak ditemukan'}), 404
    
    db.session.delete(evaluasi)
    db.session.commit()
    flash('Evaluasi berhasil dihapus')
    return jsonify({'msg': 'Evaluasi berhasil dihapus'})

@app.route('/manage_pengumuman')
def view_manage_pengumuman():
    if session['role'] == 'guru':
        berita = Berita.query.filter_by(pengumuman_untuk='guru').all()
    else:
        berita = Berita.query.all()
    guru = Guru.query.all()  # ambil semua guru
    btn_tambah = True
    title = "Manage Berita"
    title_data = "Berita / Pengumuman"
    return render_template('admin/berita.html', berita=berita, guru=guru,btn_tambah=btn_tambah,title=title,title_data=title_data)


@app.route('/manage_pengumuman/tambah', methods=['POST'])
def tambah_pengumuman():
    if session.get('role') == 'murid':
        abort(403)
    berita = Berita(
            judul = request.json.get('judul'),
            isi   = request.json.get('isi'),
            nip   = request.json.get('nip'),
            pengumuman_untuk   = request.json.get('pengumuman_untuk'),
    )
    db.session.add(berita)
    db.session.commit()
    flash('berita berhasil ditambahkan')
    return jsonify({'msg':'berita berhasil ditambahkan'})

@app.route('/manage_pengumuman/edit/<id_pengumuman_old>', methods=['PUT'])
def edit_pengumuman(id_pengumuman_old):
    if session.get('role') == 'murid':
        abort(403)
    berita = Berita.query.filter_by(id_berita=id_pengumuman_old).first()
    if not berita:
        return jsonify({'error': 'berita tidak ditemukan'}), 404
    berita.judul = request.json.get('judul')
    berita.isi   = request.json.get('isi')
    berita.nip   = request.json.get('nip')
    berita.pengumuman_untuk   = request.json.get('pengumuman_untuk')
    db.session.commit()
    flash('berita berhasil diperbarui')
    return jsonify({'msg': 'berita berhasil diperbarui'})

@app.route('/manage_pengumuman/hapus/<id_pengumuman>', methods=['DELETE'])
def hapus_pengumuman(id_pengumuman):
    if session.get('role') == 'murid':
        abort(403)
    berita = Berita.query.filter_by(   id_berita=id_pengumuman).first()
    if not berita:
        return jsonify({'error': 'berita tidak ditemukan'}), 404
    db.session.delete(berita)
    db.session.commit()
    flash('berita berhasil dihapus')
    return jsonify({'msg': 'berita berhasil dihapus'})

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

    email_target = data.get('nis')
    print(email_target)
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
    print(tagihan.user.email)
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