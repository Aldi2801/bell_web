from . import EvaluasiGuru, Kelas, Siswa, app, db, Tagihan,JadwalPelajaran, Transaksi, AmpuMapel, Kehadiran,Penilaian, Mapel, PembagianKelas, Berita, Guru,User
from flask import flash, render_template, request, jsonify, session, redirect, abort, url_for
import jwt, datetime, ast
from datetime import datetime
from sqlalchemy import extract, case
from collections import defaultdict

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

        # Cache untuk siswa, gunakan dictionary
        siswa_map = {}

        def get_siswa_data(user_id):
            user = User.query.filter_by(id=user_id).first()
            if not user or not user.nis:
                return None

            # Cek cache dulu berdasarkan NIS
            nis = user.nis
            if nis in siswa_map:
                return siswa_map[nis]

            siswa = Siswa.query.filter_by(nis=nis).first()
            if not siswa:
                siswa_map[nis] = None
                return None

            pembagian = PembagianKelas.query \
                .filter_by(nis=siswa.nis) \
                .order_by(PembagianKelas.tanggal.desc()) \
                .first()

            kelas_nama = pembagian.kelas_rel.nama_kelas if pembagian and pembagian.kelas_rel else 'Belum dibagi'

            data = {
                'nama': siswa.nama,
                'kelas': kelas_nama
            }

            siswa_map[nis] = data
            return data

        # Bangun response
        result_tagihan = []
        for t in all_tagihan:
            status = 'Lunas' if t.id_tagihan in paid_tagihan_ids else 'Belum Lunas'
            siswa_info = get_siswa_data(t.user_id) if role != 'murid' else None

            result = {
                'id_tagihan': t.id_tagihan,
                'deskripsi': t.deskripsi,
                'total': t.total,
                'semester': t.semester,
                'tahun_ajaran': t.tahun_ajaran,
                'created_at': (
                    t.created_at.isoformat() 
                    if isinstance(t.created_at, datetime) else 
                    None
                ),
                'status': status,
                'siswa': siswa_info  # tambahkan ini jika ingin tampilkan info siswa
            }

            if siswa_info:
                result['nama_siswa'] = siswa_info['nama']
                result['kelas'] = siswa_info['kelas']

            result_tagihan.append(result)
        if result_tagihan ==[]:
            return jsonify({"message": "Data tagihan tidak ditemukan"})
        else:
            return jsonify(result_tagihan)

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

    return render_template("murid/jadwal.html", schedule=formatted_schedule, kode_guru=formatted_teacher_map["kodeGuru"], kode_mapel=formatted_teacher_map["kodeMapel"], users=users, kelas=kelas_dict,
                           
    btn_tambah = False,
    title = "Jadwal Pelajaran",
    title_data = "Jadwal Pelajaran")

@app.route('/muird/pengumuman')
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
    nip = request.args.get('nip')
    id_kelas = request.args.get('id_kelas')
    id_mapel = request.args.get('id_mapel')
    jenis_penilaian = request.args.get('jenis_penilaian')
    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=10, type=int)
    siswa_now = int(session.get('nis', 0))
    # Mulai query dari Penilaian
    query = Penilaian.query
    # Filter berdasarkan tanggal jika ada
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
    # Urutkan berdasarkan ID (atau sesuaikan dengan kolom yang diinginkan)
    query = query.order_by(Penilaian.id_penilaian.desc())
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
        .filter(Penilaian.nis == siswa_now)
        .group_by(extract('year', AmpuMapel.tanggal))
        .order_by(extract('year', AmpuMapel.tanggal).desc())
        .all()
    )
    thn = [int(row.tahun) for row in tahun_query if row.tahun is not None]
    return render_template( 'murid/penilaian.html', penilaian=info_list, tahun=thn, data_guru=Guru.query.all(), data_kelas=Kelas.query.all(), data_mapel=Mapel.query.all(), data_siswa=Siswa.query.all(), data_ampu=AmpuMapel.query.filter_by(nip=nip).all(), btn_tambah=btn_tambah, title=title, title_data=title_data, page=page, per_page=per_page, total_pages=total_pages, total_records=total_records, has_next=paginated_data.has_next, has_prev=paginated_data.has_prev, page_range=page_range )

# === TAMBAH EVALUASI GURU ===
@app.route('/evaluasi_guru/tambah', methods=['POST'])
def tambah_evaluasi_guru():
    if session.get('role') == 'guru':
        abort(403)
    if request.is_json:
        data = request.get_json()
    else:
        # Fallback ke request.form jika bukan JSON
        data = request.form.to_dict()
    
    id_ampu=data.get('id_ampu','')
    if id_ampu != '':
        evaluasi = EvaluasiGuru(
            nip=data.get('nip'),
            id_ampu=id_ampu,
            evaluator_id=data.get('evaluator_id'),
            evaluator_role=data.get('evaluator_role'),
            aspek=data.get('aspek'),
            skor=data.get('skor'),
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
            aspek=data.get('aspek'),
            skor=data.get('skor'),
            komentar=data.get('komentar')
        )
        db.session.add(evaluasi)
        db.session.commit()
        flash('Evaluasi berhasil ditambahkan')
        return redirect(url_for('dashboard'))