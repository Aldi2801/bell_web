import random

id_ampu = 3
data_template = [
    ('UH', '2025-05-01'), ('UH', '2025-05-07'), ('UH', '2025-05-14'),
    ('UH', '2025-05-21'), ('UH', '2025-05-28'), ('Tugas', '2025-05-01'),
    ('Tugas', '2025-05-07'), ('Tugas', '2025-05-14'), ('Tugas', '2025-05-21'),
    ('Tugas', '2025-05-28'), ('Tugas', '2025-05-05'), ('Tugas', '2025-05-11'),
    ('Tugas', '2025-05-18'), ('Tugas', '2025-05-25'), ('Tugas', '2025-05-30'),
    ('UTS', '2025-04-18'), ('UAS', '2025-06-25')
]

nis_range = range(20001, 20081)

with open("generate_penilaian.sql", "w") as f:
    for nis in nis_range:
        for jenis_penilaian, tanggal in data_template:
            nilai = round(random.uniform(65, 90), 2)
            sql = f"INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES ({nis}, {id_ampu}, '{jenis_penilaian}', {nilai}, '{tanggal}');"
            f.write(sql + "\n")

print("SQL file generated: generate_penilaian.sql")
