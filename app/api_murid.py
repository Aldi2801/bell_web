from . import Kbm, Kelas, Siswa, app, db, get_semester_and_year, Tagihan,TahunAkademik, Transaksi, AmpuMapel, Kehadiran,Penilaian, Mapel, Keterangan, PembagianKelas, Berita, Guru,User
from flask import render_template, request, jsonify, session, redirect, abort
import jwt
from datetime import datetime
from sqlalchemy import extract
from sqlalchemy import and_

@app.route('/get_menu_pembayaran')
def get_menu_pembayaran():
    token = request.headers.get('Authorization')
    if not token:
        return jsonify({'message': 'Token is missing'}), 403

    try:
        decoded_token = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        user_email = decoded_token['email']
        role = decoded_token['role']

        print(user_email)
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
            print(siswa_map)
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
        print(result_tagihan)
        if result_tagihan ==[]:
            return jsonify({"message": "Data tagihan tidak ditemukan"})
        else:
            return jsonify(result_tagihan)

    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403


from sqlalchemy.orm import joinedload

@app.route('/kehadiran')
def view_kehadiran():
    nis = session.get('nis')
    print(nis)
    if nis:
        nama_siswa = Siswa.query.filter_by(nis=nis).first()
    else:
        redirect('/')

    data_kelas = Kelas.query.order_by(Kelas.nama_kelas.asc()).all()
    data_kbm = Kbm.query.all()
    # Ambil semua kehadiran berdasarkan nis
    kehadiran_list = Kehadiran.query\
            .filter_by(nis=nis)\
            .join(Kbm, Kehadiran.id_kbm == Kbm.id_kbm)\
            .join(Keterangan, Kehadiran.id_keterangan == Keterangan.id_keterangan)\
            .join(AmpuMapel, AmpuMapel.id_ampu == Kbm.id_ampu)\
            .join(Guru, Guru.nip == AmpuMapel.nip)\
            .add_columns(
                AmpuMapel.id_mapel('id_mapel'),
                AmpuMapel.nip('nip'),
                AmpuMapel.id_tahun_akademik('id_tahun_akademik'),
                Guru.nama('nama_guru'),
                Kbm.tanggal.label('tanggal'),
                Kbm.materi.label('materi'),
                Kbm.sub_materi.label('sub_materi'),
                Keterangan.keterangan.label('keterangan')
            ).all()

    print(kehadiran_list)
    # Format data hasil
    result = []
    for k in kehadiran_list:
            nama_kelas = PembagianKelas.query.filter_by(nis=nis,id_tahun_akademik=k.id_tahun_akademik).first()
            result.append({
                'nama_lengkap':nama_siswa.nama,
                'tanggal': k.tanggal.isoformat(),
                'nama_mapel':k.id_mapel,
                'nama_kelas':nama_kelas.id_kelas,
                'nip':k.nip,
                'nama_guru':k.nama_guru,
                'materi': k.materi,
                'sub_materi': k.sub_materi,
                'keterangan': k.keterangan
            })
    print(result)
    data_siswa = Siswa.query.filter_by(user_id=session['id'])
    return render_template("kehadiran.html",kehadiran_list= kehadiran_list, siswa=data_siswa, kelas=data_kelas, kbm=data_kbm,
    btn_tambah = True,
    title = "Manage Berita",
    title_data = "Berita / Pengumuman")
@app.route('/murid/kehadiran')
def kehadiran():
    nis = session.get('nis')
    if not nis:
        return "Unauthorized", 403

    siswa = Siswa.query.filter_by(nis=nis).first()
    if not siswa:
        return "Siswa tidak ditemukan", 404

    data_kehadiran = Kehadiran.query.filter_by(nis=nis).all()


    # Ubah hasil query jadi dict agar cocok dengan HTML
    print(data_kehadiran)
    
    pembagian = PembagianKelas.query.filter_by(nis=nis).all()
    return render_template('murid/kehadiran.html', data_kehadiran=data_kehadiran,pembagian=pembagian,
                           btn_tambah = False,
                           title = "Kehadiran",
                           title_data = "Kehadiran")

@app.route('/pengumuman')
def view_pengumuman():
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

    tahun = request.args.get('tahun', type=int)
    bulan = request.args.get('bulan', type=int)
    tanggal = request.args.get('tanggal', type=int)
    page = request.args.get('page', default=1, type=int)
    per_page = request.args.get('per_page', default=10, type=int)
    siswa_now = int(session.get('nis', 0))

    print(siswa_now)
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

    # Urutkan berdasarkan ID (atau sesuaikan dengan kolom yang diinginkan)
    query = query.order_by(Penilaian.id_penilaian.desc())

    # Pagination
    paginated_data = query.paginate(page=page, per_page=per_page, error_out=False)
    print(query.all())
    info_list = paginated_data.items
    # Cek total data dulu
    total_records = query.count()
    total_pages = (total_records + per_page - 1) // per_page

    # Jika halaman diminta melebihi total halaman, reset ke 1
    if page > total_pages:
        page = 1

    has_next = paginated_data.has_next
    has_prev = paginated_data.has_prev
    page_range = range(max(1, page - 3), min(total_pages + 1, page + 3))
    print(info_list)
    return render_template(
        'murid/penilaian.html',
        penilaian=info_list,
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
