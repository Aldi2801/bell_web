# Generate SQL seeder template for all siswa into multiple tables
import random
from datetime import datetime, timedelta

# Constants
siswa_nis_list = list(range(20001, 20001 + 51))  # 51 siswa
tagihan_id_start = 1001
ampu_id = 1
kbm_id = 1
id_tahun_akademik = '2024'
semester = 'G1'
kelas = '7A'
guru_nip = '1987654321'
id_keterangan = 'H'

seeder_sql = []

# Dummy entries for dependent tables (optional)
seeder_sql.append("-- Tambahan jika belum ada data referensi\n")
seeder_sql.append("INSERT IGNORE INTO semester (id_semester, semester) VALUES ('G1', 'Ganjil');")
seeder_sql.append("INSERT IGNORE INTO tahun_akademik (id_tahun_akademik, tahun_akademik) VALUES ('2024', '2024/2025');")
seeder_sql.append("INSERT IGNORE INTO mapel (id_mapel, nama_mapel) VALUES ('MAT', 'Matematika');")
seeder_sql.append("INSERT IGNORE INTO guru (nip, nama) VALUES ('1987654321', 'Pak Guru');")
seeder_sql.append("INSERT IGNORE INTO kelas (id_kelas, nama_kelas) VALUES ('7A', '7A');")
seeder_sql.append("INSERT IGNORE INTO keterangan (id_keterangan, keterangan) VALUES ('H', 'Hadir');")
seeder_sql.append("\n-- Seeder Data\n")

# Seeder: AmpuMapel dan KBM (1 saja untuk dipakai semuanya)
seeder_sql.append("INSERT INTO ampu_mapel (id_ampu, tanggal, id_semester, id_mapel, nip, id_tahun_akademik) VALUES\n"
                  f"({ampu_id}, '{datetime.now().date()}', '{semester}', 'MAT', '{guru_nip}', '{id_tahun_akademik}');")

seeder_sql.append("INSERT INTO kbm (id_kbm, tanggal, materi, sub_materi, id_ampu) VALUES\n"
                  f"({kbm_id}, '{datetime.now().date()}', 'Persamaan Linear', 'Pengenalan PLDV', {ampu_id});")

# Seeder untuk setiap siswa
for i, nis in enumerate(siswa_nis_list, start=1):
    pembagian_id = 1000 + i
    tagihan_id = tagihan_id_start + i
    tagihan_total = random.randint(500000, 1000000)
    nilai = round(random.uniform(65, 100), 2)
    tanggal = datetime.now().date() - timedelta(days=random.randint(0, 30))

    seeder_sql.append(f"\n-- Siswa NIS: {nis}")

    # Pembagian Kelas
    seeder_sql.append(f"INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES "
                      f"({pembagian_id}, '{tanggal}', {nis}, '{kelas}', '{id_tahun_akademik}', '{guru_nip}');")

    # Kehadiran
    seeder_sql.append(f"INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES "
                      f"('{id_keterangan}', {kbm_id}, {nis});")

    # Penilaian
    seeder_sql.append(f"INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES "
                      f"({nis}, {ampu_id}, 'UH', {nilai}, '{tanggal}');")

    # Tagihan
    seeder_sql.append(f"INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES "
                      f"({tagihan_id}, (SELECT user_id FROM siswa WHERE nis = {nis}), 'Ganjil', '2024/2025', 'SPP Bulanan', {tagihan_total}, '{tanggal}');")

    # Transaksi
    seeder_sql.append(f"INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES "
                      f"('ORD{nis}', {tagihan_id}, {nis}, CONCAT('siswa{nis}@mail.com'), {tagihan_total}, 'settlement', NULL, '{tanggal}');")

# Gabungkan semua
full_sql = '\n'.join(seeder_sql)
full_sql[:1000]  # Preview first 1000 characters only

# Save the full generated SQL into a file
output_path = "./seeder2.sql"

with open(output_path, "w") as f:
    f.write(full_sql)

output_path
