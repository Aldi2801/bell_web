import random
from datetime import date, timedelta

# Data referensi dari user
nis_list = [20001, 20002, 20003, 20004, 20005, 20006, 20007, 20008, 20009, 20010,
20011, 20012, 20013, 20014, 20015, 20016, 20017, 20018, 20019, 20020,
20021, 20022, 20023, 20024, 20025, 20026, 20027, 20028, 20029, 20030,
20031, 20032, 20033, 20034, 20035, 20036, 20037, 20038, 20039, 20040,
20041, 20042, 20043, 20044, 20045, 20046, 20047, 20048, 20049]
kelas_list = ['7a', '7b', '7c', '8a', '8b', '8c', '9a', '9b', '9c']
tahun_akademik_list = ['1', '2', '3','4','5','6']
nip_list = [
    '197901172020041006',
    '198005122020041001',
    '198411102020041004',
    '198606052020041007',
    '198208202020042002',
    '198304072020042005',
    '198502152020042003',
    '199012302020042008',
]
mapel_list = ['MTK', 'IPA', 'BI', 'ENG', 'IPS']

id_pembagian_pool = list(range(2, 152))  # 150 pembagian_kelas

ampu_mapel_data = []
nip_counter = 0  # biar looping nip dari awal sampai akhir terus diulang

for i in range(1, 151):  # 1 - 150
    id_ampu = i
    tanggal = date(2021 + (i % 3), 7, 1)
    id_semester = random.choice(['1', '2'])
    id_mapel = random.choice(mapel_list)

    nip = nip_list[nip_counter]
    nip_counter = (nip_counter + 1) % len(nip_list)

    id_tahun_akademik = random.choice(tahun_akademik_list)

    # Ambil satu id_pembagian unik
    id_pembagian = id_pembagian_pool.pop(random.randint(0, len(id_pembagian_pool) - 1))

    ampu_mapel_data.append((id_ampu, tanggal.isoformat(), id_semester, id_mapel, nip, id_tahun_akademik, id_pembagian))

# Generate kbm
kbm_data = []
kbm_id_counter = 1
for ampu in ampu_mapel_data:
    id_ampu = ampu[0]
    base_date = date(2021, 7, 1)
    for j in range(3):  # 3 sesi per mapel
        kbm_data.append((
            kbm_id_counter,
            (base_date + timedelta(days=j * 7)).isoformat(),
            f"Materi {ampu[3]} {j+1}",
            f"Sub Materi {ampu[3]} {j+1}",
            id_ampu
        ))
        kbm_id_counter += 1

# Generate kehadiran
keterangan_list = [0, 1, 2, 3]  # Hadir, Sakit, Izin, Alpha
kehadiran_data = []
kehadiran_id = 1
for kbm in kbm_data:
    for _ in range(2):  # 2 siswa hadir per sesi KBM
        kehadiran_data.append((
            kehadiran_id,
            random.choice(keterangan_list),
            kbm[0],
            random.choice(nis_list)
        ))
        kehadiran_id += 1

# Buat SQL query
def make_insert_sql(table, columns, rows):
    values_str = ",\n".join(["({})".format(", ".join(repr(v) for v in row)) for row in rows])
    return f"INSERT INTO `{table}` ({', '.join(columns)}) VALUES\n{values_str};"

sql_ampu = make_insert_sql("ampu_mapel", 
    ['id_ampu', 'tanggal', 'id_semester', 'id_mapel', 'nip', 'id_tahun_akademik', 'id_pembagian'],
    ampu_mapel_data)

sql_kbm = make_insert_sql("kbm", 
    ['id_kbm', 'tanggal', 'materi', 'sub_materi', 'id_ampu'],
    kbm_data)

sql_kehadiran = make_insert_sql("kehadiran", 
    ['id_kehadiran', 'id_keterangan', 'id_kbm', 'nis'],
    kehadiran_data)

print(sql_ampu)  # Preview agar tidak terlalu panjang
print(sql_kbm)  # Preview agar tidak terlalu panjang
print(sql_kehadiran)  # Preview agar tidak terlalu panjang
