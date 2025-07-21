from . import app, bcrypt, User,Role,UserRoles, mail,db,Berita, Kelas,TahunAkademik, EvaluasiGuru, Siswa, Guru, Penilaian, JadwalPelajaran, PembagianKelas, Siswa
from flask import request, render_template, redirect, url_for, jsonify, session, flash
from flask_jwt_extended import unset_jwt_cookies
from datetime import datetime, timedelta
import jwt
from sqlalchemy import func, extract
from flask_mail import Message
from jwt import ExpiredSignatureError, InvalidTokenError
from itsdangerous import URLSafeTimedSerializer, SignatureExpired, BadSignature

@app.route('/')
def homepahe():
    return redirect(url_for('login'))
    #return render_template('index.html')
@app.route('/login')
def login():
    return render_template('login.html')

@app.route('/proses_login', methods=['POST'])
def proses_login():
    username = request.json['username']
    password = request.json['password']

    user = User.query.filter_by(username=username).first()

    if not user:
        return jsonify(success=False, message="Username salah")

    if bcrypt.check_password_hash(user.password, password):
        payload = {
            'username': username,
            'role': user.roles[0].name if user.roles else None,
            'email' : user.email,
            'exp': datetime.utcnow()+timedelta(hours=7) + timedelta(hours=24)
        }
        access_token = jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')
        session['jwt_token'] = access_token
        session['username'] = username
        session['id'] = user.id
        session['email'] = user.email
        if user.roles:
            session['role'] = user.roles[0].name
        else:
            session['role'] = None
        if user.roles[0].name == 'guru':
            session['nip'] = user.nip
        elif user.roles[0].name == 'murid':
            session['nis'] = user.nis
        else:
            session['role'] = 'admin'

        return jsonify(success=True, token=access_token)
    else:
        return jsonify(success=False, message="Password salah")

@app.route('/reset_password_admin', methods=['GET'])
def reset_password_admin():
    admin = User.query.join(UserRoles).join(Role).filter(Role.name == 'admin').first()
    if not admin:
        return jsonify(success=False, message="Tidak ada admin ditemukan"), 404

    email = admin.email
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    token = serializer.dumps(email, salt='reset-password') # 1 jam

    reset_link = url_for('reset_password_form', token=token, _external=True)
    print(f"🔗 Reset link: {reset_link}")

    try:
        msg = Message("Reset Password Admin",
                      sender=app.config['MAIL_USERNAME'],
                      recipients=[email])
        msg.body = f"Klik link untuk reset password:\n{reset_link} \n link expired dalam 1 jam"
        mail.send(msg)
    except Exception as e:
        print(f"❌ Error mengirim email: {e}")
        return jsonify(success=False, message="Gagal mengirim email"), 500
    flash("Link reset password dikirim ke email", "success")
    return redirect(url_for('login'))

@app.route('/reset_password/<token>', methods=['GET'])
def reset_password_form(token):
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    try:
        email = serializer.loads(token, salt='reset-password', max_age=3600)  # 1 jam
    except SignatureExpired:
        return "<h3>Token sudah kadaluarsa</h3>", 400
    except BadSignature:
        return "<h3>Token tidak valid</h3>", 400

    return render_template('reset_password_admin.html', token=token)

@app.route('/reset_admin_form', methods=['POST'])
def reset_password_submit():
    token = request.form.get('token')
    new_password = request.form.get('new_password')

    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    try:
        email = serializer.loads(token, salt='reset-password', max_age=3600)
    except SignatureExpired:
        return "<h3>Token sudah kadaluarsa</h3>", 400
    except BadSignature:
        return "<h3>Token tidak valid</h3>", 400

    admin = User.query.filter_by(email=email).first()
    if not admin:
        return "<h3>User tidak ditemukan</h3>", 404

    admin.password = bcrypt.generate_password_hash(new_password).decode('utf-8')
    db.session.commit()

    return "<h3>Password berhasil diubah. Silakan </h3><a href='/'>login kembali</a>."

# Endpoint yang memerlukan autentikasi
@app.route('/keluar')
def keluar():
    # Hapus token dari cookie (anda bisa menghapus token dari header juga jika tidak menggunakan cookie)
    response = jsonify({'message': 'Logout berhasil'})
    unset_jwt_cookies(response)
    session.pop('jwt_token', None)
    session.pop('username', None)
    flash('Sukses Logout')
    return redirect(url_for('login'))
    

@app.before_request
def global_jwt_check():
    # Lewatkan route tertentu seperti login, register, static, dll.
    allowed_routes = ['login', 'static', 'proses_login', 'register','reset_password_admin','reset_password_form','reset_password_submit']
    if request.endpoint in allowed_routes or request.endpoint is None:
        return  # skip checking

    token = session.get('jwt_token') or request.headers.get('Authorization')

    if not token:
        return redirect(url_for('login'))

    try:
        decoded = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        # Simpan user info jika perlu
        request.user = decoded
    except ExpiredSignatureError:
        session.clear()  # hapus sesi
        return redirect(url_for('login'))
    except InvalidTokenError:
        session.clear()
        return redirect(url_for('login'))

@app.route('/dashboard')
def dashboard():
    role = session.get('role')
    user = User.query.filter_by(username=session.get('username')).first()
    # Ambil berita terbaru < 14 hari
    batas_waktu = datetime.utcnow()+timedelta(hours=7) - timedelta(days=14)
  
    profil = {}
    evaluasi = False
    berita_terbaru = None
    if role == 'admin':
        data_guru = Guru.query.all()
        profil = {
            'username': user.username,
            'email': user.email,
            'role': 'Admin'
        }
        berita_terbaru = None
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
        
        data_guru = Guru.query.all()
        for i in range(11, -1, -1):
            target_date = now.replace(day=1) - timedelta(days=30*i)
            bulan = target_date.strftime('%b %Y')
            avg_nilai = db.session.query(func.avg(Penilaian.nilai)).filter(
                extract('month', Penilaian.tanggal) == target_date.month,
                extract('year', Penilaian.tanggal) == target_date.year
            ).scalar()

            chart_bulan.append(bulan)
            chart_rata.append(round(avg_nilai, 2) if avg_nilai else 0)
        chart_data={
                'bulan': chart_bulan,
                'rata_rata': chart_rata
            }
        return render_template('dashboard.html',
            
        data_guru = data_guru,
            evaluasi=evaluasi,
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
            'nip': guru.nip,
            'img_profile':user.img_profile,
            'username': user.username,
            'nama': guru.nama,
            'inisial': guru.inisial,
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
        data_guru = Guru.query.all()

    elif role == 'murid':
        berita_terbaru = Berita.query.filter(Berita.tanggal_dibuat >= batas_waktu, Berita.pengumuman_untuk == 'murid').order_by(Berita.tanggal_dibuat.desc()).first()
        
        # 1. Ambil tahun akademik dan semester aktif
        tahun_aktif = TahunAkademik.query.order_by(TahunAkademik.mulai.desc()).first()

        if tahun_aktif:
            tanggal_awal = tahun_aktif.mulai
            tanggal_akhir = tahun_aktif.sampai
        else:
            tanggal_awal = tanggal_akhir = datetime.utcnow() +timedelta(hours=7)  # fallback kalau gak ada

        # 2. Cek apakah ada evaluasi guru untuk siswa ini di semester ini
        evaluasi_exist = EvaluasiGuru.query.filter(
        EvaluasiGuru.evaluator_id == session['id'],
        EvaluasiGuru.tanggal >= tanggal_awal,
        EvaluasiGuru.tanggal <= tanggal_akhir
        ).first()
        # 3. Set flag evaluasi
        evaluasi = False if evaluasi_exist else True
        data_guru = Guru.query.all()
        siswa = Siswa.query.filter_by(nis=user.nis).first()
        kelas_aktif = PembagianKelas.query.filter_by(nis=siswa.nis).order_by(PembagianKelas.tanggal.desc()).first()
        profil = {
            'img_profile':user.img_profile,
            'username': user.username,
            'nama': siswa.nama,
            'nis': siswa.nis,
            'tempat_lahir': siswa.tempat_lahir,
            'tanggal_lahir': siswa.tanggal_lahir,
            'alamat': siswa.alamat,
            'no_hp': siswa.no_hp,
            'email': session.get('email',''),
            'gender': siswa.gender_rel.gender,
            'status': siswa.status_rel.status,
            'kelas': kelas_aktif.kelas_rel.nama_kelas if kelas_aktif else 'Belum dibagi',
            'role': 'Murid'
        }
    
    return render_template('dashboard.html',
        data_guru = data_guru, profil=profil, evaluasi=evaluasi,berita=berita_terbaru)


# @app.route('/bikin_akun', methods=['GET', 'POST'])
# def register():
#     if request.method == 'POST':
#         # Tidak perlu jwt_required()

#         username = request.form.get('username')
#         password = request.form.get('password')

#         if not username or not password:
#             return jsonify({"msg": "Username dan password wajib diisi"}), 400

#         if User.query.filter_by(username=username).first():
#             return jsonify({"msg": "Username sudah digunakan"}), 400

#         hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

#         user = User(username=username, password=hashed_password, active=True)
#         db.session.add(user)
#         db.session.commit()

#         return jsonify({"msg": "Akun berhasil dibuat"}), 201

#     # Jika GET request, tampilkan form HTML atau pesan
#     return render_template('admin/register.html')

#         # Logout setelah registrasi berhasil
#         response = jsonify({'message': 'Logout berhasil'})
#         unset_jwt_cookies(response)
#         session.pop('jwt_token', None)
#         session.pop('username', None)
#         flash('Sukses Logout')
#         return redirect(url_for('login', msg='Registration Successful'))

#     return render_template('admin/register.html')
