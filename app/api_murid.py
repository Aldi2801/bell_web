import os, uuid, jwt, datetime, ast, pandas as pd
from . import EvaluasiGuru, Kelas, Siswa, TahunAkademik, app, db,allowed_file_surat_izin, Tagihan,JadwalPelajaran, Transaksi, AmpuMapel, Kehadiran,Penilaian, Mapel, PembagianKelas, Berita, Guru,User
from flask import flash, render_template, request, jsonify, session, redirect, abort, url_for, send_file, jsonify
from datetime import datetime
from sqlalchemy import extract, case
from collections import defaultdict
from io import BytesIO
from openpyxl import Workbook
from reportlab.platypus import SimpleDocTemplate, Table, TableStyle, Paragraph
from reportlab.lib.pagesizes import A4, landscape
from reportlab.lib import colors
from reportlab.lib.styles import getSampleStyleSheet
from reportlab.lib.pagesizes import A3

@app.route('/get_menu_pembayaran')
def get_menu_pembayaran():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token is missing'}), 403

    try:
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        user_email = decoded_token['email']
        role = decoded_token['role']

        # Ambil semua tagihan
        if role == 'murid':
            all_tagihan = Tagihan.query.filter_by(
                user_id=session['id'],
            ).all()

            paid_transactions = Transaksi.query.filter(
                Transaksi.email == user_email,
                Transaksi.status.in_(['settlement', 'paid'])
            ).all()
        else:
            # admin / guru
            all_tagihan = Tagihan.query.all()

            paid_transactions = Transaksi.query.filter(
                Transaksi.status.in_(['settlement', 'paid'])
            ).all()

        # Buat set id_tagihan yang sudah lunas
        paid_tagihan_ids = {tr.id_tagihan for tr in paid_transactions if tr.id_tagihan is not None}

        def get_siswa_data(user_id,tahun_ajaran=None):
            user = User.query.filter_by(id=user_id).first()
            if not user or not user.nis:
                return None

            siswa = Siswa.query.filter_by(nis=user.nis).first()
            if not siswa:
                return None
            print(user_id)
            print(tahun_ajaran)
            tahun_akademik = TahunAkademik.query.filter_by(tahun_akademik=tahun_ajaran).first() if tahun_ajaran else None
            print(f"{siswa.nis} tahun_akademik: {tahun_akademik.id_tahun_akademik if tahun_akademik else 'None'}")
            pembagian = PembagianKelas.query \
                .filter_by(nis=siswa.nis, id_tahun_akademik = tahun_akademik.id_tahun_akademik ) \
                .first()
            print(f"{siswa.nis} pembagian: {pembagian.id_kelas if pembagian else 'None'}")
            kelas_nama = pembagian.kelas_rel.nama_kelas if pembagian and pembagian.kelas_rel else 'Belum dibagi'
            print(f"{siswa.nis} kelas_nama: {kelas_nama}")
            data = {
                'nama': siswa.nama,
                'kelas': kelas_nama
            }
            return data

        # Bangun response
        result_tagihan = []
        for t in all_tagihan:
            status = 'Lunas' if t.id_tagihan in paid_tagihan_ids else 'Belum Lunas'
            print(t.user_id)
            print(t.tahun_ajaran)
            siswa_info = None
            siswa_info = get_siswa_data(t.user_id, t.tahun_ajaran) 
            print(f"siswa {siswa_info}")
            result = {
                'id_tagihan': t.id_tagihan,
                'deskripsi': t.deskripsi,
                'total': t.total,
                'semester': t.semester,
                'tahun_ajaran': t.tahun_ajaran,
                'created_at': (
                    t.created_at.strftime("%d-%m-%Y %H:%M")
                ),
                'status': status,
                'siswa': siswa_info  # tambahkan ini jika ingin tampilkan info siswa
            }

            if siswa_info:
                result['nama_siswa'] = siswa_info['nama']
                result['kelas'] = siswa_info['kelas']
                print(f"Tagihan {t.id_tagihan} siswa: {siswa_info['nama']} kelas: {siswa_info['kelas']}")

            result_tagihan.append(result)
        if result_tagihan ==[]:
            return jsonify({"message": "Data tagihan tidak ditemukan"})
        else:
            return jsonify(result_tagihan)

    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403

@app.route('/export_tagihan_excel')
def export_tagihan_excel():
    if not session.get('email'):
        return jsonify({'message': 'Token is missing'}), 403
    if not session.get('role'):
        return jsonify({'message': 'Token is missing'}), 403
    try:
        user_email = session.get('email')
        role = session.get('role')

        if role == 'murid':
            all_tagihan = Tagihan.query.filter_by(user_id=session['id']).all()
            paid_transactions = Transaksi.query.filter(
                Transaksi.email == user_email,
                Transaksi.status.in_(['settlement', 'paid'])
            ).all()
        else:
            all_tagihan = Tagihan.query.all()
            paid_transactions = Transaksi.query.filter(
                Transaksi.status.in_(['settlement', 'paid'])
            ).all()

        paid_tagihan_ids = {tr.id_tagihan for tr in paid_transactions if tr.id_tagihan is not None}
        siswa_map = {}

        def get_siswa_data(user_id):
            user = User.query.filter_by(id=user_id).first()
            if not user or not user.nis:
                return None
            nis = user.nis
            if nis in siswa_map:
                return siswa_map[nis]
            siswa = Siswa.query.filter_by(nis=nis).first()
            if not siswa:
                siswa_map[nis] = None
                return None
            pembagian = PembagianKelas.query.filter_by(nis=siswa.nis).order_by(PembagianKelas.tanggal.desc()).first()
            kelas_nama = pembagian.kelas_rel.nama_kelas if pembagian and pembagian.kelas_rel else 'Belum dibagi'
            data = {
                'nama': siswa.nama,
                'kelas': kelas_nama
            }
            siswa_map[nis] = data
            return data

        result_tagihan = []
        for t in all_tagihan:
            status = 'Lunas' if t.id_tagihan in paid_tagihan_ids else 'Belum Lunas'
            siswa_info = get_siswa_data(t.user_id) 

            result = {
                'id_tagihan': t.id_tagihan,
                'deskripsi': t.deskripsi,
                'total': t.total,
                'semester': t.semester,
                'tahun_ajaran': t.tahun_ajaran,
                'created_at': (
                    t.created_at.strftime("%d-%m-%Y %H:%M")  if isinstance(t.created_at, datetime) else '-'
                ),
                'status': status,
                'nama_siswa': siswa_info['nama'] ,
                'kelas': siswa_info['kelas'] ,
            }
            result_tagihan.append(result)

        if not result_tagihan:
            return jsonify({"message": "Data tagihan tidak ditemukan"})

        # ===== Generate Excell =====
        wb = Workbook()
        ws = wb.active
        ws.title = "Tagihan Siswa"

        headers = ["ID Tagihan", "Nama Siswa", "Kelas", "Deskripsi", "Total", "Semester", "Tahun Ajaran", "Tanggal Dibuat", "Status"]
        ws.append(headers)

        for item in result_tagihan:
            ws.append([
                item['id_tagihan'],
                item.get('nama_siswa', '-'),
                item.get('kelas', '-'),
                item['deskripsi'],
                item['total'],
                item['semester'],
                item['tahun_ajaran'],
                item['created_at'],
                item['status']
            ])

        output = BytesIO()
        wb.save(output)
        output.seek(0)

        return send_file(output, as_attachment=True, download_name="data_tagihan.xlsx", mimetype="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")

    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403
    

@app.route('/export_tagihan_pdf')
def export_tagihan_pdf():
    if not session.get('email'):
        return jsonify({'message': 'Token is missing'}), 403
    if not session.get('role'):
        return jsonify({'message': 'Token is missing'}), 403
    try:
        user_email = session.get('email')
        role = session.get('role')

        if role == 'murid':
            all_tagihan = Tagihan.query.filter_by(user_id=session['id']).all()
            paid_transactions = Transaksi.query.filter(
                Transaksi.email == user_email,
                Transaksi.status.in_(['settlement', 'paid'])
            ).all()
        else:
            all_tagihan = Tagihan.query.all()
            paid_transactions = Transaksi.query.filter(
                Transaksi.status.in_(['settlement', 'paid'])
            ).all()

        paid_tagihan_ids = {tr.id_tagihan for tr in paid_transactions if tr.id_tagihan is not None}
        siswa_map = {}

        def get_siswa_data(user_id):
            user = User.query.filter_by(id=user_id).first()
            if not user or not user.nis:
                return None
            nis = user.nis
            if nis in siswa_map:
                return siswa_map[nis]
            siswa = Siswa.query.filter_by(nis=nis).first()
            if not siswa:
                siswa_map[nis] = None
                return None
            pembagian = PembagianKelas.query.filter_by(nis=siswa.nis).order_by(PembagianKelas.tanggal.desc()).first()
            kelas_nama = pembagian.kelas_rel.nama_kelas if pembagian and pembagian.kelas_rel else 'Belum dibagi'
            data = {
                'nama': siswa.nama,
                'kelas': kelas_nama
            }
            siswa_map[nis] = data
            return data

        result_tagihan = []
        for t in all_tagihan:
            status = 'Lunas' if t.id_tagihan in paid_tagihan_ids else 'Belum Lunas'
            siswa_info = get_siswa_data(t.user_id) 

            result = {
                'id_tagihan': t.id_tagihan,
                'deskripsi': t.deskripsi,
                'total': t.total,
                'semester': t.semester,
                'tahun_ajaran': t.tahun_ajaran,
                'created_at': (
                    t.created_at.strftime("%d-%m-%Y %H:%M") if isinstance(t.created_at, datetime) else '-'
                ),
                'status': status,
                'nama_siswa': siswa_info['nama'] ,
                'kelas': siswa_info['kelas'] ,
            }
            result_tagihan.append(result)

        if not result_tagihan:
            return jsonify({"message": "Data tagihan tidak ditemukan"})

        # ===== Generate PDF =====
        buffer = BytesIO()
                
        doc = SimpleDocTemplate(
            buffer,
            pagesize=A3,
            leftMargin=40,   # padding kiri
            rightMargin=40,  # padding kanan
            topMargin=40,
            bottomMargin=40
        )
        styles = getSampleStyleSheet()
        if role == 'murid':
            siswa = Siswa.query.filter_by(nis=session.get('nis')).first()
            elements = [Paragraph(f"Data Tagihan {siswa.nama}", styles["Title"])]
        else:
            elements = [Paragraph("Data Tagihan Siswa", styles["Title"])]

        data = [["ID", "Nama Siswa", "Kelas", "Deskripsi", "Total", "Semester", "Tahun Ajaran", "Tanggal Dibuat", "Status"]]
        for item in result_tagihan:
            data.append([
                item["id_tagihan"],
                item["nama_siswa"] ,
                item["kelas"],
                item["deskripsi"],
                f"Rp {item['total']:,.0f}",
                item["semester"],
                item["tahun_ajaran"],
                item["created_at"],
                item["status"]
            ])

        table = Table(data, repeatRows=1)
        table.setStyle(TableStyle([
            ('BACKGROUND', (0,0), (-1,0), colors.lightblue),
            ('TEXTCOLOR', (0,0), (-1,0), colors.black),
            ('GRID', (0,0), (-1,-1), 0.5, colors.grey),
            ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
            ('ALIGN', (0,0), (-1,-1), 'LEFT'),
            ('FONTSIZE', (0,0), (-1,-1), 8),
            ('BOTTOMPADDING', (0,0), (-1,0), 6),
    ('LEFTPADDING', (0, 0), (-1, -1), 6),   # Tambahkan padding kiri
    ('RIGHTPADDING', (0, 0), (-1, -1), 6),  # Tambahkan padding kanan
        ]))

        elements.append(table)
        doc.build(elements)
        buffer.seek(0)

        return send_file(buffer, as_attachment=True, download_name="data_tagihan.pdf", mimetype="application/pdf")

    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403

@app.route('/murid/kehadiran')
def kehadiran():
    nis = session.get('nis')
    if not nis:
        return "Unauthorized", 403

    siswa = Siswa.query.filter_by(nis=nis).first()
    if not siswa:
        return "Siswa tidak ditemukan", 404

    data_kehadiran = Kehadiran.query.filter_by(nis=nis).all()
    
    # Jika tidak ada data kehadiran, langsung render tanpa proses lanjut
    if not data_kehadiran:
        return render_template(
            'murid/kehadiran.html',
            data_kehadiran=None,
            btn_tambah=False,
            title="Kehadiran",
            title_data="Kehadiran"
        )

    pembagian = PembagianKelas.query.filter_by(nis=nis).all()

    # Mapping pembagian berdasarkan tahun akademik
    pembagian_map = {
        p.id_tahun_akademik: {
            "nama_kelas": p.kelas_rel.nama_kelas,
            "tingkat": p.kelas_rel.tingkat
        } for p in pembagian
    }

    # Tambahkan info kelas ke data kehadiran
    enriched_kehadiran = []
    for d in data_kehadiran:
        id_tahun = (
            d.kbm_rel.ampu_rel.id_tahun_akademik if d.kbm_rel and d.kbm_rel.ampu_rel else None
        )
        kelas_info = pembagian_map.get(id_tahun, {"nama_kelas": "-", "tingkat": "-"})
        enriched_kehadiran.append({
            "id_kehadiran": d.id_kehadiran,
            "siswa_rel": d.siswa_rel,
            "kbm_rel": d.kbm_rel,
            "keterangan_rel": d.keterangan_rel,
            "nama_kelas": kelas_info["nama_kelas"],
            "tingkat": kelas_info["tingkat"]
        })

    return render_template(
        'murid/kehadiran.html',
        data_kehadiran=enriched_kehadiran,
        btn_tambah=False,
        title="Kehadiran",
        title_data="Kehadiran"
    )

@app.route('/murid/surat_izin')
def surat_izin():
    nis = session.get('nis')
    if not nis:
        return "Unauthorized", 403

    siswa = Siswa.query.filter_by(nis=nis).first()
    if not siswa:
        return "Siswa tidak ditemukan", 404

    data_kehadiran = Kehadiran.query.filter_by(nis=nis).all()
    
    # Jika tidak ada data kehadiran, langsung render tanpa proses lanjut
    if not data_kehadiran:
        return render_template(
            'murid/kehadiran.html',
            data_kehadiran=None,
            btn_tambah=False,
            title="Kehadiran",
            title_data="Kehadiran"
        )

    pembagian = PembagianKelas.query.filter_by(nis=nis).all()

    # Mapping pembagian berdasarkan tahun akademik
    pembagian_map = {
        p.id_tahun_akademik: {
            "nama_kelas": p.kelas_rel.nama_kelas,
            "tingkat": p.kelas_rel.tingkat
        } for p in pembagian
    }

    # Tambahkan info kelas ke data kehadiran
    enriched_kehadiran = []
    for d in data_kehadiran:
        id_tahun = (
            d.kbm_rel.ampu_rel.id_tahun_akademik if d.kbm_rel and d.kbm_rel.ampu_rel else None
        )
        kelas_info = pembagian_map.get(id_tahun, {"nama_kelas": "-", "tingkat": "-"})
        enriched_kehadiran.append({
            "id_kehadiran": d.id_kehadiran,
            "surat_izin": d.surat_izin,
            "siswa_rel": d.siswa_rel,
            "kbm_rel": d.kbm_rel,
            "keterangan_rel": d.keterangan_rel,
            "nama_kelas": kelas_info["nama_kelas"],
            "tingkat": kelas_info["tingkat"]
        })

    return render_template(
        'murid/upload_surat_izin.html',
        data_kehadiran=enriched_kehadiran,
        btn_tambah=False,
        title="Kehadiran Izin",
        title_data="Kehadiran Izin"
    )
@app.route('/murid/surat_izin_simpan', methods=['POST'])
def surat_izin_simpan():
    if session.get('role') != 'murid':
        abort(403)

    # Ambil data dari form
    data = request.form.to_dict()
    print(data)
    id_kehadiran = data.get('id_kehadiran')

    if not id_kehadiran:
        flash('Data tidak lengkap', 'danger')
        return redirect(request.referrer or url_for('surat_izin'))  # fallback jika referrer kosong

    kehadiran = Kehadiran.query.filter_by(id_kehadiran=id_kehadiran).first()
    if not kehadiran:
        flash('Data kehadiran tidak ditemukan', 'danger')
        return redirect(request.referrer or url_for('surat_izin'))

    file = request.files.get('surat_izin')
    if not file or not allowed_file_surat_izin(file.filename):
        flash('File tidak valid atau belum diunggah', 'danger')
        return redirect(request.referrer or url_for('surat_izin'))

    # Hapus file lama jika ada
    if kehadiran.surat_izin:
        old_path = os.path.join(app.config['UPLOAD_SURAT_IZIN'], kehadiran.surat_izin)
        if os.path.exists(old_path):
            os.remove(old_path)

    # Simpan file baru
    ext = file.filename.rsplit('.', 1)[1].lower()
    filename = f"{uuid.uuid4().hex}.{ext}"
    filepath = os.path.join(app.config['UPLOAD_SURAT_IZIN'], filename)
    file.save(filepath)

    kehadiran.surat_izin = filename
    db.session.commit()

    flash('Surat izin berhasil ditambahkan.', 'success')
    return redirect(request.referrer or url_for('surat_izin'))
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
    results = JadwalPelajaran.query.order_by(hari_order).all()

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

    return render_template("murid/jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map["kodeGuru"], kode_mapel=formatted_teacher_map["kodeMapel"], users=users, kelas=kelas_dict,
                           
    btn_tambah = False,
    title = "Jadwal Pelajaran",
    title_data = "Jadwal Pelajaran")

@app.route('/murid/pengumuman')
def view_murid_pengumuman():
    berita = Berita.query.filter_by(pengumuman_untuk='murid').all()
    btn_tambah = False
    title = "Pengumuman"
    title_data = "Pengumuman"
    return render_template('murid/berita.html', berita=berita,btn_tambah=btn_tambah,title=title,title_data=title_data)

@app.route('/murid/penilaian')
def penilaian_murid():
    if session.get('role') != 'murid':
        abort(403)
    btn_tambah = False
    title = "Nilai Anda"
    title_data = "Nilai Anda"
    # Ambil filter query
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=10, type=int)
    nip = session.get('nip') or request.args.get('nip')
    id_kelas = request.args.get('id_kelas')
    id_mapel = request.args.get('id_mapel')
    jenis_penilaian = request.args.get('jenis_penilaian')
    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    siswa_now = request.args.get('nis') or session.get('nis')
    print(siswa_now)

    # Join dengan AmpuMapel
    query = Penilaian.query.join(AmpuMapel, Penilaian.id_ampu == AmpuMapel.id_ampu)

    if tahun:
        query = query.filter(extract('year', Penilaian.tanggal) == tahun)
    if bulan:
        query = query.filter(extract('month', Penilaian.tanggal) == bulan)
    if tanggal:
        query = query.filter(extract('day', Penilaian.tanggal) == tanggal)
    if siswa_now:
        query = query.filter(Penilaian.nis == siswa_now)
    if nip:
        query = query.filter(AmpuMapel.nip == nip)
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

    data = query.order_by(Penilaian.id_penilaian.desc())
    print(f"Jumlah data diekspor: {data.count()}")
    # Pagination
    paginated_data = query.paginate(page=page, per_page=per_page, error_out=False)
    info_list = paginated_data.items
    # Cek total data dulu
    total_records = query.count()
    total_pages = (total_records + per_page - 1) // per_page
    # Jika halaman diminta melebihi total halaman, reset ke 1
    if page > total_pages:
        page = 1
    page_range = range(max(1, page - 3), min(total_pages + 1, page + 3))
    tahun_query = (
        db.session.query(extract('year', AmpuMapel.tanggal).label("tahun"))
        .join(Penilaian, Penilaian.id_ampu == AmpuMapel.id_ampu)  # sesuaikan dengan relasi yang benar
        .filter(Penilaian.nis == siswa_now)
        .group_by(extract('year', AmpuMapel.tanggal))
        .order_by(extract('year', AmpuMapel.tanggal).desc())
        .all()
    )
    print(tahun_query)
    print(info_list)

    thn = [int(row.tahun) for row in tahun_query if row.tahun is not None]
    return render_template('murid/penilaian.html', penilaian=info_list, tahun=thn, data_guru=Guru.query.all(), data_kelas=Kelas.query.all(), data_mapel=Mapel.query.all(), data_siswa=Siswa.query.all(), data_ampu=AmpuMapel.query.filter_by(nip=nip).all(), btn_tambah=btn_tambah, title=title, title_data=title_data, page=page, per_page=per_page, total_pages=total_pages, total_records=total_records, has_next=paginated_data.has_next, has_prev=paginated_data.has_prev, page_range=page_range )


@app.route('/murid/penilaian/export/excel')
def export_excel_penilaian():
    nip = session.get('nip') or request.args.get('nip')
    id_kelas = request.args.get('id_kelas')
    id_mapel = request.args.get('id_mapel')
    jenis_penilaian = request.args.get('jenis_penilaian')
    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    siswa_now = request.args.get('nis') or session.get('nis')

    # Join dengan AmpuMapel
    query = Penilaian.query.join(AmpuMapel, Penilaian.id_ampu == AmpuMapel.id_ampu)

    if tahun:
        query = query.filter(extract('year', Penilaian.tanggal) == tahun)
    if bulan:
        query = query.filter(extract('month', Penilaian.tanggal) == bulan)
    if tanggal:
        query = query.filter(extract('day', Penilaian.tanggal) == tanggal)
    if siswa_now:
        exists = db.session.query(Penilaian.query.filter(Penilaian.nis == siswa_now).exists()).scalar()
        if exists:
            query = query.filter(Penilaian.nis == siswa_now)
    if nip:
        exists = db.session.query(AmpuMapel.query.filter(AmpuMapel.nip == nip).exists()).scalar()
        if exists:
            query = query.filter(AmpuMapel.nip == nip)
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

    data = query.order_by(Penilaian.id_penilaian.desc())
    print(f"Jumlah data diekspor: {data.count()}")

    # Buat DataFrame
    df = pd.DataFrame([{
        'No': index,
        'Nis':d.nis ,
        "Nama":d.siswa_rel.nama ,
        'Kelas':d.ampu_rel.kelas_rel.nama_kelas if d.ampu_rel.kelas_rel else '' ,
        'Mapel':d.ampu_rel.mapel_rel.nama_mapel ,
        'Guru': d.ampu_rel.guru_rel.nama ,
        'Jenis Penilaian': d.jenis_penilaian ,
        'Nilai':d.nilai ,
        'Semester': d.ampu_rel.semester_rel.semester ,
        'Tahun Akademik': d.ampu_rel.tahun_akademik_rel.tahun_akademik,
        'Tanggal': d.tanggal.strftime('%Y-%m-%d') if d.tanggal else '' ,
    } for index, d in enumerate(data, start=1)])

    output = BytesIO()
    with pd.ExcelWriter(output, engine='openpyxl') as writer:
        df.to_excel(writer, index=False, sheet_name='Penilaian')

    output.seek(0)
    return send_file(output, download_name="penilaian.xlsx", as_attachment=True)


@app.route('/murid/penilaian/export/pdf')
def export_pdf_penilaian():
    # Tambahkan filter seperti di atas...
    nip = session.get('nip') or request.args.get('nip')
    id_kelas = request.args.get('id_kelas')
    id_mapel = request.args.get('id_mapel')
    jenis_penilaian = request.args.get('jenis_penilaian')
    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    siswa_now = request.args.get('nis') or session.get('nis')

    # Join dengan AmpuMapel
    query = Penilaian.query.join(AmpuMapel, Penilaian.id_ampu == AmpuMapel.id_ampu)

    if tahun:
        query = query.filter(extract('year', Penilaian.tanggal) == tahun)
    if bulan:
        query = query.filter(extract('month', Penilaian.tanggal) == bulan)
    if tanggal:
        query = query.filter(extract('day', Penilaian.tanggal) == tanggal)
    if siswa_now:
        query = query.filter(Penilaian.nis == siswa_now)
    if nip:
        query = query.filter(AmpuMapel.nip == nip)
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

    data = query.order_by(Penilaian.id_penilaian.desc())
    print(f"Jumlah data diekspor: {data.count()}")

    buffer = BytesIO()
    doc = SimpleDocTemplate(buffer, pagesize=landscape(A4) )
    elements = []
    style = getSampleStyleSheet()
    elements.append(Paragraph("Laporan Penilaian", style['Title']))

    table_data = [["No", 'Nis', "Nama", 'Kelas', "Mapel", "Guru", "Jenis", "Nilai", "Semester", "Tahun Akademik", "Tanggal"]]

    for index, d in enumerate(data, start=1):  # start=1 agar index mulai dari 1 seperti loop.index
        table_data.append([
            index,
            d.nis ,
            d.siswa_rel.nama ,
            d.ampu_rel.kelas_rel.nama_kelas if d.ampu_rel.kelas_rel else '' ,
            d.ampu_rel.mapel_rel.nama_mapel ,
            d.ampu_rel.guru_rel.nama ,
            d.jenis_penilaian ,
            d.nilai ,
            d.ampu_rel.semester_rel.semester ,
            d.ampu_rel.tahun_akademik_rel.tahun_akademik,
            d.tanggal.strftime('%Y-%m-%d') if d.tanggal else '' ,
        ])

    table = Table(table_data, hAlign='LEFT')
    table.setStyle(TableStyle([
        ('BACKGROUND', (0,0), (-1,0), colors.grey),
        ('TEXTCOLOR',(0,0),(-1,0),colors.whitesmoke),
        ('ALIGN',(0,0),(-1,-1),'CENTER'),
        ('FONTNAME', (0,0), (-1,0), 'Helvetica-Bold'),
        ('GRID', (0,0), (-1,-1), 0.5, colors.black),
        ('LEFTPADDING', (0, 0), (-1, -1), 6),   # Tambahkan padding kiri
        ('RIGHTPADDING', (0, 0), (-1, -1), 6),  # Tambahkan padding kanan
    ]))
    elements.append(table)
    doc.build(elements)

    buffer.seek(0)
    return send_file(buffer, download_name='penilaian.pdf', as_attachment=True)

# === TAMBAH EVALUASI GURU ===
@app.route('/evaluasi_guru/tambah', methods=['POST'])
def tambah_evaluasi_guru():
    if session.get('role') == 'guru':
        abort(403)
    if request.is_json:
        data = request.get_json()
    else:
        # Fallback ke request.form jika bukan JSON
        data = request.form
    id_ampu=data.get('id_ampu','')
    if id_ampu != '':
        evaluasi = EvaluasiGuru(
            nip=data.get('nip'),
            id_ampu=id_ampu,
            evaluator_id=data.get('evaluator_id'),
            q1=data.get('q1'),
            q2=data.get('q2'),
            q3=data.get('q3'),
            q4=data.get('q4'),
            q5=data.get('q5'),
            q6=data.get('q6'),
            q7=data.get('q7'),
            q8=data.get('q8'),
            q9=data.get('q9'),
            q10=data.get('q10'),
            q11=data.get('q11'),
            evaluator_role=data.get('evaluator_role'),
            nis=session.get('nis'),
            tahun_id = data.get('tahun_id'),
            semester_id = data.get('semester_id'),
            komentar=data.get('komentar')
        )
        db.session.add(evaluasi)
        db.session.commit()
        return jsonify({'msg': 'Evaluasi berhasil ditambahkan'})
    else:
        evaluasi = EvaluasiGuru(
            nip=data.get('nip'),
            evaluator_id=data.get('evaluator_id'),
            evaluator_role=data.get('evaluator_role'),
            q1=data.get('q1'),
            q2=data.get('q2'),
            q3=data.get('q3'),
            q4=data.get('q4'),
            q5=data.get('q5'),
            q6=data.get('q6'),
            q7=data.get('q7'),
            q8=data.get('q8'),
            q9=data.get('q9'),
            q10=data.get('q10'),
            q11=data.get('q11'),
            nis=session.get('nis'),
            tahun_id = data.get('tahun_id'),
            semester_id = data.get('semester_id'),
            komentar=data.get('komentar')
        )
        db.session.add(evaluasi)
        db.session.commit()
        flash('Evaluasi berhasil ditambahkan', 'success')
        return redirect(url_for('dashboard'))
    