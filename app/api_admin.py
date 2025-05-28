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
from flask import render_template, request, jsonify, g, send_file
from PIL import Image
from dateutil.relativedelta import relativedelta
from flask_jwt_extended import jwt_required
# Fungsi untuk mengubah angka menjadi teks (terbilang)
from num2words import num2words
# Import dari aplikasi lokal
from . import app, mysql, project_directory

# Middleware untuk membuka koneksi database sebelum setiap request
@app.before_request
def before_request():
    g.con = mysql.connection.cursor()

# Middleware untuk menutup koneksi database setelah setiap request
@app.teardown_request
def teardown_request(exception):
    if hasattr(g, 'con'):
        g.con.close()

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
               
# Halaman dashboard admin
@app.route('/admin/dashboard')
def dashboard():
        # Statistik utama
        bulan_ini = datetime.now().strftime('%m').replace('0','')
        print(bulan_ini) 
        tahun_ini = datetime.now().year
        print(tahun_ini)
        target_sales = fetch("""
            SELECT 
                target_sales.id, 
                sales.nama_sales, 
                target_sales.target, 
                sales.id as id_sales
            FROM 
                target_sales
            INNER JOIN 
                sales on sales.id = target_sales.id_sales 
            WHERE 
                tahun = %s and bulan = %s 
        """,(tahun_ini,bulan_ini))

        g.con.execute("""
            SELECT 
                sales.nama_sales, 
                SUM(CASE WHEN lunas_or_no = 'Lunas' THEN harga_total ELSE 0 END) AS performa_sales 
            FROM 
                detail_barang_keluar
            INNER JOIN 
                barang_keluar on barang_keluar.id = detail_barang_keluar.id_barang_keluar 
            INNER JOIN 
                detail_sales on detail_sales.id = barang_keluar.id_sales
            INNER JOIN 
                sales on sales.id = detail_sales.id_sales 
            WHERE 
                year(barang_keluar.tglfaktur) = %s and month(barang_keluar.tglfaktur) = %s
        """,(tahun_ini,bulan_ini))

        realtime_sales = g.con.fetchall()
        print(target_sales)
        print(realtime_sales)
        for i in target_sales:
            for j in realtime_sales:
                print(i['nama_sales'])
                print(j[0])
                if i['nama_sales'] == j[0]:
                    print(j[1])
                    i['data_realtime'] = int(j[1])
                    break
                else:
                    i['data_realtime'] = 0
        print(target_sales)

        g.con.execute("SELECT SUM(performa_sales) FROM barang_keluar WHERE year(tglfaktur) = %s and month(tglfaktur) = %s",
        (tahun_ini,bulan_ini))
        performa_penjualan = g.con.fetchone()[0] or 0
        g.con.execute("SELECT SUM(performa_belanja) FROM barang_masuk WHERE year(tglfaktur) = %s and month(tglfaktur) = %s",
        (tahun_ini,bulan_ini))
        performa_belanja = g.con.fetchone()[0] or 0

        # Data untuk tabel barang masuk
        barang_masuk = fetch("""
            SELECT 
                bm.id, 
                bm.tglfaktur,
                dbm.id_barang_masuk, 
                dbm.jml_menerima, 
                dbm.harga_total, 
                b.nama_barang  
            FROM 
                detail_barang_masuk dbm 
            INNER JOIN 
                barang b on b.id = dbm.id_barang
            INNER JOIN 
                barang_masuk bm on bm.id = dbm.id_barang_masuk
            ORDER BY 
                bm.tglfaktur DESC
            LIMIT 10
        """)

        revenue = performa_penjualan - performa_belanja

        today = datetime.today()
        tahun = today.year
        bulan = today.month

        # Dapetin jumlah total hari di bulan ini
        total_hari_bulan_ini = calendar.monthrange(tahun, bulan)[1]

        # Hitung sisa hari dari hari ini
        sisa_hari = total_hari_bulan_ini - today.day

        return render_template(
            'admin/dashboard.html', tahun_ini = tahun_ini, bulan_ini = bulan_ini, 
            target_sales = target_sales, 
            realtime_sales = realtime_sales,
            revenue = revenue,
            performa_penjualan=performa_penjualan, 
            sisa_hari = sisa_hari,
            performa_belanja=performa_belanja,
            barang_masuk=barang_masuk
        )
# Halaman penerimaan barang
@app.route('/admin/penerimaan-tambah', methods=['GET'])
def adminpenerimaantambah():
    # Ambil data tambahan
    data_barang = fetch("SELECT * FROM barang ORDER BY id")
    data_pabrik = fetch("SELECT * FROM pabrik ORDER BY id")
    thn = fetch_years("SELECT YEAR(tglfaktur) AS tahun FROM barang_masuk GROUP BY tahun")

    return render_template("admin/tambah-penerimaan.html", tahun=thn, data_pabrik=data_pabrik, data_barang=data_barang,
    tanggal=datetime.now().date())

# Halaman penerimaan barang
@app.route('/admin/penerimaan')
def adminpenerimaan():
    tahun = request.args.get('tahun')
    bulan = request.args.get('bulan')
    tanggal = request.args.get('tanggal')

    # Query untuk mengambil data penerimaan barang
    query = "SELECT * ,YEAR(tglfaktur) AS tahun FROM barang_masuk"
    filters = []
    if tahun:
        filters.append(f"YEAR(tglfaktur) = {tahun}")
    if bulan:
        filters.append(f"MONTH(tglfaktur) = {bulan}")
    if tanggal:
        filters.append(f"DAY(tglfaktur) = {tanggal}")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += " ORDER BY barang_masuk.id DESC"

    # Ambil data dari database
    info_list = fetch(query)
    for i in info_list:
        g.con.execute("SELECT * FROM pabrik WHERE id = %s", (i["id_supplier"],))
        supplier = g.con.fetchone()
        i['nama_supplier'] = supplier[1]

    print(info_list)

    # Ambil data tambahan
    data_barang = fetch("SELECT * FROM barang ORDER BY id")
    data_pabrik = fetch("SELECT * FROM pabrik ORDER BY id")
    data_detail_masuk = fetch("SELECT *, barang.* FROM detail_barang_masuk INNER JOIN barang on barang.id = detail_barang_masuk.id_barang")
    thn = fetch_years("SELECT YEAR(tglfaktur) AS tahun FROM barang_masuk GROUP BY tahun")
    print(data_detail_masuk)
    return render_template("admin/penerimaan.html",data_detail_masuk = data_detail_masuk, info_list=info_list, 
    tahun=thn, data_pabrik=data_pabrik, data_barang=data_barang, tanggal=datetime.now().date())

@app.route('/admin/penerimaan/tambah/id', methods=['POST'])
@jwt_required()
def tambah_id_penerimaan_new():
    data = request.json
    performabelanja = 0.0
    print(data)
    for i in data['items']:
        # Validasi harga_total harus sesuai dengan harga_satuan * jml_menerima
        try:
            jml_menerima = int(i['jml_menerima'])
            harga_satuan = float(i['harga_satuan'])
            harga_total_calculated = jml_menerima * harga_satuan
            if float(i['harga_total']) != harga_total_calculated:
                return jsonify({"error": f"Harga total tidak sesuai. Seharusnya {harga_total_calculated}"}), 400
        except ValueError:
            return jsonify({"error": "Jumlah menerima dan harga satuan harus berupa angka"}), 400
        performabelanja += float(i['harga_total'])

    g.con.execute("SELECT * FROM pabrik WHERE id = %s", (data['id_supplier'],))
    supplier = g.con.fetchone()
    if not supplier:
        return jsonify({"error": "Supplier not found"}), 404
    g.con.execute("""
        INSERT INTO barang_masuk (tglfaktur, nofaktur, id_supplier, performa_belanja)
        VALUES (%s, %s, %s, %s)
    """, (data['tglfaktur'], data['nofaktur'], data['id_supplier'], performabelanja))
    
    new_id = g.con.lastrowid
    print(data['items'])
    #cek barang
    for i in data['items']:
        print(i)
        print(i['id_barang'])
        g.con.execute("SELECT sisa_gudang FROM barang_gudang WHERE id_barang = %s", (i['id_barang'],))
        result = g.con.fetchone()
        g.con.execute("SELECT stoklimit FROM barang WHERE id = %s", (i['id_barang'],))
        stoklimit = g.con.fetchone()
        g.con.execute("""INSERT INTO detail_barang_masuk (id_barang_masuk, id_barang, jml_menerima, harga_satuan, harga_total,pembayaran,jatohtempo,tglpembayaran,keterangan,lunastidak) 
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) """,
        (new_id, i['id_barang'], i['jml_menerima'], i['harga_satuan'],  i['harga_total'], i['pembayaran'], i['jthtempo'], i['tglpembayaran'], i['ket'], i['lunas_or_no']))
        
        if result:
            print(result[0])
            new_qty = result[0] + int(i['jml_menerima'])
            print(new_qty)
            if new_qty <= stoklimit[0]:
                ket = "Stok Tidak Aman"
            else:
                ket = "Stok Aman"
                g.con.execute("""
                    UPDATE barang_gudang SET sisa_gudang = %s, keterangan = %s WHERE id_barang = %s
                """, (new_qty, ket, i['id_barang']))
        else:
            new_qty = int(i['jml_menerima'])
            if new_qty <= stoklimit[0]:
                ket = "Stok Tidak Aman"
            else :
                ket = "Stok Aman"
            g.con.execute("""INSERT INTO barang_gudang(id_barang, sisa_gudang, keterangan) VALUES (%s,%s,%s) """,
        ( i['id_barang'], new_qty, ket))
        
    g.con.execute("""
                INSERT INTO adminis (id_barang_masuk, tanggalfaktur, nofaktur, id_supplier )
                VALUES (%s, %s, %s, %s)
            """, (new_id, data['tglfaktur'], data['nofaktur'], data['id_supplier']))
       
    g.con.connection.commit()
    return jsonify({"msg": "SUKSES"})

@app.route('/admin/penerimaan/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_id_penerimaan():
    id = request.json.get('id')
    g.con.execute("SELECT id, id_barang, jml_menerima  FROM detail_barang_masuk WHERE id_barang_masuk = %s", (int(id),))
    data = g.con.fetchall()
    if not data:
        return jsonify({"error": "Data tidak ditemukan"}), 404
    for i in data:
        print(i)
        _id, id_barang, jumlah = i
        # Kurangi jumlah di barang_gudang
        g.con.execute("SELECT sisa_gudang FROM barang_gudang WHERE id_barang = %s", (id_barang,))
        gudang = g.con.fetchone()
        g.con.execute("SELECT stoklimit FROM barang WHERE id = %s", (id_barang,))
        stoklimit = g.con.fetchone()
        if gudang:
            new_jumlah = max(0, gudang[0] - jumlah)
            if int(new_jumlah) <= stoklimit[0]:
                ket = "Stok Tidak Aman"
            else :
                ket = "Stok Aman"
            g.con.execute("UPDATE barang_gudang SET sisa_gudang = %s, keterangan = %s WHERE id_barang = %s", (new_jumlah, ket, id_barang))
            
        # Hapus dari detail_barang_masuk
        g.con.execute("DELETE FROM detail_barang_masuk WHERE id = %s", (int(_id),))
        g.con.connection.commit()
    # Hapus dari barang_masuk
    g.con.execute("DELETE FROM barang_masuk WHERE id = %s", (int(id),))
    # Hapus dari administrasi
    g.con.execute("DELETE FROM adminis WHERE id_barang_masuk = %s", (int(id),))
    g.con.connection.commit()
    return jsonify({"msg": "BERHASIL DIHAPUS"})
    
@app.route('/admin/penyimpanan')
def adminpenyimpanan():
    data_penyimpanan = fetch("SELECT * FROM barang_gudang ORDER BY id")
    nama_barang = request.args.get('nama_barang')
    query = "SELECT * FROM barang "
    filters = []
    if nama_barang:
        filters.append(f"nama_barang = '{nama_barang}'")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += ""
    data_db_barang = fetch(query)
    info_list = []
    for i in data_penyimpanan:
        for j in data_db_barang:
            if i['id_barang'] == j['id']:
                i['nama_barang'] = j['nama_barang']
                i['kode_barang'] = j['kode_barang']
                i['qty'] = j['qty']
                i['stok_limit'] = j['stoklimit']
                info_list.append(i)
    nama_barang = fetch("SELECT nama_barang FROM barang GROUP BY nama_barang")
    return render_template("admin/penyimpanan.html",info_list=info_list, nama_barang = nama_barang)
    
@app.route('/admin/penyimpanan/edit/id', methods=['PUT'])
@jwt_required()
def edit_penyimpanan():
    form_data = request.json
    
    try:
        id_penyimpanan = request.json.get('id')

        g.con.execute("SELECT id_barang FROM barang_gudang WHERE id = %s", ( id_penyimpanan, ))
        code = g.con.fetchone()
        g.con.execute("SELECT stoklimit FROM barang WHERE id = %s", (code[0],))
        stoklimit = g.con.fetchone()

        if code:
            new_qty = int(form_data['sisa_gudang'])
            if new_qty <= stoklimit[0]:
                ket = "Stok Tidak Aman"
            else :
                ket = "Stok Aman"
            g.con.execute(
                "UPDATE barang_gudang SET sisa_gudang = %s, keterangan = %s WHERE id_barang = %s",
                (new_qty,  ket, code[0]) )

        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/penyimpanan/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_id_penyimpanan():
    try:
        id = request.json.get('id')
        # Hapus dari barang_gudang
        g.con.execute("DELETE FROM barang_gudang WHERE id = %s", (int(id),))
        g.con.connection.commit()

        return jsonify({"msg": "BERHASIL DIHAPUS"})
    except Exception as e:
        print(e)
        return jsonify({"error": str(e)}), 500

@app.route('/admin/pengeluaran-tambah')
def tambahpengeluaran():
    data_barang = fetch("""SELECT barang.id, barang.nama_barang,barang.qty, barang_gudang.sisa_gudang, barang.stoklimit 
    FROM barang INNER JOIN barang_gudang on barang_gudang.id_barang = barang.id ORDER BY barang_gudang.id""")
    print(data_barang)
    data_sales = fetch("""SELECT * FROM detail_sales 
    INNER JOIN sales ON sales.id = detail_sales.id_sales 
    INNER JOIN outlet ON outlet.id = detail_sales.id_outlet ORDER BY detail_sales.id""")
    nama_sales = fetch("""SELECT * FROM detail_sales 
    INNER JOIN sales ON sales.id = detail_sales.id_sales 
    INNER JOIN outlet ON outlet.id = detail_sales.id_outlet GROUP BY nama_sales ORDER BY detail_sales.id""")
    data_outlet = fetch("""SELECT outlet.nama_outlet, outlet.alamat_outlet FROM detail_sales 
    INNER JOIN sales ON sales.id = detail_sales.id_sales 
    INNER JOIN outlet ON outlet.id = detail_sales.id_outlet ORDER BY detail_sales.id""")
    tanggal = datetime.now()
    
    # Hitung Jatuh Tempo tambah 1 bulan
    jth_tempo = tanggal + relativedelta(months=1)
    jth_tempo = jth_tempo.strftime("%Y-%m-%d")
    # Hitung nofaktur berdasarkan jumlah barang_keluar pada tanggal yang sama
    tanggal = tanggal.strftime('%Y-%m-%d')
    g.con.execute("SELECT COUNT(*) FROM barang_keluar WHERE tglfaktur = %s", (tanggal,))
    count = g.con.fetchone()[0]
    nofaktur = f"{tanggal.replace('-', '')}{int(count) + 1:03d}"  # Gabungkan tanggal dengan nomor urut (001, 002, ...)
    return render_template("admin/tambah-pengeluaran.html", data_sales = data_sales, data_outlet = data_outlet, nama_sales=nama_sales,  
                           data_barang = data_barang, tanggal = tanggal, nofaktur = nofaktur, jth_tempo = jth_tempo)

@app.route('/admin/pengeluaran')
def adminpengeluaran():
    tahun = request.args.get('tahun')
    bulan = request.args.get('bulan')
    tanggal = request.args.get('tanggal')
    nama_sales = request.args.get('nama_sales')
    nama_outlet = request.args.get('nama_outlet')

    # Fetch data
    data_sales = fetch("""
        SELECT * FROM detail_sales 
        INNER JOIN sales ON sales.id = detail_sales.id_sales 
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet 
        ORDER BY detail_sales.id DESC
    """)
    data_outlet = fetch("""
        SELECT outlet.nama_outlet, outlet.alamat_outlet FROM detail_sales 
        INNER JOIN sales ON sales.id = detail_sales.id_sales 
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet 
        ORDER BY detail_sales.id DESC
    """)

    # Build query with filters
    query = """
        SELECT barang_keluar.id, barang_keluar.*, YEAR(tglfaktur) AS tahun, sales.nama_sales, outlet.nama_outlet 
        FROM barang_keluar 
        INNER JOIN detail_sales ON detail_sales.id = barang_keluar.id_sales
        INNER JOIN sales on sales.id = detail_sales.id_sales
        INNER JOIN outlet on outlet.id = detail_sales.id_outlet
    """
    filters = []
    if tahun:
        filters.append(f"YEAR(tglfaktur) = {tahun}")
    if bulan:
        filters.append(f"MONTH(tglfaktur) = {bulan}")
    if tanggal:
        filters.append(f"DAY(tglfaktur) = {tanggal}")
    if nama_sales:
        filters.append(f"sales.nama_sales = '{nama_sales}'")
    if nama_outlet:
        filters.append(f"outlet.nama_outlet = '{nama_outlet}'")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += "ORDER BY barang_keluar.id DESC"

    # Fetch additional data
    data_barang = fetch("SELECT * FROM barang ORDER BY id")
    info_list = fetch(query)
    thn = fetch_years("SELECT YEAR(tglfaktur) AS tahun FROM barang_keluar GROUP BY tahun")
    data_pabrik = fetch("SELECT * FROM pabrik ORDER BY id")
    data_detail_keluar = fetch("""
        SELECT *, barang.kode_barang, barang.nama_barang, barang.qty, barang.stoklimit 
        FROM detail_barang_keluar 
        INNER JOIN barang ON barang.id = detail_barang_keluar.id_barang 
        ORDER BY detail_barang_keluar.id
    """)
    nama_outlet = fetch("""
        SELECT outlet.nama_outlet FROM detail_sales 
        INNER JOIN sales ON sales.id = detail_sales.id_sales 
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet 
        INNER JOIN barang_keluar ON barang_keluar.id_sales = sales.id 
        GROUP BY outlet.nama_outlet 
        ORDER BY barang_keluar.id
    """)
    nama_sales = fetch("""
        SELECT sales.nama_sales FROM detail_sales 
        INNER JOIN sales ON sales.id = detail_sales.id_sales 
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet 
        INNER JOIN barang_keluar ON barang_keluar.id_sales = sales.id 
        GROUP BY sales.nama_sales 
        ORDER BY barang_keluar.id
    """)
    tanggal = datetime.now()
    tanggal_pengeluaran = fetch("SELECT tglfaktur FROM barang_keluar GROUP BY tglfaktur ORDER BY id")

    # Calculate Jatuh Tempo and No Faktur
    jth_tempo = (tanggal + relativedelta(months=1)).strftime("%Y-%m-%d")
    tanggal_str = tanggal.strftime('%Y-%m-%d')
    g.con.execute("SELECT COUNT(*) FROM barang_keluar WHERE tglfaktur = %s", (tanggal_str,))
    count = g.con.fetchone()[0]
    nofaktur = f"{tanggal_str.replace('-', '')}{int(count) + 1:03d}"

    # Render template
    return render_template(
        "admin/pengeluaran.html",
        info_list=info_list,
        tahun=thn,
        data_sales=data_sales,
        data_outlet=data_outlet,
        nama_outlet=nama_outlet,
        tanggal_pengeluaran=tanggal_pengeluaran,
        data_barang=data_barang,
        data_pabrik=data_pabrik,
        tanggal=tanggal_str,
        nofaktur=nofaktur,
        jth_tempo=jth_tempo,
        nama_sales=nama_sales,
        data_detail_keluar=data_detail_keluar
    )

@app.route('/admin/pengeluaran/tambah/id', methods=['POST'])
@jwt_required()
def tambah_id_pengeluaran_new():
    data = request.json
    performasales = Decimal('0.0')  # Awal Pastikan ini Decimal, bukan float!

    for item in data['items']:
        harga_total = Decimal(str(item.get('harga_total', '0')))
        performasales += harga_total

    if str(data.get('pajak', '')).lower() == 'yes':
        pajak_rate = Decimal('11') / Decimal('100')
        pajak_amount = pajak_rate * performasales
        performasales += pajak_amount  # Sekarang PPN ditambahkan dengan benar

    g.con.execute("""
        SELECT detail_sales.id FROM detail_sales 
        INNER JOIN sales ON sales.id = detail_sales.id_sales 
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet 
        WHERE sales.nama_sales = %s AND outlet.nama_outlet = %s
    """, (data['nama_sales'], data['nama_outlet']))
    id_sales = g.con.fetchone()
    if not id_sales:
        return jsonify({"error": "Sales not found"}), 404
    g.con.execute("""
    INSERT INTO barang_keluar (tglfaktur, jatuhtempo, nomerfaktur, id_sales,cashtempo, performa_sales, pajak)
    VALUES (%s, %s, %s, %s, %s, %s, %s)""", 
    (data['tglfaktur'], data['jthtempo'], data['nofaktur'], id_sales[0], data['pembayaran'],performasales, data['pajak']))
    new_id = g.con.lastrowid
    print(data['items'])
    #cek barang
    for i in data['items']:
        print(i)
        print(i['nama_barang'])
        print(i['id_barang'])
        g.con.execute("SELECT sisa_gudang FROM barang_gudang WHERE id_barang = %s", (i['id_barang'],))
        result = g.con.fetchone()
        g.con.execute("SELECT stoklimit FROM barang WHERE id = %s", (i['id_barang'],))
        stoklimit = g.con.fetchone()
        if result:
            g.con.execute("""
            INSERT INTO detail_barang_keluar (id_barang_keluar, id_barang, jmlpermintaan, harga_satuan, diskon, harga_total, 
            cn, hpp, totalhpp, profit, tanggal_pembayaran, metode_pembayaran, lunas_or_no) 
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s) """,
        (new_id, i['id_barang'], i['jmlpermintaan'], i['harga_satuan'], i['diskon'], i['harga_total'], i['cn'], i['hpp'], i['totalhpp'], i['profit'], 
        i['tanggal_pembayaran'], i['metode_pembayaran'],i['lunas_or_no']))
        
            print(result[0])
            new_qty = result[0] - int(i['jmlpermintaan'])
            if new_qty < 0 :
                return jsonify({"error": "Stok Kurang"}), 404
            elif new_qty <= stoklimit[0]:
                ket = "Stok Tidak Aman"
            else :
                ket = "Stok Aman"
                g.con.execute("""
                    UPDATE barang_gudang SET sisa_gudang = %s, keterangan = %s WHERE id_barang = %s
                """, (new_qty, ket, i['id_barang']))
        else:
            return jsonify({"error": "Barang tidak ditemukan di gudang"}), 404
    
    g.con.connection.commit()
    return jsonify({"msg": "SUKSES"})

@app.route('/admin/pengeluaran/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_pengeluaran():
    try:
        id = request.json.get('id')
        print(id)
        g.con.execute("SELECT id_barang, jmlpermintaan, id FROM detail_barang_keluar WHERE id_barang_keluar = %s", 
        (int(id),))
        data = g.con.fetchall()
        print(data)
        if not data:
            return jsonify({"error": "Data tidak ditemukan"}), 404

        for i in data:
            # Kurangi jumlah di barang_gudang
            g.con.execute("SELECT sisa_gudang FROM barang_gudang WHERE id_barang = %s", (i[0],))
            gudang = g.con.fetchone()
            g.con.execute("SELECT stoklimit FROM barang WHERE id = %s", (i[0],))
            stoklimit = g.con.fetchone()
            if gudang:
                new_jumlah = max(0, gudang[0] + i[1])
                if int(new_jumlah) <= stoklimit[0]:
                    ket = "Stok Tidak Aman"
                else :
                    ket = "Stok Aman"
                g.con.execute("UPDATE barang_gudang SET sisa_gudang = %s, keterangan = %s WHERE id_barang = %s"
                              , (new_jumlah, ket, i[0]))
            # Hapus dari detail_barang_masuk
            g.con.execute("DELETE FROM detail_barang_keluar WHERE id = %s", (i[2],))
        # Hapus dari barang_masuk
        g.con.execute("DELETE FROM barang_keluar WHERE id = %s", (int(id),))
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/keuangan')
def adminkeuangan():
    # Ambil parameter dari request
    tahun = request.args.get('tahun')
    bulan = request.args.get('bulan')
    tanggal = request.args.get('tanggal')
    nama_sales = request.args.get('nama_sales')
    nama_outlet = request.args.get('nama_outlet')
    # Ambil data sales dan outlet
    data_sales = fetch("""
        SELECT * FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
        ORDER BY detail_sales.id
    """)
    data_outlet = fetch("""
        SELECT outlet.nama_outlet, outlet.alamat_outlet FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
        ORDER BY detail_sales.id
    """)
    # Query untuk data barang keluar
    query = """
        SELECT barang_keluar.id, barang_keluar.*, YEAR(tglfaktur) AS tahun, 
               sales.nama_sales, outlet.nama_outlet, outlet.alamat_outlet
        FROM barang_keluar
        INNER JOIN detail_sales ON detail_sales.id = barang_keluar.id_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
    """
    filters = []
    if tahun:
        filters.append(f"YEAR(tglfaktur) = {tahun}")
    if bulan:
        filters.append(f"MONTH(tglfaktur) = {bulan}")
    if tanggal:
        filters.append(f"DAY(tglfaktur) = {tanggal}")
    if nama_sales:
        list_sales = [i['id'] for i in data_sales if i['nama_sales'] == nama_sales]
        if list_sales:
            filters.append(f"id_sales IN ({', '.join(map(str, list_sales))})")
    if nama_outlet:
        list_outlet = [i['id'] for i in data_sales if i['nama_outlet'] == nama_outlet]
        if list_outlet:
            filters.append(f"id_sales IN ({', '.join(map(str, list_outlet))})")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += " ORDER BY barang_keluar.id desc"
    # Ambil data tambahan
    data_barang = fetch("SELECT * FROM barang ORDER BY id")
    info_list = fetch(query)
    thn = fetch_years("SELECT YEAR(tglfaktur) AS tahun FROM barang_keluar GROUP BY tahun")
    data_pabrik = fetch("SELECT * FROM pabrik ORDER BY id")
    data_detail_keluar = fetch("""
        SELECT detail_barang_keluar.id AS id, detail_barang_keluar.*, 
               barang.kode_barang, barang.nama_barang, barang.qty, barang.stoklimit
        FROM detail_barang_keluar
        INNER JOIN barang ON barang.id = detail_barang_keluar.id_barang
        ORDER BY detail_barang_keluar.id
    """)
    nama_outlet = fetch("""
        SELECT outlet.nama_outlet FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
        INNER JOIN barang_keluar ON barang_keluar.id_sales = detail_sales.id
        GROUP BY outlet.nama_outlet
        ORDER BY barang_keluar.id
    """)
    nama_sales = fetch("""
        SELECT sales.nama_sales FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
        INNER JOIN barang_keluar ON barang_keluar.id_sales = detail_sales.id
        GROUP BY sales.nama_sales
        ORDER BY barang_keluar.id
    """)
    tanggal = datetime.now()
    tanggal_pengeluaran = fetch("""
        SELECT tglfaktur FROM barang_keluar
        GROUP BY tglfaktur
        ORDER BY id
    """)
    # Hitung Jatuh Tempo tambah 1 bulan
    jth_tempo = (tanggal + relativedelta(months=1)).strftime("%Y-%m-%d")
    # Hitung nofaktur berdasarkan jumlah barang_keluar pada tanggal yang sama
    tanggal_str = tanggal.strftime('%Y-%m-%d')
    g.con.execute("SELECT COUNT(*) FROM barang_keluar WHERE tglfaktur = %s", (tanggal_str,))
    count = g.con.fetchone()[0]
    nofaktur = f"{tanggal_str.replace('-', '')}{int(count) + 1:03d}"
    # Render template dengan data
    return render_template(
        "admin/keuangan.html",
        info_list=info_list,
        tahun=thn,
        data_sales=data_sales,
        data_outlet=data_outlet,
        nama_outlet=nama_outlet,
        tanggal_pengeluaran=tanggal_pengeluaran,
        data_barang=data_barang,
        data_pabrik=data_pabrik,
        tanggal=tanggal_str,
        nofaktur=nofaktur,
        jth_tempo=jth_tempo,
        nama_sales=nama_sales,
        data_detail_keluar=data_detail_keluar
    )

@app.route('/admin/keuangan/tambah/id', methods=['POST'])
@jwt_required()
def tambah_id_keuangan_new():
    data = request.json
    try:
        g.con.execute("""
            INSERT INTO barang_masuk (tglfaktur, nofaktur, supplier, nama_barang, id_barang, qty, jml_menerima,
            harga_satuan, harga_total) VALUES (%s, %s, %s, %s, %s, %s)
        """, (data['pabrik'], data['nama_barang'], data['satuan'], data['jumlah'], data['harga_pabrik'], data['tanggal']))

        g.con.execute("SELECT sisa_gudang FROM barang_gudang WHERE nama_barang = %s", (data['nama_barang'],))
        result = g.con.fetchall()
        if result:
            new_qty = result[0] + data['jumlah']
            g.con.execute("""
                UPDATE barang_gudang SET sisa_gudang = %s WHERE nama_barang = %s
            """, (new_qty, data['nama_barang']))
        else:
            g.con.execute("""
                INSERT INTO barang_gudang (Nama_barang, qty, sisa_gudang)
                VALUES (%s, %s, %s)
            """, (data['nama_barang'], data['satuan'], data['jumlah']))

        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(e)
        return jsonify({"error": str(e)}), 500
        
@app.route('/admin/edit-keuangan/<id>', methods=['GET'])
@jwt_required()
def edit_keuangan_new(id):
    print(id)
    return render_template("admin/edit-keuangan.html")
    
@app.route('/admin/keuangan/edit/id', methods=['PUT'])
@jwt_required()
def edit_id_keuangan_new():
        form_data = request.json
        print(form_data)
        fields = [ 'tanggal_pembayaran', 'metode_pembayaran', 'lunas_or_no']
    
        items = form_data['items']
        for i in items:
            # Siapkan query UPDATE
            i.get('id')
            query = f"UPDATE detail_barang_keluar SET {', '.join([f'{field} = %s' for field in fields])} WHERE id = %s"
            values = tuple(i.get(field) for field in fields) + (int(i.get('id')),)
            print(values)
            g.con.execute(query, values)
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})

@app.route('/admin/administrasi')
def adminadministrasi():
    
    tahun = request.args.get('tahun')
    bulan = request.args.get('bulan')
    tanggal = request.args.get('tanggal')

    query = "SELECT * ,YEAR(tanggalfaktur) AS tahun FROM adminis"
    filters = []
    if tahun:
        filters.append(f"YEAR(tanggalfaktur) = {tahun}")
    if bulan:
        filters.append(f"MONTH(tanggalfaktur) = {bulan}")
    if tanggal:
        filters.append(f"DAY(tanggalfaktur) = {tanggal}")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += " ORDER BY adminis.id desc"

    info_list = fetch(query)
    for i in info_list:
        g.con.execute("SELECT * FROM pabrik WHERE id = %s",( i["id_supplier"],))
        supplier = g.con.fetchone()
        i['nama_supplier'] = supplier[1]
        i['alamat'] = supplier[2]
        i['tlp'] = supplier[3]
    data_detail_masuk = fetch("""SELECT detail_barang_masuk.*, barang.nama_barang FROM detail_barang_masuk 
    INNER JOIN barang on barang.id = detail_barang_masuk.id_barang""")
    thn = fetch_years("SELECT YEAR(tanggalfaktur) AS tahun FROM adminis GROUP BY tahun")
    
    return render_template("admin/administrasi.html", data_detail_masuk = data_detail_masuk, info_list = info_list, tahun = thn)

@app.route('/admin/administrasi/edit/id', methods=['PUT'])
@jwt_required()
def edit_administrasi():
    form_data = request.json
    fields = [ 'pembayaran',  'jatohtempo', 'tglpembayaran','keterangan', 'lunastidak']
    print(form_data)
    try:
        items = form_data['items']
        for i in items:
            # Siapkan query UPDATE
            query = f"UPDATE detail_barang_masuk SET {', '.join([f'{field} = %s' for field in fields])} WHERE id = %s"
            values = tuple(i.get(field) for field in fields) + (int(i.get('id')),)
            print(values)
            g.con.execute(query, values)
            g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/administrasi/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_administrasi():
    form_data = request.get_json()
    try:
        id_administrasi = form_data['id']

        g.con.execute("SELECT id_barang_masuk FROM adminis WHERE id = %s", (id_administrasi,))
        id_barang_masuk = g.con.fetchone()['id_barang_masuk']
        g.con.execute("DELETE FROM adminis WHERE id = %s", (id_administrasi,))
        g.con.execute("DELETE FROM barang_masuk WHERE id = %s", (id_barang_masuk,))
        g.con.execute("SELECT id, id_barang, jml_menerima  FROM detail_barang_masuk WHERE id_barang_masuk = %s", 
        (id_barang_masuk,))
        data = g.con.fetchall()
        print(data)
        if not data:
            return jsonify({"error": "Data tidak ditemukan"}), 404
        for i in data:
            print(i)
            _id, id_barang, jumlah = i['id'], i['id_barang'], i['jml_menerima']
            print(_id)
            # Kurangi jumlah di barang_gudang
            g.con.execute("SELECT sisa_gudang FROM barang_gudang WHERE id_barang = %s", (id_barang,))
            gudang = g.con.fetchone()
            g.con.execute("SELECT stoklimit FROM barang WHERE id = %s", (id_barang,))
            stoklimit = g.con.fetchone()

            if gudang:
                new_jumlah = max(0, gudang['sisa_gudang'] - jumlah)
                if int(new_jumlah) <= stoklimit['stoklimit']:
                    ket = "Stok Tidak Aman"
                else :
                    ket = "Stok Aman"
                g.con.execute("UPDATE barang_gudang SET sisa_gudang = %s, keterangan = %s WHERE id_barang = %s", 
                (new_jumlah, ket, id_barang))
        
        g.con.execute("DELETE FROM detail_barang_masuk WHERE id_barang_masuk = %s", (id_barang_masuk,))
        g.con.connection.commit()

        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})
        
@app.route('/admin/barang')
def adminbarang():
    nama_barang = request.args.get('nama_barang')

    query = "SELECT *  FROM barang"
    filters = []
    if nama_barang:
        filters.append(f"nama_barang = '{nama_barang}'")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += ""
    info_list = fetch(query)
    nama_barang = fetch("SELECT nama_barang FROM barang GROUP BY nama_barang")
    return render_template("admin/barang.html", info_list=info_list, nama_barang = nama_barang)

@app.route('/admin/barang/tambah', methods=['POST'])
@jwt_required()
def tambah_id_barang_new():
    form_data = request.get_json()
    fields = ['kode_barang', 'nama_barang', 'qty', 'stoklimit']
    print(form_data)

    query = f"INSERT INTO barang ({', '.join(fields)}) VALUES ({', '.join(['%s'] * len(fields))})"

    try:
        values = tuple(form_data[field] for field in fields)
        g.con.execute(query, values)
        id_barang = g.con.lastrowid
        query = f"INSERT INTO barang_gudang(id_barang,sisa_gudang,keterangan) values(%s,%s,%s)"
        g.con.execute(query, (id_barang, 0, "Stok Tidak Aman"))

        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print("Error saat insert:", str(e))
        return jsonify({"error": str(e)}), 500
    
@app.route('/admin/barang/edit/id', methods=['PUT'])
@jwt_required()
def edit_barang():
    form_data = request.json
    fields = ['kode_barang','nama_barang', 'qty', 'stoklimit']
    
    try:
        id_barang = form_data['id'] 
        # Siapkan query UPDATE
        query = f"UPDATE barang SET {', '.join([f'{field} = %s' for field in fields])} WHERE id = %s"
        values = tuple(form_data.get(field) for field in fields) + (id_barang,)
        print(query)
        print(values)
        g.con.execute(query, values)
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/barang/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_barang():
    form_data = request.get_json()
    try:
        id_barang = form_data['id']

        query = "DELETE FROM barang WHERE id = %s"
        g.con.execute(query, (id_barang,))
        g.con.connection.commit()

        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})
    
@app.route('/admin/target_sales')
def admintarget_sales():
    id_sales = request.args.get('id_sales')
    tahun = request.args.get('tahun')
    bulan = request.args.get('bulan')

    query = """SELECT target_sales.id, sales.nama_sales, target_sales.target, target_sales.bulan, 
    target_sales.tahun, target_sales.id_sales
    FROM target_sales INNER JOIN sales on sales.id = target_sales.id_sales """
    filters = []
    if tahun:
        filters.append(f"tahun = {tahun}")
    if bulan:
        filters.append(f"bulan = {bulan}")
    if id_sales:
        filters.append(f"id_sales = '{id_sales}'")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += " ORDER BY sales.nama_sales asc"
    info_list = fetch(query)
    for i in info_list:
        bulan_dicari = str(int(i['bulan']))  # normalisasi ke format '5', '12', dst
        nama_bulan = next((b['nama_bulan'] for b in list_bulan if b['value'] == bulan_dicari), None)
        i['bulan'] = nama_bulan
    nama_sales = fetch("SELECT id, nama_sales FROM sales GROUP BY nama_sales")
    tahun = fetch("select tahun FROM target_sales GROUP BY tahun desc")
    return render_template("admin/target_sales.html", info_list=info_list, nama_sales = nama_sales, tahun=tahun)

@app.route('/admin/target_sales/tambah', methods=['POST'])
@jwt_required()
def tambah_id_target_sales_new():
    form_data = request.get_json()
    fields = ['id_sales','target','tahun','bulan']
    print(form_data)
    query = f"INSERT INTO target_sales ({', '.join(fields)}) VALUES ({', '.join(['%s'] * len(fields))})"

    try:
        values = tuple(form_data[field] for field in fields)
        g.con.execute(query, values)
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print("Error saat insert:", str(e))
        return jsonify({"error": str(e)}), 500
    
@app.route('/admin/target_sales/edit/id', methods=['PUT'])
@jwt_required()
def edit_target_sales():
    form_data = request.json
    fields = ['id_sales','target','tahun','bulan']
    
    try:
        id_target_sales = form_data['id'] 

        # Siapkan query UPDATE
        query = f"UPDATE target_sales SET {', '.join([f'{field} = %s' for field in fields])} WHERE id = %s"
        values = tuple(form_data.get(field) for field in fields) + (id_target_sales,)
        print(query)
        print(values)
        g.con.execute(query, values)
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/target_sales/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_target_sales():
    form_data = request.get_json()
    try:
        id_target_sales = form_data['id']

        query = "DELETE FROM target_sales WHERE id = %s"
        g.con.execute(query, (id_target_sales,))
        g.con.connection.commit()

        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})
    
@app.route('/admin/pabrik')
def adminpabrik():
    nama_supplier = request.args.get('nama_supplier')

    query = "SELECT *  FROM pabrik"
    filters = []
    if nama_supplier:
        filters.append(f"nama_supplier = '{nama_supplier}'")
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += ""
    info_list = fetch(query)
    nama_supplier = fetch("SELECT nama_supplier FROM pabrik GROUP BY nama_supplier")

    return render_template("admin/pabrik.html",info_list=info_list, nama_supplier = nama_supplier)

@app.route('/admin/pabrik/tambah', methods=['POST'])
@jwt_required()
def tambah_id_pabrik_new():
    form_data = request.get_json()
    fields = ['nama_supplier', 'alamat', 'tlp']
    print(form_data)

    query = f"INSERT INTO pabrik ({', '.join(fields)}) VALUES ({', '.join(['%s'] * len(fields))})"

    try:
        values = tuple(form_data[field] for field in fields)
        g.con.execute(query, values)
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print("Error saat insert:", str(e))
        return jsonify({"error": str(e)}), 500
    
@app.route('/admin/pabrik/edit/id', methods=['PUT'])
@jwt_required()
def edit_pabrik():
    form_data = request.json
    fields = ['nama_supplier', 'alamat', 'tlp']
    
    try:
        id_pabrik = form_data['id'] 

        # Siapkan query UPDATE
        query = f"UPDATE pabrik SET {', '.join([f'{field} = %s' for field in fields])} WHERE id = %s"
        values = tuple(form_data.get(field) for field in fields) + (id_pabrik,)
        print(query)
        print(values)
        g.con.execute(query, values)
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/pabrik/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_pabrik():
    form_data = request.get_json()
    try:
        id_pabrik = form_data['id']

        query = "DELETE FROM pabrik WHERE id = %s"
        g.con.execute(query, (id_pabrik,))
        g.con.connection.commit()

        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)})

@app.route('/admin/sales')
def adminsales():
    # Ambil parameter dari request
    nama_sales = request.args.get('nama_sales')
    nama_outlet = request.args.get('nama_outlet')
    alamat_outlet = request.args.get('alamat_outlet')
    # Query utama untuk mengambil data sales
    query = """
        SELECT detail_sales.id as id,detail_sales.id_sales, detail_sales.id_outlet, sales.nama_sales, 
        outlet.nama_outlet, outlet.alamat_outlet 
        FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
    """
    # Tambahkan filter jika ada parameter
    filters = []
    if nama_sales:
        filters.append(f"sales.nama_sales = '{nama_sales}'")
    if nama_outlet:
        filters.append(f"outlet.nama_outlet = '{nama_outlet}'")
    if alamat_outlet:
        filters.append(f"outlet.alamat_outlet = '{alamat_outlet}'")
    if filters:
        query += " WHERE " + " AND ".join(filters) 
    query += " ORDER BY sales.nama_sales asc"
    # Ambil data dari database
    info_list = fetch(query)
    # Ambil data untuk dropdown filter
    nama_sales = fetch("""
        SELECT nama_sales FROM sales
    """)
    nama_outlet = fetch("""
        SELECT nama_outlet FROM outlet
    """)
    alamat_outlet = fetch("""
        SELECT alamat_outlet FROM outlet
    """)
    # Render template dengan data
    return render_template(
        "admin/sales.html",
        info_list=info_list,
        nama_sales=nama_sales,
        nama_outlet=nama_outlet,
        alamat_outlet=alamat_outlet
    )

@app.route('/admin/sales/tambah', methods=['POST'])
@jwt_required()
def tambah_id_sales_new():
    form_data = request.get_json()
    print(form_data)
    g.con.execute("""select id, nama_sales FROM sales WHERE nama_sales = %s """,(form_data['nama_sales'],))
    result = g.con.fetchone()
    if result:
        id_sales = result[0]
    else:
        g.con.execute(""" insert into sales(nama_sales) values (%s)""",(form_data['nama_sales'],))
        id_sales = g.con.lastrowid
        g.con.connection.commit()
        
    g.con.execute("""select id, nama_outlet FROM outlet WHERE nama_outlet= %s """,(form_data['nama_outlet'],))
    result = g.con.fetchone()
    if result:
        id_outlet = result[0]
    else:
        g.con.execute(""" insert into outlet(nama_outlet, alamat_outlet) values (%s,%s)""",
        (form_data['nama_outlet'],form_data['alamat_outlet']))
        id_outlet = g.con.lastrowid
        g.con.connection.commit()
    try:
        g.con.execute(""" insert into detail_sales(id_sales,id_outlet) values(%s,%s) """,(id_sales, id_outlet))
        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print("Error saat insert:", str(e))
        return jsonify({"error": str(e)}), 500

@app.route('/admin/sales/edit/id', methods=['PUT'])
@jwt_required()
def edit_sales():
    form_data = request.json

    try:
        id_detail_sales = form_data.get('id')
        print(id_detail_sales)
        # Ambil data detail_sales saat ini
        g.con.execute("SELECT id_sales, id_outlet FROM detail_sales WHERE id = %s", (id_detail_sales,))
        detail = g.con.fetchone()
        if not detail:
            return jsonify({"error": "Detail sales tidak ditemukan"}), 404

        current_id_sales = detail[0]
        current_id_outlet = detail[1]

        # ==== HANDLE NAMA SALES ====
        g.con.execute("SELECT nama_sales FROM sales WHERE id = %s", (current_id_sales,))
        current_sales = g.con.fetchone()
        if not current_sales:
            return jsonify({"error": "Sales tidak ditemukan"}), 404

        nama_sales_baru = form_data.get('nama_sales')
        if nama_sales_baru != current_sales[0]:
            g.con.execute("SELECT id FROM sales WHERE nama_sales = %s", (nama_sales_baru,))
            existing_sales = g.con.fetchone()
            if existing_sales:
                new_id_sales = existing_sales[0]
            else:
                g.con.execute("INSERT INTO sales (nama_sales) VALUES (%s)", (nama_sales_baru,))
                new_id_sales = g.con.lastrowid
                g.con.connection.commit()
        else:
            new_id_sales = current_id_sales  # Tidak berubah

        # ==== HANDLE OUTLET ====
        g.con.execute("SELECT nama_outlet, alamat_outlet FROM outlet WHERE id = %s", (current_id_outlet,))
        current_outlet = g.con.fetchone()
        if not current_outlet:
            return jsonify({"error": "Outlet tidak ditemukan"}), 404

        nama_outlet_baru = form_data.get('nama_outlet')
        alamat_outlet_baru = form_data.get('alamat_outlet')

        if (nama_outlet_baru != current_outlet[0]) or (alamat_outlet_baru != current_outlet[1]):
            g.con.execute(
                "SELECT id FROM outlet WHERE nama_outlet = %s AND alamat_outlet = %s",
                (nama_outlet_baru, alamat_outlet_baru)
            )
            existing_outlet = g.con.fetchone()
            if existing_outlet:
                new_id_outlet = existing_outlet[0]
            else:
                g.con.execute(
                    "INSERT INTO outlet (nama_outlet, alamat_outlet) VALUES (%s, %s)",
                    (nama_outlet_baru, alamat_outlet_baru)
                )
                new_id_outlet = g.con.lastrowid
                g.con.connection.commit()
        else:
            new_id_outlet = current_id_outlet  # Tidak berubah

        # ==== UPDATE detail_sales ====
        g.con.execute(
            "UPDATE detail_sales SET id_sales = %s, id_outlet = %s WHERE id = %s",
            (new_id_sales, new_id_outlet, id_detail_sales)
        )
        g.con.connection.commit()

        return jsonify({"msg": "SUKSES"}), 200

    except Exception as e:
        print("Error:", str(e))
        return jsonify({"error": str(e)}), 500

@app.route('/admin/sales/hapus/id', methods=['DELETE'])
@jwt_required()
def hapus_sales():
    form_data = request.get_json()
    try:
        id_detail_sales = form_data['id']
        print(id_detail_sales)
        # Hapus data dari tabel detail_sales
        
        g.con.execute("SELECT * FROM detail_sales WHERE id = %s", (id_detail_sales,))
        detail_sales = g.con.fetchone()
        print(detail_sales)
        g.con.execute("DELETE FROM detail_sales WHERE id = %s", (id_detail_sales,))
        g.con.execute("SELECT id_sales FROM detail_sales WHERE id_sales = %s", (detail_sales[1],))
        result= g.con.fetchall()
        print(result)
        if result:
            pass
        else:
            g.con.execute("DELETE FROM sales WHERE id = %s", (detail_sales[1],))
            g.con.connection.commit()
        g.con.execute("SELECT id_outlet FROM detail_sales WHERE id_outlet  = %s", (detail_sales[2],))
        result= g.con.fetchall()
        print(result)
        if result:
            pass
        else:
            g.con.execute("DELETE FROM outlet WHERE id = %s", (detail_sales[2],))
            g.con.connection.commit()

        g.con.connection.commit()
        return jsonify({"msg": "SUKSES"})
    except Exception as e:
        print(str(e))
        return jsonify({"error": str(e)}), 500
        
@app.route('/admin/performa_sales')
def adminperformasales():
    # Ambil parameter dari request
    tahun = request.args.get('tahun')
    bulan = request.args.get('bulan')
    selected_sales = request.args.get('sales')

    # Query untuk mendapatkan data sales
    query_sales = """
        SELECT * 
        FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
    """
    sales_filters = []
    if selected_sales:
        sales_filters.append(f"nama_sales = '{selected_sales}'")
    if sales_filters:
        query_sales += " WHERE " + " AND ".join(sales_filters)
    
    info_list = fetch(query_sales)

    # Query untuk mendapatkan data barang keluar
    query = """
        SELECT 
            bk.*, 
            YEAR(bk.tglfaktur) AS tahun, 
            MONTH(bk.tglfaktur) AS bulan,
            SUM(CASE WHEN dbk.lunas_or_no = 'Lunas' THEN dbk.harga_total ELSE 0 END) AS performa_sales
        FROM 
            barang_keluar bk
        INNER JOIN 
            detail_barang_keluar dbk ON dbk.id_barang_keluar = bk.id
    """
    filters = []
    params = []

    if tahun:
        filters.append("YEAR(bk.tglfaktur) = %s")
        params.append(tahun)
    if bulan:
        filters.append("MONTH(bk.tglfaktur) = %s")
        params.append(bulan)

    if filters:
        query += " WHERE " + " AND ".join(filters)

    query += """
        GROUP BY bk.id
        ORDER BY tahun DESC, bulan ASC
    """

    data_barang_keluar = fetch(query, params)


    # Ambil daftar tahun
    list_tahun = fetch("""
        SELECT DISTINCT YEAR(tglfaktur) AS tahun
        FROM barang_keluar
        ORDER BY tahun DESC
    """)
    query = """
        SELECT DISTINCT YEAR(tglfaktur) AS tahun
        FROM barang_keluar
    """
    filters = []
    params = []

    if tahun:
        filters.append("YEAR(tglfaktur) = %s")
        params.append(tahun)
    if filters:
        query += " WHERE " + " AND ".join(filters)
    query += " ORDER BY tahun DESC"
    thn = fetch(query,params)
    # Ambil daftar nama sales
    nama_sales = fetch("""
        SELECT DISTINCT nama_sales 
        FROM detail_sales
        INNER JOIN sales ON sales.id = detail_sales.id_sales
        INNER JOIN outlet ON outlet.id = detail_sales.id_outlet
    """)

    # Struktur data untuk hasil akhir
    data_fix = []

    # Iterasi berdasarkan tahun
    for h in thn:
        tahun = h['tahun']
        for sales in info_list:
            # Filter data barang keluar untuk sales tertentu dan tahun tertentu
            sales_data = [item for item in data_barang_keluar if item['id_sales'] == sales['id'] and item['tahun'] == tahun]

            # Inisialisasi item untuk setiap sales
            item = {
                "tahun": tahun,
                "id_sales": sales['id'],
                "nama_sales": sales['nama_sales'],
                "nama_outlet": sales['nama_outlet'],
                "M1": 0, "M2": 0, "M3": 0, "M4": 0, "M5": 0, "M6": 0,
                "M7": 0, "M8": 0, "M9": 0, "M10": 0, "M11": 0, "M12": 0,
                "total_sales": 0
            }

            # Hitung performa sales per bulan
            for data in sales_data:
                bulan = data['bulan']
                performa_sales = data['performa_sales'] or 0
                item[f"M{bulan}"] += performa_sales
                item["total_sales"] += performa_sales

            # Tambahkan item ke hasil akhir
            data_fix.append(item)

    # Hitung total footer per tahun
    footer_totals = {}
    for h in thn:
        tahun = h['tahun']
        totals = {
            "M1": 0, "M2": 0, "M3": 0, "M4": 0, "M5": 0, "M6": 0,
            "M7": 0, "M8": 0, "M9": 0, "M10": 0, "M11": 0, "M12": 0,
            "total_sales": 0
        }
        for i in range(1, 13):
                sales_data = [item for item in data_fix if item['tahun'] == tahun]
                for data in sales_data:
                    performa_sales = data[f"M{i}"] or 0
                    totals[f"M{i}"] += performa_sales
                    totals["total_sales"] += performa_sales
        footer_totals[tahun] = totals
    # Kirim data ke template
    return render_template(
        "admin/performa_sales.html",
        data_fix=data_fix,
        list_tahun=list_tahun,
        tahun = thn,
        nama_sales=nama_sales,
        footer_totals=footer_totals
    )


@app.route('/admin/latest_penerimaan', methods=['GET'])
def latest_penerimaan_excell():
    wb = Workbook()
    ws = wb.active
    ws.title = "Laporan Bulanan"

    bulan_sekarang = datetime.now().month
    tahun_ini = datetime.now().year
    current_row = 1

    # Judul umum (tetap di luar perulangan)
    ws.merge_cells(f'A{current_row}:K{current_row}')
    ws[f'A{current_row}'] = "LAPORAN BULANAN PERUSAHAAN"
    ws[f'A{current_row}'].font = Font(size=14, bold=True)
    ws[f'A{current_row}'].alignment = Alignment(horizontal="center")
    current_row += 2

    # Perulangan dari bulan 1 sampai bulan sekarang
    for bulan in range(1, bulan_sekarang + 1):
        nama_bulan = next((b['nama_bulan'] for b in list_bulan if b['value'] == str(bulan)), "Bulan Tidak Diketahui")

        # Judul bulan
        ws.merge_cells(f'A{current_row}:K{current_row}')
        ws[f'A{current_row}'] = f"{nama_bulan} - {tahun_ini}"
        ws[f'A{current_row}'].alignment = Alignment(horizontal="center")
        ws[f'A{current_row}'].font = Font(bold=True)
        current_row += 1

        # Header tabel
        headers = [
            "TANGGAL FAKTUR",
            "NOMOR FAKTUR",
            "PRINCIPLE/SUPPLIER",
            "NAMA BARANG",
            "KODE BARANG",
            "QUANTITY",
            "JUMLAH PENERIMAAN",
            "HARGA SATUAN",
            "HARGA TOTAL",
            "LUNAS / TIDAK LUNAS",
            "PERFORMA BELANJA"
        ]
        ws.append(headers)
        for cell in ws[current_row]:
            cell.font = Font(bold=True)
        current_row += 1

        # Ambil data dari database per bulan
        hasil = fetch("""
            SELECT
                bm.tglfaktur,
                bm.nofaktur,
                s.nama_supplier AS supplier,
                b.nama_barang,
                b.kode_barang,
                b.qty,
                dbm.jml_menerima AS jumlah_penerimaan,
                dbm.harga_satuan,
                dbm.harga_total,
                dbm.lunastidak
            FROM
                barang_masuk bm 
            INNER JOIN pabrik s on s.id = bm.id_supplier
            INNER JOIN detail_barang_masuk dbm on dbm.id_barang_masuk = bm.id
            INNER JOIN barang b on b.id = dbm.id_barang
            WHERE
                YEAR(bm.tglfaktur) = %s AND MONTH(bm.tglfaktur) = %s;
        """, (tahun_ini, bulan))

        performa_belanja = 0
        belum_lunas = 0

        for row in hasil:
            if row['lunastidak'] == "Lunas":
                performa_belanja += row['harga_total']
            elif row['lunastidak'] == "Tidak Lunas":
                belum_lunas += row['harga_total']

        for row in hasil:
            ws.append([
                row['tglfaktur'].strftime("%Y-%m-%d") if row['tglfaktur'] else '',
                row['nofaktur'],
                row['supplier'],
                row['nama_barang'],
                row['kode_barang'],
                row['qty'],
                row['jumlah_penerimaan'],
                row['harga_satuan'],
                row['harga_total'],
                row['lunastidak'],
                ''  # kolom performa nanti digabung di bawah
            ])
            current_row += 1

        if hasil:
            baris_awal = current_row - len(hasil)
            baris_akhir = current_row - 1
            ws.merge_cells(f'K{baris_awal}:K{baris_akhir}')
            ws[f'K{baris_awal}'] = performa_belanja
            ws[f'K{baris_awal}'].alignment = Alignment(horizontal='center', vertical='center')

        current_row += 2  # Spasi sebelum bulan berikutnya

    # Otomatis lebar kolom
    for i, col in enumerate(ws.columns, 1):
        max_length = 0
        col_letter = get_column_letter(i)
        for cell in col:
            if cell.value:
                max_length = max(max_length, len(str(cell.value)))
        ws.column_dimensions[col_letter].width = max_length + 2

    # Outputkan ke buffer
    buffer = BytesIO()
    wb.save(buffer)
    buffer.seek(0)

    return send_file(
        buffer,
        as_attachment=True,
        download_name="REPORT PENERIMAAN.xlsx",
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )

@app.route('/admin/latest_pengeluaran', methods=['GET'])
def latest_pengeluaran_excell():
    wb = Workbook()
    ws = wb.active
    ws.title = "Laporan Bulanan"

    bulan_sekarang = datetime.now().month
    tahun_ini = datetime.now().year
    current_row = 1

    # Judul umum
    ws.merge_cells(f'A{current_row}:L{current_row}')
    ws[f'A{current_row}'] = "LAPORAN BULANAN PERUSAHAAN"
    ws[f'A{current_row}'].font = Font(size=14, bold=True)
    ws[f'A{current_row}'].alignment = Alignment(horizontal="center")
    current_row += 2

    for bulan in range(1, bulan_sekarang + 1):
        bulan_str = str(bulan)
        nama_bulan = next((b['nama_bulan'] for b in list_bulan if b['value'] == bulan_str), "Bulan Tidak Diketahui")

        # Judul bulan
        ws.merge_cells(f'A{current_row}:L{current_row}')
        ws[f'A{current_row}'] = f"{nama_bulan} - {tahun_ini}"
        ws[f'A{current_row}'].alignment = Alignment(horizontal="center")
        ws[f'A{current_row}'].font = Font(bold=True)
        current_row += 1

        # Header
        headers = [
            "TANGGAL FAKTUR",
            "JATUH TEMPO",
            "NOMOR FAKTUR",
            "SALES",
            "NAMA OUTLET",
            "NAMA BARANG",
            "QUANTITY",
            "JUMLAH PERMINTAAN",
            "HARGA SATUAN",
            "HARGA TOTAL",
            "LUNAS / TIDAK LUNAS",
            "PERFORMA SALES"
        ]
        ws.append(headers)
        for cell in ws[current_row]:
            cell.font = Font(bold=True)
        current_row += 1

        # Ambil data dari database
        hasil = fetch("""
            SELECT
                bk.tglfaktur,
                bk.jatuhtempo,
                bk.nomerfaktur,
                s.nama_sales,
                o.nama_outlet,
                b.nama_barang,
                b.qty,
                dbk.jmlpermintaan,
                dbk.harga_satuan,
                dbk.harga_total,
                dbk.lunas_or_no
            FROM
                barang_keluar bk
            INNER JOIN detail_sales ds on ds.id = bk.id_sales
            INNER JOIN sales s on s.id = ds.id_sales
            INNER JOIN outlet o on o.id = ds.id_outlet
            INNER JOIN detail_barang_keluar dbk on dbk.id_barang_keluar = bk.id
            INNER JOIN barang b on b.id = dbk.id_barang
            WHERE
                YEAR(bk.tglfaktur) = %s AND MONTH(bk.tglfaktur) = %s;
        """, (tahun_ini, bulan))
        performa_sales = sum(row['harga_total'] for row in hasil if row['lunas_or_no'] == "Lunas")

        # Tulis data
        for idx, row in enumerate(hasil, start=1):
            kolom_performa = performa_sales if idx == 1 else ''
            ws.append([
                row['tglfaktur'].strftime("%Y-%m-%d") if row['tglfaktur'] else '',
                row['jatuhtempo'],
                row['nomerfaktur'],
                row['nama_sales'],
                row['nama_outlet'],
                row['nama_barang'],
                row['qty'],
                row['jmlpermintaan'],
                row['harga_satuan'],
                row['harga_total'],
                row['lunas_or_no'],
                kolom_performa
            ])
            current_row += 1

        if hasil:
            baris_awal = current_row - len(hasil)
            baris_akhir = current_row - 1
            ws.merge_cells(f'L{baris_awal}:L{baris_akhir}')
            ws[f'L{baris_awal}'] = performa_sales
            ws[f'L{baris_awal}'].alignment = Alignment(horizontal='center', vertical='center')

        current_row += 2  # Spasi sebelum bulan berikutnya

    # Otomatis lebar kolom
    for i, col in enumerate(ws.columns, 1):
        max_length = 0
        col_letter = get_column_letter(i)
        for cell in col:
            if cell.value:
                max_length = max(max_length, len(str(cell.value)))
        ws.column_dimensions[col_letter].width = max_length + 2

    # Outputkan ke buffer
    buffer = BytesIO()
    wb.save(buffer)
    buffer.seek(0)

    return send_file(
        buffer,
        as_attachment=True,
        download_name="REPORT PENGELUARAN.xlsx",
        mimetype='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'
    )