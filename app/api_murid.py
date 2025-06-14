from requests import session
from . import Kbm, Kelas, Siswa, app, db, get_semester_and_year, Tagihan, Transaksi, AmpuMapel, Kehadiran, Mapel, Keterangan, PembagianKelas
from flask import render_template, request, jsonify, session
import jwt

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

        if role == 'murid':
            all_tagihan = Tagihan.query.filter(
                and_(
                    Tagihan.user_email == user_email,
                    Tagihan.semester == semester,
                    Tagihan.tahun_ajaran == tahun_ajaran
                )
            ).all()

            paid_transactions = Transaksi.query.filter(
                and_(
                    Transaksi.email == user_email,
                    Transaksi.status == 'settlement'
                )
            ).all()

        else:
            # Untuk admin/guru: Ambil semua tagihan
            all_tagihan = Tagihan.query.filter(
                and_(
                    Tagihan.semester == semester,
                    Tagihan.tahun_ajaran == tahun_ajaran
                )
            ).all()

            paid_transactions = Transaksi.query.filter(
                Transaksi.status == 'settlement'
            ).all()

        # Buat map tagihan yang sudah lunas
        paid_tagihan_ids = {tr.id_tagihan for tr in paid_transactions if tr.id_tagihan is not None}

        # Untuk admin/guru: buat cache siswa dan kelas agar tidak query berulang-ulang
        siswa_map = {}
        kelas_map = {}

        def get_siswa_data(email):
            if email in siswa_map:
                return siswa_map[email]
            siswa = Siswa.query.filter_by(email=email).first()
            if not siswa:
                siswa_map[email] = None
                return None

            # Ambil kelas aktif dari PembagianKelas
            pembagian = PembagianKelas.query.filter_by(nis=siswa.nis).order_by(PembagianKelas.tanggal.desc()).first()
            kelas_nama = pembagian.kelas_rel.nama_kelas if pembagian else 'Belum dibagi'
            data = {
                'nama': siswa.nama,
                'kelas': kelas_nama
            }
            siswa_map[email] = data
            return data

        # Buat list hasil
        result_tagihan = []
        for t in all_tagihan:
            status = 'Lunas' if t.id_tagihan in paid_tagihan_ids else 'Belum Lunas'
            siswa_info = get_siswa_data(t.user_email) if role != 'murid' else None

            result = {
                'id_tagihan': t.id_tagihan,
                'deskripsi': t.deskripsi,
                'total': t.total,
                'semester': t.semester,
                'tahun_ajaran': t.tahun_ajaran,
                'created_at': t.created_at.isoformat() if t.created_at else None,
                'status': status
            }

            if siswa_info:
                result['nama_siswa'] = siswa_info['nama']
                result['kelas'] = siswa_info['kelas']

            result_tagihan.append(result)

        return jsonify(result_tagihan)

    except jwt.ExpiredSignatureError:
        return jsonify({'valid': False, 'message': 'Token expired'}), 401
    except jwt.InvalidTokenError:
        return jsonify({'valid': False, 'message': 'Invalid token'}), 403

@app.route('/kehadiran')
def view_kehadiran():
    data_siswa = Siswa.query.all()        
    data_kelas = Kelas.query.order_by(Kelas.nama_kelas.asc()).all()
    data_kbm = Kbm.query.all()
    return render_template("kehadiran.html", siswa=data_siswa, kelas=data_kelas, kbm=data_kbm)

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
    btn_tambah = True
    title = "Manage Semester"
    title_data = "Semester"
    return render_template('murid/berita.html', berita=berita, guru=guru,btn_tambah=btn_tambah,title=title,title_data=title_data)
