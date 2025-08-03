import pandas as pd
from . import AmpuMapel, Berita, Kehadiran, Keterangan, PembagianKelas, Penilaian, User, app, db, Kbm, Kelas, Siswa, Guru, Mapel, Semester, TahunAkademik
from flask import flash, redirect, request, jsonify, url_for, render_template, session, abort
from sqlalchemy import case, extract
import datetime
from sqlalchemy.exc import IntegrityError

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
        id_semester=request.json.get('id_semester')
        id_kelas=request.json.get('id_kelas')
        id_tahun_akademik=request.json.get('id_tahun_akademik')
        if session['role'] =='guru':
            nip = session.get('nip', '')
        else:
            nip = request.json.get('nip')
            print(repr(request.json.get("id_mapel")))

        new_ampu = AmpuMapel(
            nip = nip,
            id_mapel = request.json.get("id_mapel").strip(),
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
        db.session.flush()  # agar dapatkan id_kbm sebelum commit
        siswa_kelas = PembagianKelas.query.filter_by(id_kelas=id_kelas).filter_by(id_tahun_akademik=id_tahun_akademik).all()
        nama_kelas = Kelas.query.filter_by(id_kelas=id_kelas).first()
        # Tambahkan data kehadiran default "Hadir"
        for siswa in siswa_kelas:
            existing = Kehadiran.query.filter_by(
                id_kbm=new_kbm.id_kbm,
                nis=siswa.nis,
                nama_kelas=nama_kelas.nama_kelas,
                id_keterangan=1
            ).first()
            if existing:
                continue  # skip kalau sudah ada

            new_kehadiran = Kehadiran(
                id_kbm=new_kbm.id_kbm,
                nis=siswa.nis,
                nama_kelas=nama_kelas.nama_kelas,
                id_keterangan=1
            )
            db.session.add(new_kehadiran)


        db.session.commit()
        flash("Data berhasil ditambahkan", "success")
        return jsonify({'msg':'Data berhasil ditambahkan'})
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
    return jsonify([{'id_kbm':id_kbm,'nama': s[0], 'nis': s[1], 'nama_kelas': s[2],'id_keterangan': s[3]} for s in siswa_list])

@app.route('/guru/kehadiran/tambah', methods=['POST'])
def simpan_kehadiran_siswa():
    id_ampu = request.form['id_ampu']
    id_kbm = request.form['id_kbm']
    tanggal = datetime.datetime.now().date()

    # Tambahkan data ke KBM (karena kehadiran harus ada ID KBM)
 
    print(request.form['nama_kelas'])
    for key in request.form:
        if key.startswith('status['):
            nis = key[7:-1]  # ambil angka di dalam status[20001]
            status = request.form[key]
            id_keterangan = status  # fungsi untuk mapping
            # Cek apakah sudah ada sebelumnya
            exists = Kehadiran.query.filter_by(
                id_kbm=id_kbm,
                nis=int(nis),
                nama_kelas=request.form['nama_kelas'],
                id_keterangan=id_keterangan
            ).first()

            if not exists:
                kehadiran = Kehadiran(
                    id_kbm=id_kbm,
                    nis=int(nis),
                    nama_kelas=request.form['nama_kelas'],
                    id_keterangan=id_keterangan
                )
                db.session.add(kehadiran)
    try:
        db.session.commit()
    except IntegrityError:
        db.session.rollback()

    return '', 200
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

@app.route('/guru/surat_izin')
def lihat_surat_izin_murid():

    siswa = Siswa.query.all()
    if not siswa:
        return "Siswa tidak ditemukan", 404

    data_kehadiran = Kehadiran.query.all()
    
    # Jika tidak ada data kehadiran, langsung render tanpa proses lanjut
    if not data_kehadiran:
        return render_template(
            'murid/kehadiran.html',
            data_kehadiran=None,
            btn_tambah=False,
            title="Kehadiran",
            title_data="Kehadiran"
        )

    pembagian = PembagianKelas.query.all()

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
        print(d.kbm_rel.ampu_rel.nip, session.get('nip', ''))

        if d.kbm_rel.ampu_rel.nip == session.get('nip', ''):
            enriched_kehadiran.append({
                "id_kehadiran": d.id_kehadiran,
                "surat_izin": d.surat_izin,
                "siswa_rel": d.siswa_rel,
                "kbm_rel": d.kbm_rel,
                "keterangan_rel": d.keterangan_rel,
                "nama_kelas": d.nama_kelas,
            })

    return render_template(
        'guru/surat_izin.html',
        data_kehadiran=enriched_kehadiran,
        btn_tambah=False,
        title="Surat Izin Murid",
        title_data="Surat Izin Murid"
    )
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

    return render_template( 'guru/penilaian.html', penilaian=info_list, tahun=thn, data_guru=data_guru, data_kelas=data_kelas, data_mapel=data_mapel, data_siswa=data_siswa, data_ampu=data_ampu, btn_tambah=btn_tambah, title=title, title_data=title_data, page=page, per_page=per_page, total_pages=total_pages, total_records=total_records, has_next=has_next, has_prev=has_prev, page_range=page_range )

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
        flash('Penilaian berhasil ditambahkan', 'success')
        return jsonify({'msg': 'Penilaian berhasil ditambahkan'}), 201
    except Exception as e:
        db.session.rollback()
        return jsonify({'error': str(e)}), 400
@app.route('/guru/penilaian/tambah_excell', methods=['POST'])
def tambah_penilaian_excel():
    file = request.files.get('file')
    if not file:
        flash('❌ Tidak ada file yang diunggah.', 'danger')
        return redirect('/guru/penilaian')

    try:
        df = pd.read_excel(file)

        required_columns = ['nis', 'id_ampu', 'jenis_penilaian', 'nilai', 'tanggal']
        for col in required_columns:
            if col not in df.columns:
                flash(f'❌ Kolom "{col}" tidak ditemukan dalam file Excel.', 'danger')
                return redirect('/guru/penilaian')

        df = df[required_columns]

        # Drop baris yang kosong
        df.dropna(subset=required_columns, inplace=True)

        # Validasi dan konversi kolom
        failed_rows = []

        # Konversi NIS ke string
        try:
            df['nis'] = df['nis'].astype(int).astype(str)
        except Exception as e:
            flash(f'❌ Gagal konversi NIS: {e}', 'danger')
            return redirect('/guru/penilaian')

        # Nilai: Ganti koma jadi titik → float
        try:
            df['nilai'] = df['nilai'].astype(str).str.replace(',', '.').astype(float)
        except Exception as e:
            flash(f'❌ Gagal konversi nilai ke angka: {e}', 'danger')
            return redirect('/guru/penilaian')

        # Validasi nilai harus 0–100
        df = df[(df['nilai'] >= 0.0) & (df['nilai'] <= 100.0)]

        # Filter jenis_penilaian yang valid
        jenis_valid = ['UTS', 'UAS', 'UH', 'Tugas']
        df = df[df['jenis_penilaian'].isin(jenis_valid)]

        # Konversi tanggal ke datetime
        df['tanggal'] = pd.to_datetime(df['tanggal'], errors='coerce')
        df.dropna(subset=['tanggal'], inplace=True)

        inserted_count = 0

        for index, row in df.iterrows():
            row_index = index + 2  # baris di Excel
            error_msgs = []
            nis = str(row['nis'])
            id_ampu = str(row['id_ampu'])

            siswa = Siswa.query.filter_by(nis=int(nis)).first()
            ampu = AmpuMapel.query.filter_by(id_ampu=id_ampu).first()

            if not siswa:
                error_msgs.append(f"NIS tidak ditemukan")
            if not ampu:
                error_msgs.append(f"id_ampu tidak ditemukan")

            if pd.isna(row['tanggal']):
                error_msgs.append("Tanggal tidak valid")

            if error_msgs:
                failed_rows.append({
                    'row': row_index,
                    'nis': nis,
                    'nama': siswa.nama if siswa else '-',
                    'error': error_msgs
                })
                continue

            try:
                penilaian = Penilaian(
                    nis=nis,
                    id_ampu=id_ampu,
                    jenis_penilaian=row['jenis_penilaian'],
                    nilai=row['nilai'],
                    tanggal=row['tanggal'].date()
                )
                db.session.add(penilaian)
                inserted_count += 1

            except Exception as db_error:
                failed_rows.append({
                    'row': row_index,
                    'nis': nis,
                    'nama': siswa.nama if siswa else '-',
                    'error': [f'Gagal simpan ke database: {str(db_error)}']
                })
                db.session.rollback()
                continue

        db.session.commit()

        flash(f'✅ {inserted_count} penilaian berhasil ditambahkan.', 'success')

        if failed_rows:
            for fail in failed_rows:
                flash(f"❌ Baris {fail['row']} | {fail['nama']} (NIS: {fail['nis']}) gagal: {', '.join(fail['error'])}", 'danger')

    except Exception as e:
        db.session.rollback()
        flash(f'❌ Gagal memproses file: {str(e)}', 'danger')

    return redirect('/guru/penilaian')

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
        flash('Penilaian berhasil diperbarui', 'info')
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
    flash('penilaian berhasil dihapus', 'warning')
    return jsonify({'msg': 'penilaian berhasil dihapus'})

@app.route('/guru/pengumuman')
def view_guru_pengumuman():
    berita = Berita.query.filter_by(pengumuman_untuk='guru').all()
    btn_tambah = False
    title = "Pengumuman"
    title_data = "Pengumuman"
    return render_template('guru/berita.html', berita=berita,btn_tambah=btn_tambah,title=title,title_data=title_data)