# Import library bawaan Python
import os
import textwrap
import locale
import uuid
from decimal import Decimal
# Import library pihak ketiga
from datetime import datetime, timedelta
from io import BytesIO
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
from . import AmpuMapel, Kelas, Mapel, PembagianKelas, Semester, TahunAkademik, app, db, project_directory, User, Siswa, Guru, Role, bcrypt, JadwalPelajaran

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
    return jsonify({
        'nip': nip,
        'email': data_guru.email,
        'nip': nip,
        'username': user.username if user else '',
        'role': role
    })

@app.route('/edit_guru', methods=['POST'])
def edit_guru():
    nip = request.form['nip']
    username = request.form['username']
    email = request.form['email']
    nip = request.form['nip']
    password = request.form.get('password')
    role = request.form['role']

    user = User.query.filter_by(nip=nip).first()

    # Cek jika sedang edit user yang sudah ada
    if user:
        # Cek jika username/email yang baru mau diganti ke milik orang lain
        if User.query.filter(User.username == username, User.id != user.id).first():
            flash('Username sudah digunakan oleh user lain', 'danger')
            return redirect('/register_guru')
        if User.query.filter(User.email == email, User.id != user.id).first():
            flash('Email sudah digunakan oleh user lain', 'danger')
            return redirect('/register_guru')

        user.username = username
        user.email = email
        if password:
            user.password = bcrypt.generate_password_hash(password).decode('utf-8')
        user.roles = []  # Kosongkan role lama
        new_role = Role.query.filter_by(name=role).first()
        if new_role:
            user.roles.append(new_role)
        db.session.commit()
        flash('Data guru berhasil diperbarui', 'success')

    else:
        # Cek kalau username/email sudah dipakai
        if User.query.filter_by(username=username).first():
            flash('Username sudah digunakan', 'danger')
            return redirect('/register_guru')
        if User.query.filter_by(email=email).first():
            flash('Email sudah digunakan', 'danger')
            return redirect('/register_guru')

        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
        user = User(
            username=username,
            password=hashed_password,
            email=email,
            active=True,
            nip=nip  # jangan lupa set nip!
        )
        new_role = Role.query.filter_by(name=role).first()
        if new_role:
            user.roles.append(new_role)
        db.session.add(user)
        db.session.commit()
        flash('Data User berhasil dibuat', 'success')

    return redirect('/register_guru')

@app.route('/hapus_guru/<nip>', methods=['POST'])
def hapus_guru(nip):
    user = User.query.filter_by(nip=nip).first()
    data_guru = Guru.query.filter_by(nip=nip).first()
    if user:
        db.session.delete(user)
    if data_guru:
        db.session.delete(data_guru)
    db.session.commit()
    flash('Data guru berhasil dihapus', 'success')
    return redirect('/register_guru')

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
    return render_template('admin/pembagian_kelas_list.html', data=data)

@app.route('/admin/pembagian_kelas/tambah', methods=['GET', 'POST'])
def tambah_pembagian_kelas():
    if session.get('role') != 'admin':
        abort(403)
    if request.method == 'POST':
        pembagian = PembagianKelas(
            tanggal=request.form['tanggal'],
            nis=request.form['nis'],
            id_kelas=request.form['id_kelas'],
            id_tahun_akademik=request.form['id_tahun_akademik'],
            nip=request.form['nip']
        )
        db.session.add(pembagian)
        db.session.commit()
        flash('Pembagian kelas berhasil ditambahkan')
        return redirect('/admin/pembagian_kelas')
    siswa = Siswa.query.all()
    kelas = Kelas.query.all()
    guru = Guru.query.all()
    tahun_akademik = TahunAkademik.query.all()
    return render_template('admin/tambah_pembagian_kelas.html', siswa=siswa, kelas=kelas, guru=guru, tahun_akademik=tahun_akademik)

@app.route('/admin/ampu_mapel')
def ampu_mapel_list():
    if session.get('role') != 'admin':
        abort(403)
    data = AmpuMapel.query.all()
    return render_template('admin/ampu_mapel_list.html', data=data)

@app.route('/admin/ampu_mapel/tambah', methods=['POST'])
def tambah_ampu_mapel():
    if session.get('role') != 'admin':
        abort(403)
    ampu = AmpuMapel(
            tanggal=request.form['tanggal'],
            id_semester=request.form['id_semester'],
            id_mapel=request.form['id_mapel'],
            nip=request.form['nip'],
            id_tahun_akademik=request.form['id_tahun_akademik'],
            id_pembagian=request.form['id_pembagian']
        )
    db.session.add(ampu)
    db.session.commit()
    flash('Ampu mapel berhasil ditambahkan')
    return redirect('/admin/ampu_mapel')
    guru = Guru.query.all()
    semester = Semester.query.all()
    mapel = Mapel.query.all()
    tahun_akademik = TahunAkademik.query.all()
    pembagian = PembagianKelas.query.all()
    return render_template('admin/tambah_ampu_mapel.html', guru=guru, semester=semester, mapel=mapel, tahun_akademik=tahun_akademik, pembagian=pembagian)


@app.route('/admin/kelas')
def kelas_list():
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas.query.all()
    return render_template('admin/kelas.html', kelas=kelas)

@app.route('/admin/kelas/tambah', methods=['POST'])
def tambah_kelas():
    if session.get('role') != 'admin':
        abort(403)
    kelas = Kelas(
        id_kelas=request.form['id_kelas'],
        nama_kelas=request.form['nama_kelas'],
        tingkat=request.form['tingkat']
    )
    db.session.add(kelas)
    db.session.commit()
    flash('Kelas berhasil ditambahkan')
    return redirect('/admin/kelas')

@app.route('/admin/kelas/edit/<int:id_kelas>', methods=['PUT'])
def edit_kelas(id_kelas):
    if session.get('role') != 'admin':
        abort(403)
    kelas = kelas.query.get_or_404(id_kelas)
    kelas.nama_kelas = request.form['nama_kelas']
    db.session.commit()
    flash('kelas berhasil diperbarui')
    return redirect('/admin/kelas')

@app.route('/admin/kelas/hapus/<int:id_kelas>', methods=['DELETE'])
def hapus_kelas(id_kelas):
    if session.get('role') != 'admin':
        abort(403)
    kelas = kelas.query.get_or_404(id_kelas)
    db.session.delete(kelas)
    db.session.commit()
    flash('kelas berhasil dihapus')
    return redirect('/admin/kelas')


@app.route('/admin/semester')
def semester_list():
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.all()
    btn_tambah = True
    return render_template('admin/semester.html', semester=semester, btn_tambah=btn_tambah)

@app.route('/admin/semester/tambah', methods=['POST'])
def tambah_semester():
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester(
            id_semester=request.form['id_semester'],
            nama_semester=request.form['nama_semester']
    )
    db.session.add(semester)
    db.session.commit()
    flash('Semester berhasil ditambahkan')
    return redirect('/admin/semester')

@app.route('/admin/semester/edit/<int:id_semester>', methods=['PUT'])
def edit_semester(id_semester):
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.get_or_404(id_semester)
    semester.nama_semester = request.form['nama_semester']
    db.session.commit()
    flash('Semester berhasil diperbarui')
    return redirect('/admin/semester')

@app.route('/admin/semester/hapus/<int:id_semester>', methods=['DELETE'])
def hapus_semester(id_semester):
    if session.get('role') != 'admin':
        abort(403)
    semester = Semester.query.get_or_404(id_semester)
    db.session.delete(semester)
    db.session.commit()
    flash('Semester berhasil dihapus')
    return redirect('/admin/semester')
