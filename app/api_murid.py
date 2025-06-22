from requests import session
from . import Kbm, Kelas, Siswa, app, db, get_semester_and_year, Tagihan, Transaksi, AmpuMapel, Kehadiran, Mapel, Keterangan, PembagianKelas, Berita, Guru,User
from flask import render_template, request, jsonify, session, redirect
import jwt
from datetime import datetime

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

        semester, tahun_ajaran = get_semester_and_year()
        print(user_email)
        nis = session.get('nis')
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

        # Untuk caching data siswa (khusus admin/guru)
        siswa_map = {}

        from datetime import datetime

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
        print(result_tagihan)
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
    return render_template("kehadiran.html",kehadiran_list= kehadiran_list, siswa=data_siswa, kelas=data_kelas, kbm=data_kbm)

@app.route('/murid/kehadiran')
def kehadiran():
    # Ambil NIS dari user yang login
    nis = session.get('nis', None)

    # Ambil nama lengkap murid dari tabel Siswa berdasarkan NIS
    siswa = Siswa.query.filter_by(nis=nis).first()
    nama_lengkap = siswa.nama if siswa else None

    # Query kehadiran siswa
    data_kehadiran = (
        db.session.query(
            Kehadiran,
            Kbm.tanggal,
            Kbm.materi,
            Mapel.nama_mapel,
            Keterangan.keterangan,
            Kelas.nama_kelas,
            Kelas.tingkat
        )
        .join(Kbm, Kehadiran.id_kbm == Kbm.id_kbm)
        .join(AmpuMapel, Kbm.id_ampu == AmpuMapel.id_ampu)
        .join(Mapel, AmpuMapel.id_mapel == Mapel.id_mapel)
        .join(Keterangan, Kehadiran.id_keterangan == Keterangan.id_keterangan)
        .join(PembagianKelas, AmpuMapel.id_pembagian == PembagianKelas.id_pembagian)
        .join(Kelas, PembagianKelas.id_kelas == Kelas.id_kelas)
        .filter(Kehadiran.nis == nis)
        .all()
    )

    return render_template('murid/kehadiran.html', data_kehadiran=data_kehadiran, nama_lengkap=nama_lengkap)

@app.route('/pengumuman')
def view_pengumuman():
    berita = Berita.query.all()
    guru = Guru.query.all()  # ambil semua guru
    btn_tambah = False
    title = "Pengumuman"
    title_data = "Pengumuman"
    return render_template('murid/berita.html', berita=berita, guru=guru,btn_tambah=btn_tambah,title=title,title_data=title_data)
