from . import AmpuMapel, Kehadiran, Keterangan, PembagianKelas, Penilaian, app, db, is_valid_email, bcrypt, Kbm, User, Kelas, Siswa, Guru, Mapel, JadwalPelajaran, Role, Tagihan, Transaksi, Semester, TahunAkademik
from flask import flash, redirect, request, jsonify, url_for, render_template, session, abort
from sqlalchemy import case, extract
import datetime, json, ast
from collections import defaultdict
from sqlalchemy.exc import IntegrityError
import ast
from itertools import zip_longest

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

@app.route('/tambah_guru/edit/<nip>', methods=['PUT'])
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
    
    db.session.commit()
    
    # Simpan data terbaru
    guru = Guru.query.filter_by(nip=nip).first()
    guru.nama= request.json.get('nama_lengkap')
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

@app.route('/tambah_guru/hapus/<nip>', methods=['DELETE'])
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

@app.route("/kbm/list")
def list_kbm():
    if 'role' not in session or session['role'] == 'murid':
        return redirect(url_for('login'))
    if session['role'] == 'guru':
        guru = Guru.query.filter_by(nip=session['nip']).first()
        data_ampu = AmpuMapel.query.filter_by(nip=guru.nip).all()
        daftar_pembagian = PembagianKelas.query.filter_by(nip=guru.nip).all()
        query = AmpuMapel.query.filter_by(nip=guru.nip)
        
        # Ambil tahun unik dari tanggal ampu_mapel
        tahun_query = (
            db.session.query(extract('year', AmpuMapel.tanggal).label("tahun"))
            .filter_by(nip=guru.nip)
            .group_by(extract('year', AmpuMapel.tanggal))
            .order_by(extract('year', AmpuMapel.tanggal).desc())
            .all()
        )
    else:
        guru = Guru.query.all()
        data_ampu = AmpuMapel.query.all()
        daftar_pembagian = PembagianKelas.query.all()
        query = AmpuMapel.query

        # Ambil tahun unik dari tanggal ampu_mapel
        tahun_query = (
            db.session.query(extract('year', AmpuMapel.tanggal).label("tahun"))
            .group_by(extract('year', AmpuMapel.tanggal))
            .order_by(extract('year', AmpuMapel.tanggal).desc())
            .all()
        )
    # Ambil data untuk tampilan
    daftar_mapel = Mapel.query.all()
    daftar_semester = Semester.query.all()
    daftar_kelas = Kelas.query.all()
    daftar_tahun = TahunAkademik.query.order_by(TahunAkademik.id_tahun_akademik.desc()).all()
    
    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=10, type=int)
    # Mulai query dari AmpuMapel

    # Filter berdasarkan tanggal jika ada
    if tahun:
        query = query.filter(extract('year', AmpuMapel.tanggal) == tahun)
    if bulan:
        query = query.filter(extract('month', AmpuMapel.tanggal) == bulan)
    if tanggal:
        query = query.filter(extract('day', AmpuMapel.tanggal) == tanggal)

    # Urutkan berdasarkan ID (atau sesuaikan dengan kolom yang diinginkan)
    # Jangan urutkan pakai kolom dari table lain
    query = query.order_by(AmpuMapel.id_ampu.desc())


    # Pagination
    paginated_data = query.paginate(page=page, per_page=per_page, error_out=False)
    info_list = paginated_data.items
    # Cek total data dulu
    total_records = query.count()
    total_pages = (total_records + per_page - 1) // per_page

    # Jika halaman diminta melebihi total halaman, reset ke 1
    if page > total_pages:
        page = 1

    has_next = paginated_data.has_next
    has_prev = paginated_data.has_prev
    data_kbm = Kbm.query.all()
    page_range = range(max(1, page - 3), min(total_pages + 1, page + 3))
    keterangan = Keterangan.query.order_by(
        case(
            (Keterangan.id_keterangan == 1, 0),
            else_=1
        )
    ).all()

    # Serialize ke dict
    result = []
    for k in keterangan:
        result.append({
            "id_keterangan": k.id_keterangan,
            "keterangan": k.keterangan
        })

    for k in data_kbm:
        for l in info_list:
            if k.id_ampu == l.id_ampu:
                l.id_kbm = k.id_kbm
                l.materi = k.materi
                l.sub_materi = k.sub_materi
    # Ambil semua data pendukung untuk dropdown/filter
    data_guru = Guru.query.all()
    data_kelas = Kelas.query.all()
    data_mapel = Mapel.query.all()


    # Buat list tahun dari hasil query
    tahun_list = [int(row.tahun) for row in tahun_query if row.tahun is not None]
    return render_template("guru/list_ampu.html",
                            title="Pelajaran Diampu",
                            btn_tambah=True,
                            thn=tahun_list,
                            data_guru = data_guru,
                            data_kelas = data_kelas,
                            data_mapel = data_mapel,
                            data_ampu=info_list,
                            data_kbm=data_kbm,
                            keterangan=result,
                            daftar_mapel=daftar_mapel,
                            daftar_semester=daftar_semester,
                            daftar_kelas=daftar_kelas,
                            daftar_tahun=daftar_tahun,
                            daftar_pembagian=daftar_pembagian,
                            page=page,
                            per_page=per_page,
                            total_pages=total_pages,
                            total_records=total_records,
                            has_next=has_next,
                            has_prev=has_prev,
                            page_range=page_range)

@app.route("/kbm/list/tambah", methods=["POST"])
def kbm_tambah():
    try:
        id_semester=request.json.get('id_semester')
        id_kelas=request.json.get('id_kelas')
        id_tahun_akademik=request.json.get('id_tahun_akademik')
        if session['role'] =='guru':
            nip = session.get('nip', '')
        else:
            nip = request.json.get('nip')
        new_ampu = AmpuMapel(
            nip = nip,
            id_mapel = request.json.get('id_mapel'),
            id_pembagian = request.json.get('id_pembagian') or None,  # NULL -> None
            id_semester = id_semester,
            id_kelas = id_kelas,
            id_tahun_akademik = id_tahun_akademik,
            tanggal = datetime.datetime.now(datetime.timezone.utc)
        )
        db.session.add(new_ampu)
        db.session.commit()
        new_kbm = Kbm(
            materi = request.json.get('materi'),
            sub_materi = request.json.get('sub_materi'),
            id_ampu = new_ampu.id_ampu
        )
        
        db.session.add(new_kbm)
        db.session.commit()  # Commit new_kbm before adding attendance
        siswa_kelas = PembagianKelas.query.filter_by(id_kelas=id_kelas).filter_by(id_tahun_akademik=id_tahun_akademik).all()

        # Tambahkan data kehadiran default "Hadir"
        for siswa in siswa_kelas:
            new_kehadiran = Kehadiran(
                id_kbm=new_kbm.id_kbm,
                nis=siswa.nis,
                id_keterangan=1
            )
            db.session.add(new_kehadiran)

        db.session.commit()
        flash("Data berhasil ditambahkan", "success")
    except IntegrityError:
        db.session.rollback()
        flash("Gagal menambahkan data: ID pembagian tidak valid atau tidak ditemukan.", "danger")
    except Exception as e:
        db.session.rollback()
        flash(f"Terjadi kesalahan: {str(e)}", "danger")

    return jsonify({'msg':'Data berhasil ditambahkan'})

@app.route("/kbm/list/edit/<int:id>", methods=["PUT"])
def edit_ampu(id):
        ampu = AmpuMapel.query.get_or_404(id)
        ampu.id_mapel = request.json.get('id_mapel')
        ampu.id_pembagian = request.json.get('id_pembagian')
        ampu.id_semester = request.json.get('id_semester')
        ampu.id_tahun_akademik = request.json.get('id_tahun_akademik')
        db.session.commit()
        flash("Data berhasil diupdate", "success")
        
        return jsonify({'msg':'Data berhasil ditupdate'})
@app.route("/kbm/list/hapus/<int:id>", methods=["DELETE"])
def hapus_ampu(id):
    ampu = AmpuMapel.query.filter_by(id_ampu=id).first()
    if not ampu:
        return jsonify({'msg': 'Data ampu_mapel tidak ditemukan'}), 404

    # Hapus semua KBM yang terkait dengan ampu ini
    daftar_kbm = Kbm.query.filter_by(id_ampu=ampu.id_ampu).all()
    for kbm in daftar_kbm:
        db.session.delete(kbm)

    # Hapus semua kehadiran yang terkait dengan ampu ini
    daftar_kehidaran = Kehadiran.query.filter_by(id_kbm=ampu.id_ampu).all()
    for kehadiran in daftar_kehidaran:
        db.session.delete(kehadiran)
    db.session.delete(ampu)
    db.session.commit()

    flash("Data berhasil dihapus", "success")
    return jsonify({'msg': 'Data berhasil dihapus'})

@app.route('/guru/penilaian')
def penilaian_list():
    if session.get('role') != 'guru':
        abort(403)

    nip = session.get('nip')
    if not nip:
        abort(403)

    # Ambil objek guru
    guru = Guru.query.filter_by(nip=nip).first()
    if not guru:
        abort(404)

    data_siswa = Siswa.query.all()
    data_ampu = AmpuMapel.query.filter_by(nip=nip).all()
    data_guru = Guru.query.all()
    data_kelas = Kelas.query.all()
    data_mapel = Mapel.query.all()

    title = "Nilai Siswa"
    title_data = "Nilai Siswa"
    btn_tambah = True

    # Ambil filter query
    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=10, type=int)
    nis = request.args.get('nis')
    id_kelas = request.args.get('id_kelas')
    id_mapel = request.args.get('id_mapel')
    jenis_penilaian = request.args.get('jenis_penilaian')
    query = (
        Penilaian.query
        .join(AmpuMapel, Penilaian.id_ampu == AmpuMapel.id_ampu)
        .filter(AmpuMapel.nip == nip)
    )

    if tahun:
        query = query.filter(extract('year', Penilaian.tanggal) == tahun)
    if bulan:
        query = query.filter(extract('month', Penilaian.tanggal) == bulan)
    if tanggal:
        query = query.filter(extract('day', Penilaian.tanggal) == tanggal)
    if nis:
        query = query.filter(Penilaian.nis == nis)
    if id_mapel:
        query = query.filter(AmpuMapel.id_mapel == id_mapel)
    if jenis_penilaian:
        query = query.filter(Penilaian.jenis_penilaian == jenis_penilaian)
    if id_kelas:
        subq = (
            db.session.query(PembagianKelas.nis)
            .filter(PembagianKelas.id_kelas == id_kelas)
            .subquery()
        )
        query = query.filter(Penilaian.nis.in_(subq))

    query = query.order_by(Penilaian.id_penilaian.desc())
    # Pagination
    paginated_data = query.paginate(page=page, per_page=per_page, error_out=False)
    info_list = paginated_data.items
    total_records = query.count()
    total_pages = paginated_data.pages
    has_next = paginated_data.has_next
    has_prev = paginated_data.has_prev
    page_range = range(max(1, page - 3), min(total_pages + 1, page + 3))

    # Ambil tahun unik dari tanggal AmpuMapel
    tahun_query = (
        db.session.query(extract('year', AmpuMapel.tanggal).label("tahun"))
        .filter(AmpuMapel.nip == nip)
        .group_by(extract('year', AmpuMapel.tanggal))
        .order_by(extract('year', AmpuMapel.tanggal).desc())
        .all()
    )
    thn = [int(row.tahun) for row in tahun_query if row.tahun is not None]

    return render_template(
        'guru/penilaian.html',
        penilaian=info_list,
        tahun=thn,
        data_guru=data_guru,
        data_kelas=data_kelas,
        data_mapel=data_mapel,
        data_siswa=data_siswa,
        data_ampu=data_ampu,
        btn_tambah=btn_tambah,
        title=title,
        title_data=title_data,
        page=page,
        per_page=per_page,
        total_pages=total_pages,
        total_records=total_records,
        has_next=has_next,
        has_prev=has_prev,
        page_range=page_range
    )

@app.route('/guru/penilaian/tambah', methods=['POST'])
def tambah_penilaian():
    if session.get('role') != 'guru':
        abort(403)

    try:
        penilaian = Penilaian(
            nis=request.json.get('nis'),
            id_ampu=request.json.get('id_ampu'),
            jenis_penilaian=request.json.get('jenis_penilaian'),
            nilai=request.json.get('nilai'),
            tanggal=request.json.get('tanggal')  # Harus dalam format 'YYYY-MM-DD'
        )
        db.session.add(penilaian)
        db.session.commit()
        flash('Penilaian berhasil ditambahkan')
        return jsonify({'msg': 'Penilaian berhasil ditambahkan'}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 400

@app.route('/guru/penilaian/edit/<int:id_penilaian_old>', methods=['PUT'])
def edit_penilaian(id_penilaian_old):
    if session.get('role') != 'guru':
        abort(403)

    penilaian = Penilaian.query.get(id_penilaian_old)
    if not penilaian:
        return jsonify({'error': 'Penilaian tidak ditemukan'}), 404

    try:
        penilaian.nis = request.json.get('nis', penilaian.nis)
        penilaian.id_ampu = request.json.get('id_ampu', penilaian.id_ampu)
        penilaian.jenis_penilaian = request.json.get('jenis_penilaian', penilaian.jenis_penilaian)
        penilaian.nilai = request.json.get('nilai', penilaian.nilai)
        penilaian.tanggal = request.json.get('tanggal', penilaian.tanggal)  # Format: 'YYYY-MM-DD'

        db.session.commit()
        flash('Penilaian berhasil diperbarui')
        return jsonify({'msg': 'Penilaian berhasil diperbarui'})
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 400

@app.route('/guru/penilaian/hapus/<id_penilaian>', methods=['DELETE'])
def hapus_penilaian(id_penilaian):
    if session.get('role') != 'guru':
        abort(403)
    penilaian = Penilaian.query.filter_by(id_penilaian=id_penilaian).first()
    if not penilaian:
        return jsonify({'error': 'penilaian tidak ditemukan'}), 404
    db.session.delete(penilaian)
    db.session.commit()
    flash('penilaian berhasil dihapus')
    return jsonify({'msg': 'penilaian berhasil dihapus'})
@app.route('/api/kehadiran/siswa')
def api_kehadiran_siswa():
    id_kbm = request.args.get('id_kbm')
    siswa_list = (
        db.session.query(Siswa.nama, PembagianKelas.nis, Kelas.nama_kelas, Kehadiran.id_keterangan)
        .join(PembagianKelas, PembagianKelas.nis == Siswa.nis)
        .join(Kelas, Kelas.id_kelas == PembagianKelas.id_kelas)
        .join(Kehadiran, Kehadiran.nis == Siswa.nis)
        .filter(Kehadiran.id_kbm == id_kbm)
        .all()
    )
    return jsonify([{'nama': s[0], 'nis': s[1], 'nama_kelas': s[2],'id_keterangan': s[3]} for s in siswa_list])

@app.route('/guru/kehadiran/tambah', methods=['POST'])
def simpan_kehadiran_siswa():
    id_ampu = request.form['id_ampu']
    tanggal = datetime.datetime.now().date()

    # Tambahkan data ke KBM (karena kehadiran harus ada ID KBM)
    kbm = Kbm(tanggal=tanggal, materi='Kehadiran', sub_materi='-', id_ampu=id_ampu)
    db.session.add(kbm)
    db.session.flush()  # agar dapatkan id_kbm sebelum commit

    for key in request.form:
        if key.startswith('status['):
            nis = key[7:-1]  # ambil angka di dalam status[20001]
            status = request.form[key]
            id_keterangan = status  # fungsi untuk mapping
            kehadiran = Kehadiran(id_kbm=kbm.id_kbm, nis=int(nis), id_keterangan=id_keterangan)
            db.session.add(kehadiran)

    db.session.commit()
    return '', 200
