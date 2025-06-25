-- Tambahan jika belum ada data referensi

INSERT IGNORE INTO semester (id_semester, semester) VALUES (0, 'Genap');
INSERT IGNORE INTO tahun_akademik (id_tahun_akademik, tahun_akademik) VALUES (6, '2024/2025');
INSERT IGNORE INTO mapel (id_mapel, nama_mapel) VALUES ('MAT', 'Matematika');
INSERT IGNORE INTO guru (nip, nama) VALUES ('198005122020041001', 'Pak Guru');
INSERT IGNORE INTO kelas (id_kelas, nama_kelas) VALUES ('7a', '7A');
INSERT IGNORE INTO keterangan (id_keterangan, keterangan) VALUES ('H', 'Hadir');

-- Seeder Data

INSERT INTO ampu_mapel (id_ampu, tanggal, id_semester, id_mapel, nip, id_tahun_akademik) VALUES
(3, '2025-06-25', 0, 'MTK', '198005122020041001', 6);
INSERT INTO kbm (id_kbm, tanggal, materi, sub_materi, id_ampu) VALUES
(5, '2025-06-25', 'Persamaan Linear', 'Pengenalan PLDV', 3);

-- Siswa NIS: 20001
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1001, '2025-05-29', 20001, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20001);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 71.94, '2025-05-29');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1002, (SELECT user_id FROM siswa WHERE nis = 20001), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-05-29');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20001', 1002, 20001, (SELECT email FROM user WHERE nis = 20001), 100000, 'settlement', NULL, '2025-05-29');

-- Siswa NIS: 20002
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1002, '2025-06-01', 20002, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20002);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 93.7, '2025-06-01');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1003, (SELECT user_id FROM siswa WHERE nis = 20002), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-01');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20002', 1003, 20002, (SELECT email FROM user WHERE nis = 20002), 100000, 'settlement', NULL, '2025-06-01');

-- Siswa NIS: 20003
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1003, '2025-06-05', 20003, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20003);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 71.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1004, (SELECT user_id FROM siswa WHERE nis = 20003), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20003', 1004, 20003, (SELECT email FROM user WHERE nis = 20003), 100000, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20004
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1004, '2025-06-14', 20004, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20004);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 94.04, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1005, (SELECT user_id FROM siswa WHERE nis = 20004), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20004', 1005, 20004, (SELECT email FROM user WHERE nis = 20004), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20005
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1005, '2025-06-21', 20005, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20005);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 79.14, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1006, (SELECT user_id FROM siswa WHERE nis = 20005), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20005', 1006, 20005, (SELECT email FROM user WHERE nis = 20005), 100000, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20006
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1006, '2025-06-14', 20006, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20006);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 87.71, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1007, (SELECT user_id FROM siswa WHERE nis = 20006), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20006', 1007, 20006, (SELECT email FROM user WHERE nis = 20006), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20007
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1007, '2025-06-14', 20007, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20007);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 70.02, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1008, (SELECT user_id FROM siswa WHERE nis = 20007), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20007', 1008, 20007, (SELECT email FROM user WHERE nis = 20007), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20008
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1008, '2025-06-14', 20008, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20008);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 95.98, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1009, (SELECT user_id FROM siswa WHERE nis = 20008), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20008', 1009, 20008, (SELECT email FROM user WHERE nis = 20008), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20009
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1009, '2025-05-28', 20009, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20009);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 72.9, '2025-05-28');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1010, (SELECT user_id FROM siswa WHERE nis = 20009), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-05-28');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20009', 1010, 20009, (SELECT email FROM user WHERE nis = 20009), 100000, 'settlement', NULL, '2025-05-28');

-- Siswa NIS: 20010
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1010, '2025-06-11', 20010, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20010);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 79.17, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1011, (SELECT user_id FROM siswa WHERE nis = 20010), 'Ganjil', '2024/2025', 'SPP Bulanan', 835294, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20010', 1011, 20010, (SELECT email FROM user WHERE nis = 20010), 835294, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20011
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1011, '2025-05-31', 20011, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20011);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 83.87, '2025-05-31');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1012, (SELECT user_id FROM siswa WHERE nis = 20011), 'Ganjil', '2024/2025', 'SPP Bulanan', 532237, '2025-05-31');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20011', 1012, 20011, (SELECT email FROM user WHERE nis = 20011), 532237, 'settlement', NULL, '2025-05-31');

-- Siswa NIS: 20012
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1012, '2025-06-20', 20012, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20012);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 65.13, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1013, (SELECT user_id FROM siswa WHERE nis = 20012), 'Ganjil', '2024/2025', 'SPP Bulanan', 620692, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20012', 1013, 20012, (SELECT email FROM user WHERE nis = 20012), 620692, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20013
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1013, '2025-06-24', 20013, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20013);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 82.66, '2025-06-24');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1014, (SELECT user_id FROM siswa WHERE nis = 20013), 'Ganjil', '2024/2025', 'SPP Bulanan', 985109, '2025-06-24');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20013', 1014, 20013, (SELECT email FROM user WHERE nis = 20013), 985109, 'settlement', NULL, '2025-06-24');

-- Siswa NIS: 20014
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1014, '2025-06-10', 20014, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20014);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 95.62, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1015, (SELECT user_id FROM siswa WHERE nis = 20014), 'Ganjil', '2024/2025', 'SPP Bulanan', 738238, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20014', 1015, 20014, (SELECT email FROM user WHERE nis = 20014), 738238, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20015
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1015, '2025-06-16', 20015, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20015);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 78.25, '2025-06-16');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1016, (SELECT user_id FROM siswa WHERE nis = 20015), 'Ganjil', '2024/2025', 'SPP Bulanan', 632353, '2025-06-16');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20015', 1016, 20015, (SELECT email FROM user WHERE nis = 20015), 632353, 'settlement', NULL, '2025-06-16');

-- Siswa NIS: 20016
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1016, '2025-06-05', 20016, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20016);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 69.66, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1017, (SELECT user_id FROM siswa WHERE nis = 20016), 'Ganjil', '2024/2025', 'SPP Bulanan', 592007, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20016', 1017, 20016, (SELECT email FROM user WHERE nis = 20016), 592007, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20017
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1017, '2025-06-15', 20017, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20017);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 92.83, '2025-06-15');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1018, (SELECT user_id FROM siswa WHERE nis = 20017), 'Ganjil', '2024/2025', 'SPP Bulanan', 840817, '2025-06-15');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20017', 1018, 20017, (SELECT email FROM user WHERE nis = 20017), 840817, 'settlement', NULL, '2025-06-15');

-- Siswa NIS: 20018
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1018, '2025-06-19', 20018, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20018);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 73.83, '2025-06-19');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1019, (SELECT user_id FROM siswa WHERE nis = 20018), 'Ganjil', '2024/2025', 'SPP Bulanan', 548955, '2025-06-19');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20018', 1019, 20018, (SELECT email FROM user WHERE nis = 20018), 548955, 'settlement', NULL, '2025-06-19');

-- Siswa NIS: 20019
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1019, '2025-06-07', 20019, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20019);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 76.09, '2025-06-07');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1020, (SELECT user_id FROM siswa WHERE nis = 20019), 'Ganjil', '2024/2025', 'SPP Bulanan', 842354, '2025-06-07');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20019', 1020, 20019, (SELECT email FROM user WHERE nis = 20019), 842354, 'settlement', NULL, '2025-06-07');

-- Siswa NIS: 20020
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1020, '2025-06-13', 20020, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20020);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 93.85, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1021, (SELECT user_id FROM siswa WHERE nis = 20020), 'Ganjil', '2024/2025', 'SPP Bulanan', 716834, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20020', 1021, 20020, (SELECT email FROM user WHERE nis = 20020), 716834, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20021
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1021, '2025-06-03', 20021, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20021);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 68.44, '2025-06-03');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1022, (SELECT user_id FROM siswa WHERE nis = 20021), 'Ganjil', '2024/2025', 'SPP Bulanan', 835974, '2025-06-03');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20021', 1022, 20021, (SELECT email FROM user WHERE nis = 20021), 835974, 'settlement', NULL, '2025-06-03');

-- Siswa NIS: 20022
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1022, '2025-06-11', 20022, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20022);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 84.46, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1023, (SELECT user_id FROM siswa WHERE nis = 20022), 'Ganjil', '2024/2025', 'SPP Bulanan', 556549, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20022', 1023, 20022, (SELECT email FROM user WHERE nis = 20022), 556549, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20023
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1023, '2025-05-31', 20023, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20023);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 81.26, '2025-05-31');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1024, (SELECT user_id FROM siswa WHERE nis = 20023), 'Ganjil', '2024/2025', 'SPP Bulanan', 817799, '2025-05-31');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20023', 1024, 20023, (SELECT email FROM user WHERE nis = 20023), 817799, 'settlement', NULL, '2025-05-31');

-- Siswa NIS: 20024
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1024, '2025-06-15', 20024, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20024);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 68.22, '2025-06-15');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1025, (SELECT user_id FROM siswa WHERE nis = 20024), 'Ganjil', '2024/2025', 'SPP Bulanan', 546778, '2025-06-15');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20024', 1025, 20024, (SELECT email FROM user WHERE nis = 20024), 546778, 'settlement', NULL, '2025-06-15');

-- Siswa NIS: 20025
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1025, '2025-06-12', 20025, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20025);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 81.63, '2025-06-12');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1026, (SELECT user_id FROM siswa WHERE nis = 20025), 'Ganjil', '2024/2025', 'SPP Bulanan', 601586, '2025-06-12');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20025', 1026, 20025, (SELECT email FROM user WHERE nis = 20025), 601586, 'settlement', NULL, '2025-06-12');

-- Siswa NIS: 20026
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1026, '2025-06-17', 20026, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20026);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 74.48, '2025-06-17');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1027, (SELECT user_id FROM siswa WHERE nis = 20026), 'Ganjil', '2024/2025', 'SPP Bulanan', 982130, '2025-06-17');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20026', 1027, 20026, (SELECT email FROM user WHERE nis = 20026), 982130, 'settlement', NULL, '2025-06-17');

-- Siswa NIS: 20027
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1027, '2025-06-02', 20027, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20027);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 77.38, '2025-06-02');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1028, (SELECT user_id FROM siswa WHERE nis = 20027), 'Ganjil', '2024/2025', 'SPP Bulanan', 509311, '2025-06-02');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20027', 1028, 20027, (SELECT email FROM user WHERE nis = 20027), 509311, 'settlement', NULL, '2025-06-02');

-- Siswa NIS: 20028
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1028, '2025-05-27', 20028, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20028);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 75.87, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1029, (SELECT user_id FROM siswa WHERE nis = 20028), 'Ganjil', '2024/2025', 'SPP Bulanan', 850290, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20028', 1029, 20028, (SELECT email FROM user WHERE nis = 20028), 850290, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20029
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1029, '2025-06-23', 20029, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20029);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 91.61, '2025-06-23');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1030, (SELECT user_id FROM siswa WHERE nis = 20029), 'Ganjil', '2024/2025', 'SPP Bulanan', 681729, '2025-06-23');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20029', 1030, 20029, (SELECT email FROM user WHERE nis = 20029), 681729, 'settlement', NULL, '2025-06-23');

-- Siswa NIS: 20030
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1030, '2025-06-25', 20030, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20030);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 66.97, '2025-06-25');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1031, (SELECT user_id FROM siswa WHERE nis = 20030), 'Ganjil', '2024/2025', 'SPP Bulanan', 751238, '2025-06-25');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20030', 1031, 20030, (SELECT email FROM user WHERE nis = 20030), 751238, 'settlement', NULL, '2025-06-25');

-- Siswa NIS: 20031
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1031, '2025-06-23', 20031, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20031);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 71.83, '2025-06-23');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1032, (SELECT user_id FROM siswa WHERE nis = 20031), 'Ganjil', '2024/2025', 'SPP Bulanan', 804530, '2025-06-23');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20031', 1032, 20031, (SELECT email FROM user WHERE nis = 20031), 804530, 'settlement', NULL, '2025-06-23');

-- Siswa NIS: 20032
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1032, '2025-06-17', 20032, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20032);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 66.17, '2025-06-17');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1033, (SELECT user_id FROM siswa WHERE nis = 20032), 'Ganjil', '2024/2025', 'SPP Bulanan', 668053, '2025-06-17');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20032', 1033, 20032, (SELECT email FROM user WHERE nis = 20032), 668053, 'settlement', NULL, '2025-06-17');

-- Siswa NIS: 20033
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1033, '2025-06-04', 20033, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20033);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 66.72, '2025-06-04');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1034, (SELECT user_id FROM siswa WHERE nis = 20033), 'Ganjil', '2024/2025', 'SPP Bulanan', 910251, '2025-06-04');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20033', 1034, 20033, (SELECT email FROM user WHERE nis = 20033), 910251, 'settlement', NULL, '2025-06-04');

-- Siswa NIS: 20034
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1034, '2025-06-14', 20034, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20034);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 98.78, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1035, (SELECT user_id FROM siswa WHERE nis = 20034), 'Ganjil', '2024/2025', 'SPP Bulanan', 595942, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20034', 1035, 20034, (SELECT email FROM user WHERE nis = 20034), 595942, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20035
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1035, '2025-06-03', 20035, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20035);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 85.33, '2025-06-03');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1036, (SELECT user_id FROM siswa WHERE nis = 20035), 'Ganjil', '2024/2025', 'SPP Bulanan', 964112, '2025-06-03');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20035', 1036, 20035, (SELECT email FROM user WHERE nis = 20035), 964112, 'settlement', NULL, '2025-06-03');

-- Siswa NIS: 20036
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1036, '2025-05-27', 20036, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20036);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 66.22, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1037, (SELECT user_id FROM siswa WHERE nis = 20036), 'Ganjil', '2024/2025', 'SPP Bulanan', 644343, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20036', 1037, 20036, (SELECT email FROM user WHERE nis = 20036), 644343, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20037
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1037, '2025-06-23', 20037, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20037);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 79.25, '2025-06-23');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1038, (SELECT user_id FROM siswa WHERE nis = 20037), 'Ganjil', '2024/2025', 'SPP Bulanan', 737370, '2025-06-23');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20037', 1038, 20037, (SELECT email FROM user WHERE nis = 20037), 737370, 'settlement', NULL, '2025-06-23');

-- Siswa NIS: 20038
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1038, '2025-06-15', 20038, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20038);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 95.65, '2025-06-15');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1039, (SELECT user_id FROM siswa WHERE nis = 20038), 'Ganjil', '2024/2025', 'SPP Bulanan', 720844, '2025-06-15');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20038', 1039, 20038, (SELECT email FROM user WHERE nis = 20038), 720844, 'settlement', NULL, '2025-06-15');

-- Siswa NIS: 20039
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1039, '2025-06-09', 20039, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20039);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 73.07, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1040, (SELECT user_id FROM siswa WHERE nis = 20039), 'Ganjil', '2024/2025', 'SPP Bulanan', 550330, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20039', 1040, 20039, (SELECT email FROM user WHERE nis = 20039), 550330, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20040
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1040, '2025-06-20', 20040, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20040);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 88.18, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1041, (SELECT user_id FROM siswa WHERE nis = 20040), 'Ganjil', '2024/2025', 'SPP Bulanan', 945391, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20040', 1041, 20040, (SELECT email FROM user WHERE nis = 20040), 945391, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20041
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1041, '2025-05-29', 20041, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20041);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 86.94, '2025-05-29');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1042, (SELECT user_id FROM siswa WHERE nis = 20041), 'Ganjil', '2024/2025', 'SPP Bulanan', 982524, '2025-05-29');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20041', 1042, 20041, (SELECT email FROM user WHERE nis = 20041), 982524, 'settlement', NULL, '2025-05-29');

-- Siswa NIS: 20042
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1042, '2025-06-09', 20042, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20042);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1043, (SELECT user_id FROM siswa WHERE nis = 20042), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20042', 1043, 20042, (SELECT email FROM user WHERE nis = 20042), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20043
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1043, '2025-06-05', 20043, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20043);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1044, (SELECT user_id FROM siswa WHERE nis = 20043), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20043', 1044, 20043, (SELECT email FROM user WHERE nis = 20043), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20044
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1044, '2025-05-27', 20044, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20044);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1045, (SELECT user_id FROM siswa WHERE nis = 20044), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20044', 1045, 20044, (SELECT email FROM user WHERE nis = 20044), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20045
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1045, '2025-06-11', 20045, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20045);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1046, (SELECT user_id FROM siswa WHERE nis = 20045), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20045', 1046, 20045, (SELECT email FROM user WHERE nis = 20045), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20046
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1046, '2025-06-21', 20046, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20046);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1047, (SELECT user_id FROM siswa WHERE nis = 20046), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20046', 1047, 20046, (SELECT email FROM user WHERE nis = 20046), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20047
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1047, '2025-06-20', 20047, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20047);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1048, (SELECT user_id FROM siswa WHERE nis = 20047), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20047', 1048, 20047, (SELECT email FROM user WHERE nis = 20047), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20048
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1048, '2025-06-13', 20048, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20048);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1049, (SELECT user_id FROM siswa WHERE nis = 20048), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20048', 1049, 20048, (SELECT email FROM user WHERE nis = 20048), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20049
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1049, '2025-06-10', 20049, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20049);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1050, (SELECT user_id FROM siswa WHERE nis = 20049), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20049', 1050, 20049, (SELECT email FROM user WHERE nis = 20049), 623384, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20050
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1050, '2025-06-21', 20050, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20050);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 66.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1051, (SELECT user_id FROM siswa WHERE nis = 20050), 'Ganjil', '2024/2025', 'SPP Bulanan', 858372, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20050', 1051, 20050, (SELECT email FROM user WHERE nis = 20050), 858372, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20051
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1051, '2025-06-09', 20051, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20051);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 76.31, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1052, (SELECT user_id FROM siswa WHERE nis = 20051), 'Ganjil', '2024/2025', 'SPP Bulanan', 638958, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20051', 1052, 20051, (SELECT email FROM user WHERE nis = 20051), 638958, 'settlement', NULL, '2025-06-09');


-- Siswa NIS: 20052
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1052, '2025-06-09', 20052, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20052);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1053, (SELECT user_id FROM siswa WHERE nis = 20052), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20042', 1053, 20052, (SELECT email FROM user WHERE nis = 20052), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20053
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1053, '2025-06-05', 20053, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20053);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1054, (SELECT user_id FROM siswa WHERE nis = 20053), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20053', 1054, 20053, (SELECT email FROM user WHERE nis = 20053), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20054
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1054, '2025-05-27', 20054, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20054);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1055, (SELECT user_id FROM siswa WHERE nis = 20054), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20054', 1055, 20054, (SELECT email FROM user WHERE nis = 20054), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20055
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1055, '2025-06-11', 20055, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20055);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1056, (SELECT user_id FROM siswa WHERE nis = 20055), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20055', 1056, 20055, (SELECT email FROM user WHERE nis = 20055), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20056
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1056, '2025-06-21', 20056, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20056);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1057, (SELECT user_id FROM siswa WHERE nis = 20056), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20056', 1057, 20056, (SELECT email FROM user WHERE nis = 20056), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20057
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1057, '2025-06-20', 20057, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20057);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1058, (SELECT user_id FROM siswa WHERE nis = 20057), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20057', 1058, 20057, (SELECT email FROM user WHERE nis = 20057), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20058
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1058, '2025-06-13', 20058, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20058);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1059, (SELECT user_id FROM siswa WHERE nis = 20058), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20058', 1059, 20058, (SELECT email FROM user WHERE nis = 20058), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20059
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1059, '2025-06-10', 20059, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20059);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1060, (SELECT user_id FROM siswa WHERE nis = 20059), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20059', 1060, 20059, (SELECT email FROM user WHERE nis = 20059), 623384, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20060
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1060, '2025-06-21', 20060, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20060);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 66.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1061, (SELECT user_id FROM siswa WHERE nis = 20060), 'Ganjil', '2024/2025', 'SPP Bulanan', 858372, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20060', 1061, 20060, (SELECT email FROM user WHERE nis = 20060), 858372, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20061
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1061, '2025-06-09', 20061, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20061);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 76.31, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1062, (SELECT user_id FROM siswa WHERE nis = 20061), 'Ganjil', '2024/2025', 'SPP Bulanan', 638958, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20061', 1062, 20061, (SELECT email FROM user WHERE nis = 20061), 638958, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20062
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1062, '2025-06-09', 20062, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20062);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1063, (SELECT user_id FROM siswa WHERE nis = 20062), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20042', 1063, 20062, (SELECT email FROM user WHERE nis = 20062), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20063
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1063, '2025-06-05', 20063, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20063);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1064, (SELECT user_id FROM siswa WHERE nis = 20063), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20063', 1064, 20063, (SELECT email FROM user WHERE nis = 20063), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20064
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1064, '2025-05-27', 20064, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20064);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1065, (SELECT user_id FROM siswa WHERE nis = 20064), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20064', 1065, 20064, (SELECT email FROM user WHERE nis = 20064), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20065
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1065, '2025-06-11', 20065, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20065);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1066, (SELECT user_id FROM siswa WHERE nis = 20065), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20065', 1066, 20065, (SELECT email FROM user WHERE nis = 20065), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20066
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1066, '2025-06-21', 20066, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20066);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1067, (SELECT user_id FROM siswa WHERE nis = 20066), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20066', 1067, 20066, (SELECT email FROM user WHERE nis = 20066), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20067
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1067, '2025-06-20', 20067, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20067);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1068, (SELECT user_id FROM siswa WHERE nis = 20067), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20067', 1068, 20067, (SELECT email FROM user WHERE nis = 20067), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20068
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1068, '2025-06-13', 20068, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20068);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1069, (SELECT user_id FROM siswa WHERE nis = 20068), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20068', 1069, 20068, (SELECT email FROM user WHERE nis = 20068), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20069
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1069, '2025-06-10', 20069, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20069);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1070, (SELECT user_id FROM siswa WHERE nis = 20069), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20069', 1070, 20069, (SELECT email FROM user WHERE nis = 20069), 623384, 'settlement', NULL, '2025-06-10');


-- Siswa NIS: 20070
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1070, '2025-06-21', 20070, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20070);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 66.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1071, (SELECT user_id FROM siswa WHERE nis = 20070), 'Ganjil', '2024/2025', 'SPP Bulanan', 858372, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20070', 1071, 20070, (SELECT email FROM user WHERE nis = 20070), 858372, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20071
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1071, '2025-06-09', 20071, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20071);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 76.31, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1072, (SELECT user_id FROM siswa WHERE nis = 20071), 'Ganjil', '2024/2025', 'SPP Bulanan', 638958, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20071', 1072, 20071, (SELECT email FROM user WHERE nis = 20071), 638958, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20072
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1072, '2025-06-09', 20072, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20072);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1073, (SELECT user_id FROM siswa WHERE nis = 20072), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20042', 1073, 20072, (SELECT email FROM user WHERE nis = 20072), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20073
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1073, '2025-06-05', 20073, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20073);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1074, (SELECT user_id FROM siswa WHERE nis = 20073), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20073', 1074, 20073, (SELECT email FROM user WHERE nis = 20073), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20074
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1074, '2025-05-27', 20074, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20074);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1075, (SELECT user_id FROM siswa WHERE nis = 20074), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20074', 1075, 20074, (SELECT email FROM user WHERE nis = 20074), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20075
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1075, '2025-06-11', 20075, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20075);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1076, (SELECT user_id FROM siswa WHERE nis = 20075), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20075', 1076, 20075, (SELECT email FROM user WHERE nis = 20075), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20076
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1076, '2025-06-21', 20076, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20076);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1077, (SELECT user_id FROM siswa WHERE nis = 20076), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20076', 1077, 20076, (SELECT email FROM user WHERE nis = 20076), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20077
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1077, '2025-06-20', 20077, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20077);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1078, (SELECT user_id FROM siswa WHERE nis = 20077), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20077', 1078, 20077, (SELECT email FROM user WHERE nis = 20077), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20078
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1078, '2025-06-13', 20078, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20078);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1079, (SELECT user_id FROM siswa WHERE nis = 20078), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20078', 1079, 20078, (SELECT email FROM user WHERE nis = 20078), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20079
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1079, '2025-06-10', 20079, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20079);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1080, (SELECT user_id FROM siswa WHERE nis = 20079), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20079', 1080, 20079, (SELECT email FROM user WHERE nis = 20079), 623384, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20080
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1080, '2025-06-10', 20080, '7a', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('H', 5, 20080);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1081, (SELECT user_id FROM siswa WHERE nis = 20080), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20080', 1081, 20080, (SELECT email FROM user WHERE nis = 20080), 623384, 'settlement', NULL, '2025-06-10');

