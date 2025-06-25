# Import library bawaan Python
import os
import textwrap
import locale
import uuid
from decimal import Decimal
# Import library pihak ketiga
from datetime import datetime, timedelta
from io import BytesIO
import jwt
from openpyxl import Workbook
from openpyxl.utils import get_column_letter
from openpyxl.styles import Font, Alignment
import calendar
from io import BytesIO
from flask import abort, render_template, request, jsonify, g, send_file, session
from PIL import Image
from dateutil.relativedelta import relativedelta
from flask_jwt_extended import jwt_required
# Fungsi untuk mengubah angka menjadi teks (terbilang)
from num2words import num2words
from flask import flash, redirect
# Import dari aplikasi lokal
from . import AmpuMapel,Kelas, Mapel,EvaluasiGuru, UserRoles,Role, PembagianKelas, Semester, TahunAkademik, app, db, project_directory, User, Siswa, Guru, Role, bcrypt, JadwalPelajaran,Berita, Tagihan, Gender, Status


# Fungsi untuk mengelola gambar (upload, edit, delete)
def do_image(do, table, id):
    try:
        if do == "delete":
            filename = get_image_filename(table, id)
            delete_image(filename)
            return True

        # Upload gambar baru
        file = request.files['gambar']
        if file is None or file.filename == '':
            return "default.jpg"
        else:
            filename = get_image_filename(table, id)
            delete_image(filename)
            return resize_and_save_image(file, table, id)

    except KeyError:
        # Jika kunci 'gambar' tidak ada dalam request.files
        if do == "edit" and table == "galeri":
            return True
        reset = request.form.get('reset', 'false')
        if reset == "true":
            g.con.execute(f"UPDATE {table} SET gambar = %s WHERE id = %s", ("default.jpg", id))
            g.con.connection.commit()
        return "default.jpg"

    except FileNotFoundError:
        pass  # Jika file tidak ditemukan, abaikan

    except Exception as e:
        print(str(e))
        return str(e)

# Fungsi untuk mengubah ukuran dan menyimpan gambar
def resize_and_save_image(file, table=None, id=None):
    img = Image.open(file).convert('RGB').resize((600, 300))
    random_name = uuid.uuid4().hex + ".jpg"
    destination = os.path.join(app.config['UPLOAD_FOLDER'], random_name)
    img.save(destination)

    if table and id:
        g.con.execute(f"UPDATE {table} SET gambar = %s WHERE id = %s", (random_name, id))
        g.con.connection.commit()
        return True
    else:
        return random_name

# Fungsi untuk mendapatkan nama file gambar dari database
def get_image_filename(table, id):
    g.con.execute(f"SELECT gambar FROM {table} WHERE id = %s", (id,))
    result = g.con.fetchone()
    if result == "default.jpg":
        return None
    return result[0] if result else None

# Fungsi untuk menghapus file gambar dari server
def delete_image(filename):
    if filename == "default.jpg":
        return True
    if filename:
        image_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        if os.path.exists(image_path):
            os.remove(image_path)

# Fungsi untuk mengambil data dari database dan mengubahnya menjadi format dictionary
def fetch(query, params=None):
    g.con.execute(query, params or ())
    data = g.con.fetchall()
    column_names = [desc[0] for desc in g.con.description]
    return [dict(zip(column_names, row)) for row in data]

# Fungsi untuk mengambil daftar tahun dari database
def fetch_years(query):
    g.con.execute(query)
    data_thn = g.con.fetchall()
    return [{'tahun': str(sistem[0])} for sistem in data_thn]

#function di render_template
@app.template_filter('format_currency')
def format_currency(value):
    locale.setlocale(locale.LC_ALL, 'id_ID.UTF-8')
    return locale.currency(value, grouping=True, symbol='Rp')

@app.template_filter('clean_currency')
def clean_currency(value):
    """Remove 'Rp', dots, and spaces, then convert to float"""
    cleaned_value = value.replace('Rp', '').replace('RP', '').replace('.', '').replace(',', '.').strip()
    return float(cleaned_value)

@app.template_filter('floatformat')
def floatformat(value, precision=2):
    try:
        return f"{float(value):.{precision}f}"
    except (ValueError, TypeError):
        return value
    
def req(key):
    return request.json.get(key)

@app.template_filter('format_rupiah')
def format_rupiah(value):
    try:
        return f"{int(value):,}".replace(",", ".")
    except (ValueError, TypeError):
        return value
    
list_bulan = [{"value":"1","nama_bulan":"Januari"},{"value":"2","nama_bulan":"Februari"},{"value":"3","nama_bulan":"Maret"},
                {"value":"4","nama_bulan":"April"},{"value":"5","nama_bulan":"Mei"},{"value":"6","nama_bulan":"Juni"},{"value":"7","nama_bulan":"Juli"},
                {"value":"8","nama_bulan":"Agustus"},{"value":"9","nama_bulan":"September"},{"value":"10","nama_bulan":"Oktober"},
                {"value":"11","nama_bulan":"November"},{"value":"12","nama_bulan":"Desember"}] 
             
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


@app.route('/hapus_jadwal', methods=['DELETE'])
def hapus_jadwal():
    data = request.get_json()
    print(data)
    day = data.get('day')
    period = data.get('period')
    if not day or not period:
        return jsonify({'error': 'Day dan periode wajib diisi'}), 400

    # Cari jadwal yang sesuai
    jadwal = JadwalPelajaran.query.filter_by(day=day, period=period).first()

    if not jadwal:
        return jsonify({'error': 'Data jadwal tidak ditemukan'}), 404

    # Hapus dari database
    db.session.delete(jadwal)
    db.session.commit()

    return jsonify({'msg': 'Jadwal berhasil dihapus'}), 200
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

@app.route('/admin/ampu_mapel')
def ampu_mapel_list():
    if session.get('role') != 'admin':
        abort(403)
    data = AmpuMapel.query.all()
    
    btn_tambah = True
    title = "Manage Ampu Mapel"
    title_data = "Ampu Mapel"
    return render_template('admin/ampu_mapel_list.html', ampu_mapel = data,btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/kelas')
def kelas_list():
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas.query.all()
    btn_tambah = True
    title = "Manage Kelas"
    title_data = "Kelas"
    return render_template('admin/kelas.html', kelas=kelas,btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/semester')
def semester_list():
    print(session.get('role'))
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.all()
    btn_tambah = True
    title = "Manage Semester"
    title_data = "Semester"
    return render_template('admin/semester.html', semester=semester, btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/ampu_mapel/tambah', methods=['POST'])
def tambah_ampu_mapel():
    if session.get('role') != 'admin':
        abort(403)
    ampu = AmpuMapel(
            tanggal=request.json.get('tanggal'),
            id_semester=request.json.get('id_semester'),
            id_mapel=request.json.get('id_mapel'),
            nip=request.json.get('nip'),
            id_tahun_akademik=request.json.get('id_tahun_akademik'),
            id_pembagian=request.json.get('id_pembagian')
        )
    db.session.add(ampu)
    db.session.commit()
    flash('Ampu mapel berhasil ditambahkan')
    return jsonify({'msg': 'Ampu mapel berhasil ditambahkan'})

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

@app.route('/admin/kelas/edit/<id_kelas>', methods=['PUT'])
def edit_kelas(id_kelas):
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas.query.filter_by(id_kelas=id_kelas).first()
    if not kelas:
        return jsonify({'error': 'Kelas tidak ditemukan'}), 404
    kelas.id_kelas = request.json.get('id_kelas')
    kelas.nama_kelas = request.json.get('nama_kelas')
    kelas.tingkat = request.json.get('tingkat')
    db.session.commit()
    flash('Kelas berhasil diperbarui')
    return jsonify({'msg': 'Kelas berhasil diperbarui'})

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

@app.route('/admin/semester/tambah', methods=['POST'])
def tambah_semester():
    print(session.get('role'))
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
    return render_template('guru/berita.html', berita=berita, guru=guru,btn_tambah=btn_tambah,title=title,title_data=title_data)

@app.route('/manage_pengumuman/tambah', methods=['POST'])
def tambah_pengumuman():
    print(session.get('role'))
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
    berita = Berita.query.filter_by(id_berita=id_pengumuman).first()
    if not berita:
        return jsonify({'error': 'berita tidak ditemukan'}), 404
    db.session.delete(berita)
    db.session.commit()
    flash('berita berhasil dihapus')
    return jsonify({'msg': 'berita berhasil dihapus'})
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
        penghasilan_ayah=int(data.get('penghasilan_ayah')),
        penghasilan_ibu=int(data.get('penghasilan_ibu')),
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
    if session.get('role') == 'murid':
        abort(403)

    siswa = Siswa.query.get(nis)
    if not siswa:
        return jsonify({'error': 'Siswa tidak ditemukan'}), 404

    data = request.json
    print(nis)
    print(data.get('nis'))
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
# === LIST EVALUASI GURU ===
@app.route('/evaluasi_guru')
def evaluasi_guru_list():
    if session.get('role') == 'guru':
        btn_tambah = False
    evaluasi_list = EvaluasiGuru.query.all()
    guru = Guru.query.all()
    users = User.query.all()
    ampu = AmpuMapel.query.all()
    title = "Manage Evaluasi Guru"
    title_data = "Evaluasi Guru"
    btn_tambah = True
    return render_template('admin/evaluasi_guru.html', ampu=ampu, guru=guru,users=users, btn_tambah=btn_tambah, evaluasi=evaluasi_list, title=title, title_data=title_data)

# === TAMBAH EVALUASI GURU ===
@app.route('/evaluasi_guru/tambah', methods=['POST'])
def tambah_evaluasi_guru():
    if session.get('role') == 'guru':
        abort(403)
    
    evaluasi = EvaluasiGuru(
        nip=request.json.get('nip'),
        id_ampu=request.json.get('id_ampu'),
        evaluator_id=request.json.get('evaluator_id'),
        evaluator_role=request.json.get('evaluator_role'),
        aspek=request.json.get('aspek'),
        skor=request.json.get('skor'),
        komentar=request.json.get('komentar')
    )
    db.session.add(evaluasi)
    db.session.commit()
    flash('Evaluasi berhasil ditambahkan')
    return jsonify({'msg': 'Evaluasi berhasil ditambahkan'})

# === EDIT EVALUASI GURU ===
@app.route('/evaluasi_guru/edit/<int:id>', methods=['PUT'])
def edit_evaluasi_guru(id):
    if session.get('role') != 'admin':
        abort(403)

    evaluasi = EvaluasiGuru.query.get_or_404(id)
    data = request.get_json()

    # Validasi wajib isi
    if not data.get('aspek') or data.get('skor') is None:
        return jsonify({'error': 'Aspek dan skor wajib diisi'}), 400

    try:
        skor = int(data['skor'])
    except (ValueError, TypeError):
        return jsonify({'error': 'Skor harus berupa angka'}), 400

    if not 1 <= skor <= 100:
        return jsonify({'error': 'Skor harus antara 1 sampai 100'}), 400

    # Update field
    evaluasi.aspek = data['aspek']
    evaluasi.skor = skor
    evaluasi.komentar = data.get('komentar')

    # Optional fields: cuma update jika ada
    evaluasi.nip = data.get('nip', evaluasi.nip)
    evaluasi.id_ampu = data.get('id_ampu', evaluasi.id_ampu)
    evaluasi.evaluator_id = data.get('evaluator_id', evaluasi.evaluator_id)
    evaluasi.evaluator_role = data.get('evaluator_role', evaluasi.evaluator_role)

    db.session.commit()
    flash('Evaluasi berhasil diperbarui')
    return jsonify({'msg': 'Evaluasi berhasil diperbarui'})

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

@app.route('/admin/mapel')
def mapel_list():
    print(session.get('role'))
    if session.get('role') != 'admin':
        abort(403)
    mapel = Mapel.query.all()
    btn_tambah = True
    title = "Manage Mapel"
    title_data = "Mapel"
    return render_template('admin/mapel.html', mapel=mapel, btn_tambah=btn_tambah, title=title, title_data = title_data)

@app.route('/admin/mapel/tambah', methods=['POST'])
def tambah_mapel():
    print(session.get('role'))
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

@app.route('/admin/mapel/edit/<id_mapel_old>', methods=['PUT'])
def edit_mapel(id_mapel_old):
    if session.get('role') != 'admin':
        abort(403)
    mapel = Mapel.query.filter_by(id_mapel=id_mapel_old).first()
    if not mapel:
        return jsonify({'error': 'Mapel tidak ditemukan'}), 404
    mapel.id_mapel = request.json.get('id_mapel')
    mapel.nama_mapel = request.json.get('nama_mapel')
    db.session.commit()
    flash('Mapel berhasil diperbarui')
    return jsonify({'msg': 'Mapel berhasil diperbarui'})

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
