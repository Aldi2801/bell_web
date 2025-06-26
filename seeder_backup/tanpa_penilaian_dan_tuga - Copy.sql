-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2025 at 06:41 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.0.30

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `bell_web_sistem`
--

--
-- Dumping data for table `ampu_mapel`
--


--
-- Dumping data for table `berita`
--
-- Insert 3 berita (1 fix + 2 baru untuk guru dan murid)
INSERT INTO berita (id_berita, judul, isi, nip, tanggal_dibuat, pengumuman_untuk) VALUES
(1, 'Pengumuman Pembagian Kelas', 'Seluruh orang tua diharapkan mengantar anaknya sampai ke depan sekolah sebelum pukul 07.00 karena akan ada apel pagi.', '198005122020041001', '2025-06-25 09:48:05', 'murid'),
(2, 'Rapat Koordinasi Guru', 'Semua guru wajib hadir dalam rapat koordinasi semester ganjil pada hari Jumat pukul 13.00 di ruang guru.', '198005122020041001', '2025-06-24 09:48:05', 'guru'),
(3, 'Kegiatan Class Meeting', 'Class meeting akan dimulai minggu depan. Semua murid diwajibkan berpartisipasi dalam minimal satu kegiatan.', '198005122020041001', '2025-06-23 09:48:05', 'murid');
--
-- Dumping data for table `gender`
--

INSERT INTO `gender` (`id_gender`, `gender`) VALUES
('L', 'laki-laki'),
('P', 'perempuan');

--
-- Dumping data for table `guru`
--

INSERT INTO `guru` (`nip`, `inisial`, `nama`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `email`, `spesialisasi`, `id_gender`, `id_status`) VALUES
('197901172020041006', 'PRN', 'Purnadi, S.Pd.S', 'Slawi', '1979-01-27', 'Jl. Flamboyan No. 10, Slawi', '081234567806', 'purnadi@example.com', 'Penjas', 'L', '1'),
('198005122020041001', 'JMR', 'H. Jamar, S.Pd.I', 'Tegal', '1980-05-12', 'Jl. Merdeka No. 1, Tegal', '081234567801', 'jamar@example.com', 'PAI', 'L', '1'),
('198208202020042002', 'HRW', 'H. Hurwiyati, S.Pd', 'Brebes', '1982-08-20', 'Jl. Mawar No. 3, Brebes', '081234567802', 'hurwiyati@example.com', 'PKn', 'P', '1'),
('198304072020042005', 'ULN', 'Ulinnuha S.Pd.I', 'Brebes', '1983-04-07', 'Jl. Anggrek No. 9, Brebes', '081234567805', 'ulinnuha@example.com', 'PAI', 'P', '1'),
('198411102020041004', 'BYT', 'Biyanto, S.Pd', 'Tegal', '1984-11-10', 'Jl. Kenanga No. 7, Tegal', '081234567804', 'biyanto@example.com', 'Matematika', 'L', '1'),
('198502152020042003', 'TEP', 'Titik Eko Purwati, S.Pd', 'Slawi', '1985-02-15', 'Jl. Melati No. 5, Slawi', '081234567803', 'titikeko@example.com', 'B. Indonesia', 'P', '1'),
('198606052020041007', 'NAR', 'Nur Arifin, S.Pd.I', 'Tegal', '1986-06-05', 'Jl. Sawo No. 11, Tegal', '081234567807', 'nurarifin@example.com', 'PAI', 'L', '1'),
('199012302020042008', 'RA', 'Riski Arofiyah, S.Pd', 'Brebes', '1990-12-30', 'Jl. Semangka No. 12, Brebes', '081234567808', 'riskiarofiyah@example.com', 'IPA', 'P', '1');

--
-- Dumping data for table `jadwal_pelajaran`
--

INSERT INTO `jadwal_pelajaran` (`id_jadwal`, `day`, `time`, `period`, `subject`) VALUES
(1, 'Senin', '07.00 - 07.40', 1, '[\'Upacara\', \'\', \'\', \'\', \'\', \'\', \'\', \'\']'),
(2, 'Senin', '07.40 - 08.20', 2, '[\'MTK-HRW\', \'IPA-BYT\', \'ENG-HRW\', \'MTK-JMR\', \'IPS-TEP\', \'IPA-HRW\', \'ENG-JMR\', \'IPS-NAR\']'),
(3, 'Senin', '08.20 - 09.00', 3, '[\'IPS-ULN\', \'BI-ULN\', \'BI-TEP\', \'MTK-BYT\', \'IPS-JMR\', \'ENG-BYT\', \'BI-BYT\', \'MTK-JMR\']'),
(4, 'Senin', '09.00 - 09.40', 4, '[\'IPS-JMR\', \'MTK-RA\', \'BI-RA\', \'BI-ULN\', \'MTK-HRW\', \'IPA-NAR\', \'IPS-RA\', \'MTK-BYT\']'),
(5, 'Senin', '09.40 - 10.20', 5, '[\'BI-TEP\', \'BI-ULN\', \'IPA-JMR\', \'MTK-JMR\', \'BI-ULN\', \'ENG-JMR\', \'IPA-HRW\', \'BI-HRW\']'),
(6, 'Senin', '10.20 - 11.00', 6, '[\'MTK-ULN\', \'MTK-BYT\', \'MTK-TEP\', \'IPS-BYT\', \'ENG-HRW\', \'IPS-HRW\', \'MTK-JMR\', \'BI-RA\']'),
(7, 'Senin', '11.00 - 11.15', 7, '[\'\', \'\', \'\', \'\', \'\', \'\', \'\', \'\']'),
(8, 'Selasa', '07.00 - 07.40', 1, '[\'BI-JMR\', \'BI-HRW\', \'BI-BYT\', \'MTK-NAR\', \'ENG-HRW\', \'IPA-ULN\', \'IPS-NAR\', \'MTK-HRW\']'),
(9, 'Selasa', '07.40 - 08.20', 2, '[\'IPS-PRN\', \'IPS-TEP\', \'BI-NAR\', \'MTK-RA\', \'IPS-BYT\', \'MTK-PRN\', \'IPS-ULN\', \'IPA-ULN\']'),
(10, 'Selasa', '08.20 - 09.00', 3, '[\'IPA-HRW\', \'IPS-BYT\', \'ENG-RA\', \'ENG-TEP\', \'IPS-JMR\', \'BI-PRN\', \'IPA-HRW\', \'IPS-ULN\']'),
(11, 'Selasa', '09.00 - 09.40', 4, '[\'IPA-TEP\', \'BI-HRW\', \'IPS-RA\', \'ENG-JMR\', \'MTK-TEP\', \'IPS-ULN\', \'IPS-JMR\', \'IPA-BYT\']'),
(12, 'Selasa', '09.40 - 10.20', 5, '[\'MTK-TEP\', \'IPS-PRN\', \'IPS-BYT\', \'ENG-HRW\', \'MTK-JMR\', \'ENG-ULN\', \'BI-BYT\', \'MTK-HRW\']'),
(13, 'Selasa', '10.20 - 11.00', 6, '[\'IPA-HRW\', \'MTK-JMR\', \'MTK-RA\', \'IPA-JMR\', \'IPA-RA\', \'IPS-RA\', \'ENG-BYT\', \'IPA-NAR\']'),
(14, 'Rabu', '07.00 - 07.40', 1, '[\'ENG-PRN\', \'IPS-HRW\', \'IPA-BYT\', \'ENG-PRN\', \'MTK-PRN\', \'IPA-PRN\', \'BI-ULN\', \'IPS-HRW\']'),
(15, 'Rabu', '07.40 - 08.20', 2, '[\'IPS-NAR\', \'BI-RA\', \'IPA-RA\', \'ENG-ULN\', \'MTK-TEP\', \'MTK-HRW\', \'IPA-ULN\', \'ENG-RA\']'),
(16, 'Rabu', '08.20 - 09.00', 3, '[\'MTK-TEP\', \'IPA-TEP\', \'IPS-TEP\', \'IPS-RA\', \'BI-RA\', \'IPA-ULN\', \'IPS-TEP\', \'MTK-JMR\']'),
(17, 'Rabu', '09.00 - 09.40', 4, '[\'ENG-TEP\', \'BI-RA\', \'IPS-HRW\', \'IPA-RA\', \'MTK-JMR\', \'MTK-PRN\', \'ENG-HRW\', \'ENG-NAR\']'),
(18, 'Rabu', '09.40 - 10.20', 5, '[\'BI-JMR\', \'IPS-TEP\', \'IPS-TEP\', \'ENG-RA\', \'MTK-ULN\', \'BI-PRN\', \'MTK-PRN\', \'MTK-PRN\']'),
(19, 'Rabu', '10.20 - 11.00', 6, '[\'IPS-HRW\', \'BI-BYT\', \'IPS-ULN\', \'IPS-PRN\', \'IPA-JMR\', \'ENG-PRN\', \'BI-BYT\', \'BI-NAR\']'),
(20, 'Kamis', '07.00 - 07.40', 1, '[\'BI-TEP\', \'BI-ULN\', \'BI-BYT\', \'IPA-JMR\', \'MTK-ULN\', \'IPS-RA\', \'IPS-RA\', \'IPA-RA\']'),
(21, 'Kamis', '07.40 - 08.20', 2, '[\'BI-HRW\', \'ENG-TEP\', \'ENG-NAR\', \'BI-PRN\', \'IPS-TEP\', \'IPS-NAR\', \'IPS-TEP\', \'ENG-RA\']'),
(22, 'Kamis', '08.20 - 09.00', 3, '[\'IPA-RA\', \'MTK-TEP\', \'BI-BYT\', \'IPA-JMR\', \'ENG-RA\', \'ENG-ULN\', \'MTK-HRW\', \'ENG-RA\']'),
(23, 'Kamis', '09.00 - 09.40', 4, '[\'IPS-HRW\', \'BI-TEP\', \'ENG-HRW\', \'ENG-PRN\', \'ENG-JMR\', \'IPA-NAR\', \'IPA-RA\', \'ENG-RA\']'),
(24, 'Kamis', '09.40 - 10.20', 5, '[\'ENG-PRN\', \'ENG-PRN\', \'IPA-PRN\', \'BI-RA\', \'IPA-RA\', \'BI-JMR\', \'IPA-HRW\', \'IPA-BYT\']'),
(25, 'Kamis', '10.20 - 11.00', 6, '[\'IPA-RA\', \'IPA-PRN\', \'BI-HRW\', \'MTK-RA\', \'IPS-JMR\', \'ENG-HRW\', \'BI-RA\', \'BI-ULN\']'),
(26, 'Jumat', '07.00 - 07.40', 1, '[\'BI-JMR\', \'ENG-JMR\', \'IPS-JMR\', \'IPS-TEP\', \'MTK-NAR\', \'IPA-TEP\', \'IPS-ULN\', \'BI-BYT\']'),
(27, 'Jumat', '07.40 - 08.20', 2, '[\'IPA-ULN\', \'IPA-ULN\', \'BI-PRN\', \'MTK-NAR\', \'BI-TEP\', \'IPA-BYT\', \'ENG-JMR\', \'BI-PRN\']'),
(28, 'Jumat', '08.20 - 09.00', 3, '[\'MTK-NAR\', \'BI-PRN\', \'ENG-JMR\', \'MTK-NAR\', \'ENG-TEP\', \'ENG-TEP\', \'IPS-JMR\', \'IPS-BYT\']'),
(29, 'Jumat', '09.00 - 09.40', 4, '[\'MTK-BYT\', \'BI-TEP\', \'IPA-HRW\', \'IPA-JMR\', \'IPS-ULN\', \'IPS-JMR\', \'IPA-HRW\', \'BI-ULN\']'),
(30, 'Jumat', '09.40 - 10.20', 5, '[\'IPS-JMR\', \'MTK-TEP\', \'IPS-HRW\', \'ENG-TEP\', \'MTK-RA\', \'IPA-PRN\', \'ENG-NAR\', \'IPS-BYT\']'),
(31, 'Jumat', '10.20 - 11.00', 6, '[\'ENG-NAR\', \'MTK-ULN\', \'IPS-TEP\', \'BI-HRW\', \'IPA-NAR\', \'IPS-JMR\', \'MTK-PRN\', \'IPS-NAR\']'),
(32, 'Sabtu', '07.00 - 07.40', 1, '[\'MTK-RA\', \'IPS-HRW\', \'ENG-TEP\', \'ENG-JMR\', \'ENG-JMR\', \'IPS-BYT\', \'IPS-TEP\', \'MTK-NAR\']'),
(33, 'Sabtu', '07.40 - 08.20', 2, '[\'BI-TEP\', \'MTK-ULN\', \'IPS-RA\', \'IPA-HRW\', \'IPA-BYT\', \'BI-TEP\', \'ENG-PRN\', \'IPA-BYT\']'),
(34, 'Sabtu', '08.20 - 09.00', 3, '[\'IPA-TEP\', \'IPS-PRN\', \'MTK-HRW\', \'IPA-ULN\', \'BI-JMR\', \'IPS-BYT\', \'IPS-RA\', \'IPA-BYT\']'),
(35, 'Sabtu', '09.00 - 09.40', 4, '[\'IPS-JMR\', \'ENG-TEP\', \'IPS-NAR\', \'BI-HRW\', \'IPA-TEP\', \'IPS-JMR\', \'MTK-JMR\', \'IPA-JMR\']');

--
-- Dumping data for table `kbm`
--
--
-- Dumping data for table `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `tingkat`) VALUES
('7a', '7A', '7'),
('7b', '7B', '7'),
('7c', '7C', '7'),
('8a', '8A', '8'),
('8b', '8B', '8'),
('8c', '8C', '8'),
('9a', '9A', '9'),
('9b', '9B', '9');

--
-- Dumping data for table `keterangan`
--

INSERT INTO `keterangan` (`id_keterangan`, `keterangan`) VALUES
('0', 'Alpa'),
('1', 'hadir'),
('2', 'izin'),
('3', 'sakit');

--
-- Dumping data for table `mapel`
--

INSERT INTO `mapel` (`id_mapel`, `nama_mapel`) VALUES
('BI', 'bahasa indonesia'),
('ENG', 'Bahasa Inggris'),
('IPA', 'Ilmu Pengetahuan Alam'),
('IPS', 'Ilmu Pengetuhan Sosial'),
('MTK', 'Matematika');
/*
("Da","Bahasa Daerah"),
("BUD","Seni Budaya"),
("PJ","PJOK"),
("KHT","Keterampilan (Khot)"),
("TFZ","Tahfidz"),
("NHU","Nahwu"),
("AI","Amaliyah Ibadah"),
("KUN","Kitab Kuning");*/
/*
("L9","Bahasa Daerah"),
("L10","Seni Budaya"),
("L12","PJOK"),
("G4","Keterampilan (Khot)"),
("G15","Tahfidz"),
("H12","Nahwu"),
("F7","Amaliyah Ibadah"),
("F9","Kitab Kuning");*/

--
-- Dumping data for table `pembagian_kelas`
--

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(1, 'admin'),
(2, 'guru'),
(3, 'murid');

--
-- Dumping data for table `semester`
--

INSERT INTO `semester` (`id_semester`, `semester`) VALUES
('0', 'genap'),
('1', 'ganjil');

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`user_id`,`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`) VALUES
(3,20001, '99000001', 'Salman Alfaridzi', 'L', 'Tegal', '2004-05-01', 'balamoa', '08997635673', 'jokowi', 'kartini', 5000000, 5000000, 'sd balamoa 2', '1'),
(4,20002, '99000002', 'Ulya Kuswandari', 'L', 'Sorong', '2010-05-04', 'Gg. Monginsidi No. 707, Kupang, BB 73648', '083534174743', 'Raihan', 'Tari', 5349707, 5567012, 'SDN 46 Tebingtinggi', '1'),
(5,20003, '99000003', 'Rina Tampubolon', 'P', 'Pagaralam', '2009-04-07', 'Gg. Raya Ujungberung No. 702, Langsa, YO 86622', '081751969992', 'Rafi', 'Uli', 3903607, 3624521, 'SDN 11 Kota Administrasi Jakar', '1'),
(6,20004, '99000004', 'Kanda Pradana', 'L', 'Pekanbaru', '2009-07-23', 'Jl. Otto Iskandardinata No. 64, Jayapura, Nusa Tenggara Barat 24069', '086137536812', 'Wira', 'Winda', 3022701, 4820059, 'SDN 43 Kota Administrasi Jakar', '1'),
(7,20005, '99000005', 'Edison Gunawan', 'P', 'Tegal', '2009-08-10', 'Jl. Ahmad Yani No. 8, Magelang, KI 93406', '083919082822', 'Ikin', 'Farhunnisa', 6848812, 4659764, 'SDN 50 Tarakan', '1'),
(8,20006, '99000006', 'Chelsea Prayoga', 'L', 'Cirebon', '2009-01-29', 'Gang S. Parman No. 12, Pangkalpinang, JI 39077', '088020423937', 'Marsito', 'Paris', 4297256, 4545479, 'SDN 7 Makassar', '1'),
(9,20007, '99000007', 'Wage Prasetyo', 'P',  'Bitung', '2008-07-24', 'Jalan Rajawali Timur No. 6, Tangerang, SB 09260', '084806497890', 'Garan', 'Jessica', 4155649, 4722682, 'SDN 32 Yogyakarta', '1'),
(10,20008, '99000008','Lantar Saputra', 'L',  'Ambon', '2010-07-03', 'Gang Pacuan Kuda No. 27, Pangkalpinang, DI Yogyakarta 80001', '085431568664', 'Kemba', 'Eka', 5406403, 2407788, 'SDN 34 Singkawang', '1'),
(11,20009, '99000009','Usman Nuraini', 'P', 'Kota Administrasi Ja', '2009-09-25', 'Gang BKR No. 5, Semarang, Nusa Tenggara Timur 35573', '084492532959', 'Marsito', 'Lala', 6785452, 3920845, 'SDN 28 Padang Sidempuan', '1'),
(12,20010, '99000010','Jagapati Agustina', 'L', 'Binjai', '2010-06-17', 'Jalan Medokan Ayu No. 7, Sibolga, Sumatera Selatan 37647', '083527763960', 'Arta', 'Uli', 6918907, 5166908, 'SDN 35 Tegal', '1'),
(13,20011, '99000011','Cinta Kuswandari', 'P', 'Mataram', '2009-05-28', 'Jl. Rajawali Timur No. 453, Sibolga, Bali 24175', '088089610534', 'Dimaz', 'Zalindra', 6569985, 4664886, 'SDN 19 Pekanbaru', '1'),
(14,20012, '99000012','Kartika Riyanti', 'L', 'Denpasar', '2009-09-27', 'Gg. Cikutra Timur No. 062, Bau-Bau, DI Yogyakarta 45334', '084536944192', 'Cengkir', 'Kasiyah', 4990166, 5038262, 'SDN 21 Sorong', '1'),
(15,20013, '99000013','Raisa Widodo', 'P', 'Tangerang Selatan', '2010-08-15', 'Gang Cempaka No. 30, Solok, PA 37783', '081396397510', 'Pangeran', 'Yunita', 4705423, 3508738, 'SDN 22 Banjarbaru', '1'),
(16,20014, '99000014','Galuh Situmorang', 'L', 'Semarang', '2010-10-26', 'Jl. Sentot Alibasa No. 2, Kota Administrasi Jakarta Timur, Nusa Tenggara Barat 01193', '082545816729', 'Embuh', 'Samiah', 3449626, 3052411, 'SDN 26 Padang', '1'),
(17,20015, '99000015','Martana Saragih', 'P', 'Tebingtinggi', '2010-07-26', 'Gg. Surapati No. 98, Sukabumi, AC 29998', '088936399887', 'Eman', 'Lala', 3966083, 3473204, 'SDN 31 Manado', '1'),
(18,20016, '99000016','Rangga Winarsih', 'L', 'Meulaboh', '2009-01-17', 'Gg. Dipatiukur No. 39, Bandar Lampung, JK 19942', '084529282125', 'Galih', 'Patricia', 6837478, 2691268, 'SDN 3 Probolinggo', '1'),
(19,20017, '99000017','Zizi Mulyani', 'P', 'Pangkalpinang', '2011-04-24', 'Gang Moch. Ramdan No. 46, Palopo, Banten 52629', '081214313519', 'Kardi', 'Yuni', 4206936, 2350061, 'SDN 10 Sabang', '1'),
(20,20018, '99000018','Laksana Pradana', 'L', 'Magelang', '2010-08-25', 'Jalan Gegerkalong Hilir No. 9, Langsa, Kalimantan Selatan 92221', '086693897872', 'Salman', 'Victoria', 5416154, 2789512, 'SDN 48 Semarang', '1'),
(21,20019, '99000019','Latif Aniani', 'P', 'Kupang', '2010-08-19', 'Gg. Ahmad Dahlan No. 274, Tebingtinggi, KI 10573', '083307566250', 'Hartaka', 'Tania', 5005931, 2123075, 'SDN 18 Palopo', '1'),
(22,20020, '99000020','Kezia Wibisono', 'L',  'Bandung', '2008-08-19', 'Jl. Cihampelas No. 979, Pasuruan, Jawa Tengah 81784', '084814416361', 'Bagya', 'Nabila', 5756761, 5657136, 'SDN 26 Prabumulih', '1'),
(23,20021, '99000021','Vanesa Kusumo', 'P', 'Sorong', '2008-10-30', 'Gg. Asia Afrika No. 26, Denpasar, Banten 49195', '084275504352', 'Opan', 'Kamila', 3917432, 2806700, 'SDN 37 Yogyakarta', '1'),
(24,20022, '99000022','Harsaya Marpaung', 'L', 'Balikpapan', '2009-04-16', 'Gang Veteran No. 310, Kotamobagu, Maluku Utara 66223', '088140977757', 'Hasim', 'Tami', 3603660, 5251578, 'SDN 8 Binjai', '1'),
(25,20023, '99000023','Prayoga Winarno', 'P', 'Kota Administrasi Ja', '2010-07-11', 'Gg. Rawamangun No. 47, Banjarmasin, Gorontalo 35373', '082313505300', 'Latif', 'Salimah', 6077157, 2268842, 'SDN 42 Balikpapan', '1'),
(26,20024, '99000024','Safina Gunawan', 'L', 'Salatiga', '2009-10-23', 'Gg. Surapati No. 920, Bau-Bau, NT 48810', '084045189223', 'Jagapati', 'Vera', 5088211, 3613787, 'SDN 13 Tangerang', '1'),
(27,20025, '99000025','Kartika Puspasari', 'P', 'Bima', '2009-12-29', 'Gg. Dipenogoro No. 78, Kota Administrasi Jakarta Barat, BB 88025', '088201317217', 'Rahman', 'Raina', 5459873, 3163849, 'SDN 18 Kotamobagu', '1'),
(28,20026, '99000026','Garang Winarno', 'L',  'Pagaralam', '2009-05-06', 'Gang Asia Afrika No. 436, Bekasi, SU 63708', '084797990718', 'Margana', 'Diana', 6161251, 4852569, 'SDN 27 Depok', '1'),
(29,20027, '99000027','Tasnim Iswahyudi', 'P', 'Tangerang', '2009-04-29', 'Jl. M.H Thamrin No. 35, Bukittinggi, Jawa Tengah 81492', '088616112822', 'Darman', 'Maimunah', 4428355, 5684865, 'SDN 25 Langsa', '1'),
(30,20028, '99000028','Mariadi Kusumo', 'L',  'Tegal', '2008-09-09', 'Jl. Ciumbuleuit No. 1, Palopo, Sumatera Selatan 09139', '085585272500', 'Bagya', 'Gina', 5671742, 5070841, 'SDN 17 Kota Administrasi Jakar', '1'),
(31,20029, '99000029','Puput Jailani', 'P', 'Bandung', '2010-07-28', 'Jl. Ciumbuleuit No. 81, Kendari, Sulawesi Selatan 01776', '081953570877', 'Lasmono', 'Vera', 6185623, 3210179, 'SDN 10 Kota Administrasi Jakar', '1'),
(32,20030, '99000030','Cemani Natsir', 'L', 'Madiun', '2011-02-15', 'Gang Suniaraja No. 043, Solok, Sumatera Barat 49118', '083764336462', 'Adikara', 'Latika', 4349769, 3973582, 'SDN 24 Bima', '1'),
(33,20031, '99000031','Maida Narpati', 'P','Batu', '2009-04-22', 'Gang KH Amin Jasuta No. 341, Bandar Lampung, BA 55988', '083728872294', 'Cahya', 'Sakura', 5867907, 3099792, 'SDN 36 Kediri', '1'),
(34,20032, '99000032','Vinsen Waluyo', 'L', 'Pagaralam', '2010-05-23', 'Jl. Kutai No. 5, Cimahi, BB 87970', '084027781699', 'Jagapati', 'Maida', 3160534, 2673410, 'SDN 41 Blitar', '1'),
(35,20033, '99000033','Jessica Narpati', 'P', 'Lubuklinggau', '2008-10-01', 'Jalan M.T Haryono No. 19, Purwokerto, YO 89753', '086160290319', 'Taswir', 'Vicky', 3513305, 3657289, 'SDN 26 Serang', '1'),
(36,20034, '99000034','Harto Mangunsong', 'L', 'Bandung', '2011-04-01', 'Jl. M.T Haryono No. 651, Ambon, SR 51360', '084502261055', 'Satya', 'Ika', 4635896, 5513288, 'SDN 5 Padang Sidempuan', '1'),
(37,20035, '99000035','Yani Hartati', 'P', 'Sawahlunto', '2009-10-01', 'Jl. K.H. Wahid Hasyim No. 59, Cimahi, Jawa Timur 64646', '087099346431', 'Caket', 'Titin', 3524314, 2928113, 'SDN 7 Bogor', '1'),
(38,20036, '99000036','Zizi Sirait', 'L', 'Buukittinggi', '2010-09-21', 'Jalan Jakarta No. 67, Gorontalo, JB 23386', '084366672746', 'Estiawan', 'Iriana', 6417459, 2536301, 'SDN 20 Tangerang', '1'),
(39,20037, '99000037','Sutan Lukita Dongoran', 'P', 'Samarinda', '2010-12-17', 'Gang Rungkut Industri No. 4, Bitung, Aceh 11987', '083662321406', 'Irsad', 'Victoria', 5768375, 5754281, 'SDN 2 Tangerang Selatan', '1'),
(40,20038, '99000038','Harja Simanjuntak', 'L', 'Malang', '2009-12-12', 'Jalan Suryakencana No. 8, Bandar Lampung, ST 34605', '086216392279', 'Mujur', 'Gasti', 6454944, 2947373, 'SDN 23 Palopo', '1'),
(41,20039, '99000039','Hartana Wahyuni', 'P', 'Kendari', '2009-09-09', 'Jl. Medokan Ayu No. 4, Lhokseumawe, LA 31380', '085799067527', 'Dimas', 'Samiah', 5928103, 3324317, 'SDN 13 Pasuruan', '1'),
(42,20040, '99000040','Cindy Anggriawan', 'L', 'Surakarta', '2008-08-04', 'Gang Raya Setiabudhi No. 6, Surakarta, JA 27887', '088805777574', 'Balidin', 'Yulia', 5101001, 4202127, 'SDN 10 Kota Administrasi Jakar', '1'),
(43,20041, '99000041','Patricia Prayoga', 'P', 'Tangerang', '2008-06-20', 'Gg. Ir. H. Djuanda No. 03, Sawahlunto, JK 21119', '083206630419', 'Kasusra', 'Eva', 6698862, 4788482, 'SDN 45 Palopo', '1'),
(44,20042, '99000042','Carla Irawan', 'L', 'Metro', '2008-12-31', 'Gg. Rajiman No. 6, Depok, NB 90732', '088404643169', 'Koko', 'Chelsea', 3006879, 5830031, 'SDN 25 Lubuklinggau', '1'),
(45,20043, '99000043','Gina Hutapea', 'P', 'Madiun', '2009-05-18', 'Gang Rajiman No. 066, Gorontalo, KS 57742', '089197887393', 'Kajen', 'Ghaliyati', 4113120, 5555686, 'SDN 41 Samarinda', '1'),
(46,20044, '99000044','Ulva Wasita', 'L', 'Goorontalo', '2010-09-07', 'Jalan Kebonjati No. 891, Surabaya, DI Yogyakarta 56943', '089085211229', 'Caraka', 'Cici', 5086070, 5086056, 'SDN 24 Denpasar', '1'),
(47,20045, '99000045','Suci Rajata', 'P', 'Metro', '2009-05-02', 'Jalan Raya Setiabudhi No. 23, Bandar Lampung, Sulawesi Selatan 37463', '081883952468', 'Cemani', 'Diah', 4788210, 3675811, 'SDN 3 Pariaman', '1'),
(48,20046, '99000046','Tri Sirait ', 'L', 'Madiun', '2008-11-21', 'Gang Jamika No. 5, Tidore Kepulauan, Kalimantan Utara 69645', '083629339450', 'Manah', 'Jamalia', 3791988, 4871070, 'SDN 30 Ternate', '1'),
(49,20047, '99000047','Hari Mandala', 'P', 'Sabang', '2009-05-24', 'Gg. Ronggowarsito No. 50, Kota Administrasi Jakarta Timur, Jawa Tengah 97130', '089463858417', 'Taufan', 'Nabila', 6249401, 3514094, 'SDN 40 Tasikmalaya', '1'),
(50,20048, '99000048','Puti Wulan Kuswoyo', 'L', 'Yogyakarta', '2009-07-28', 'Jalan HOS. Cokroaminoto No. 8, Palu, YO 82011', '088480156629', 'Tirtayasa', 'Kayla', 6878563, 5807993, 'SDN 49 Jayapura', '1'),
(51,20049, '99000049','Upik Sihotang', 'P', 'Meulaboh', '2009-06-22', 'Gang Kendalsari No. 119, Tanjungbalai, JK 61131', '083979617784', 'Bajragin', 'Salwa', 3515438, 5753624, 'SDN 43 Metro', '1'),
(52,20050, '99000050','Ayu Purnawati', 'L', 'Padangpanjang', '2009-07-14', 'Jalan Ciumbuleuit No. 2, Batam, KS 56258', '086540159636', 'Niyaga', 'Ratna', 3015723, 4656067, 'SDN 24 Jambi', '1');

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id_status`, `status`) VALUES
('0', 'tidak aktif '),
('1', 'aktif');

--
-- Dumping data for table `tagihan`
--

INSERT INTO `tagihan` (`user_id`,`id_tagihan`,  `semester`, `tahun_ajaran`, `deskripsi`, `total`, `created_at`) VALUES
(3 , 6, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(3 , 7, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(4 , 8, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(4 , 9, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(5 , 10, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(5 , 11, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(6 , 12, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(6 , 13, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(7 , 14, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(7 , 15, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(8 , 16, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(8 , 17, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(9 , 18, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(9 , 19, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(10, 20, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(10, 21, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(11, 22, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(11, 23, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(12, 24, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(12, 25, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(13, 26, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(13, 27, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(14, 28, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(14, 29, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(15, 30, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(15, 31, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(16, 32, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(16, 33, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(17, 34, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(17, 35, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(18, 36, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(18, 37, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(19, 38, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(19, 39, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(20, 40, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(20, 41, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(21, 42, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(21, 43, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(22, 44, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(22, 45, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(23, 46, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(23, 47, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(24, 48, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(24, 49, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(25, 50, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(25, 51, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(26, 52, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(26, 53, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(27, 54, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(27, 55, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(28, 56, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(28, 57, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(29, 58, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(29, 59, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(30, 60, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(30, 61, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(31, 62, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(31, 63, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(32, 64, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(32, 65, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(33, 66, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(33, 67, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(34, 68, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(34, 69, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(35, 70, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(35, 71, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(36, 72, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(36, 73, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(37, 74, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(37, 75, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(38, 76, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(38, 77, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(39, 78, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(39, 79, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(40, 80, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(40, 81, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(41, 82, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(41, 83, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(42, 84, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(42, 85, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(43, 86, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(43, 87, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(44, 88, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(44, 89, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(45, 90, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(45, 91, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(46, 92, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(46, 93, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(47, 94, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(47, 95, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(48, 96, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(48, 97, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(49, 98, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(49, 99, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(50, 100, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(50, 101, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(51, 102, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(51, 103, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(52, 104, 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(52, 105, 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38');

INSERT INTO `tahun_akademik` (`id_tahun_akademik`, `tahun_akademik`, `mulai`, `sampai`) VALUES
( '1', '2019/2020', '2019-07-01', '2020-06-30'),
( '2', '2020/2021', '2020-07-01', '2021-06-30'),
( '3', '2021/2022', '2021-07-01', '2022-06-30'),
( '4', '2022/2023', '2022-07-01', '2023-06-30'),
( '5', '2023/2024', '2023-07-01', '2024-06-30'),
( '6', '2024/2025', '2024-07-01', '2025-06-30');


INSERT INTO `transaksi` (`id_transaksi`, `kode_order`, `id_tagihan`, `nis`, `email`, `total`, `status`, `fraud_status`, `created_at`, `updated_at`) VALUES
(1, 'Bla-123', 1, NULL, 'man@gmail.com', 100000, 'paid', '0', NULL, NULL);

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `nis`, `nip`, `email`, `active`) VALUES
(1, 'admin', '$2b$12$0CDIw.GPbUrAsVfn4bhbKeEcwjRd.hyAqomQunp1S3gX1tmJvd2mC', NULL, NULL, 'ADMIN@mail.com', 1),
(2, 'jamar', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198005122020041001', 'pakarisW@mial.com', 1),
(3, 'Salman', '$2b$12$N2D4cncbxLazOpAUX1GZnOsbyr7uFCTc41NtbxMgCO6ZGPJFtlHc.', 20001, NULL, 'man@gmail.com', 1),
(4, 'Ulya', '$2b$12$zmdlJW2byTw/eW.1PQIPQ.0rQyUqoCId6VPyOGeVlLo1mtgNCwtPW', 20002, NULL, 'ulyakuswandarispt0@mail.com', 1),
(5, 'Rina', '$2b$12$PixQjsyx0XyoI86eaNMGquAkF9K6t.Z3dcQE.OJWMkLMN3e.sS4vi', 20003, NULL, 'rinatampubolon1@mail.com', 1),
(6, 'Kanda', '$2b$12$tlKcCB3xg1JiljMslSzgquC/Pn1Mx4wPeWxY4ApLTQWAvnG53uUWq', 20004, NULL, 'kandapradana2@mail.com', 1),
(7, 'Edison', '$2b$12$FfYByen3SOt9FO.lmyXFQ.qzLVC6YbEO3iBpvPZXqrFUkWRDi768K', 20005, NULL, 'edisongunawan3@mail.com', 1),
(8, 'Chelsea', '$2b$12$iqVgfjU0hG.RTW8DbkF/iOIRp4qOibEFtEaXApdLrJWtIsQevnjh.', 20006, NULL, 'chelseaprayoga4@mail.com', 1),
(9, 'Wage', '$2b$12$mudk8k88ZFeTlM.SWdVyAebV2NWW9jBzGhDnE8pAlOpp9d.SSvuPK', 20007, NULL, 'wageprasetyost5@mail.com', 1),
(10, 'lantar', '$2b$12$Z5R5X1bfy1u020bFYRIIZuJLutNK/uxLpkviCYCYo3JH2ViA7vVG.', 20008, NULL, 'lantarsaputramkom6@mail.com', 1),
(11, 'Usman', '$2b$12$/xh8sX.zG0vl24Wqp1U5jOGYJTWbVFUoK42C5PAJJsOwlXnKUEIf.', 20009, NULL, 'usmannuraini7@mail.com', 1),
(12, 'Jagapati8', '$2b$12$LKih7Ps6RhKO3UMu3lBGwu/sCYWAIcWh0muXgg33JyFLMkgp1Ze.S', 20010, NULL, 'jagapatiagustinamfarm8@mail.com', 1),
(13, 'cinta9', '$2b$12$k3lA9Uw/Nlo0vFPHgtFCbegtIh0K57iPZlUqm0Ac9mZDx.UZeXmVS', 20011, NULL, 'cintakuswandari9@mail.com', 1),
(14, 'kartika10', '$2b$12$JxRLMqwJ0eHNH5k9q.DOju4sjvizX6/LlFcqRmgFy4oyN6BginM5q', 20012, NULL, 'kartikariyanti10@mail.com', 1),
(15, 'raisa11', '$2b$12$RrZ8Y03H51DmbVdLnW0GnO8cWLbObpM9/Jyz4MKTOer1M0TVOZVBm', 20013, NULL, 'raisawidodo11@mail.com', 1),
(16, 'galuh12', '$2b$12$FqsdvuR81T7eUZSQagF1VO8HiRm435SVS2FO6Z6620ZwapNNERcKW', 20014, NULL, 'galuhsitumorang12@mail.com', 1),
(17, 'martana13', '$2b$12$Ymz.Fkfr8ju670h8d2jwwO30wIe/AYsBrhraotxD962RcAj666amO', 20015, NULL, 'martanasaragih13@mail.com', 1),
(18, 'rangga14', '$2b$12$SlDZieVb.MK.iO.Uyypbk..nmFqR5yW3Hm44Px8elOWMyLdEhTjQi', 20016, NULL, 'ranggawinarsih14@mail.com', 1),
(19, 'zizi', '$2b$12$BRmPWICp5eHlf0haEKlkpOgClBLvRyn8EWAclyftHPBZI7ZSvTQCS', 20017, NULL, 'gzizimulyanimti15@mail.com', 1),
(20, 'laksana16', '$2b$12$ErTQasH1GR7i5aLVR1RJvO4Xa8aPzQA09IDX196rRVaQAOe.vuxUW', 20018, NULL, 'laksanapradana16@mail.com', 1),
(21, 'Latif', '$2b$12$XwvC.yzKggq7x7y6N7XfjexOKAaR6nYxgMnaoEfMIs7EabqaGzNNG', 20019, NULL, 'khlatifaniani17@mail.com', 1),
(22, 'kezia18', '$2b$12$NxBKjiBUdriZ2wdlqewjpOLnvSwBtNOIcSKHvZVZtHDl5.OFYM3g.', 20020, NULL, 'keziawibisono18@mail.com', 1),
(23, 'vanesa19', '$2b$12$CeLWKak152Ev05oOM3NyneBjQ63XYToaqudikODgE8QbxtGJz0fNW', 20021, NULL, 'vanesakusumospsi19@mail.com', 1),
(24, 'harsaya20', '$2b$12$5bvjZtvSRh3GqmalaJJVS.4SomXsGYCyiXPQPGM8d3qUPURaZ86XK', 20022, NULL, 'harsayamarpaung20@mail.com', 1),
(25, 'prayoga21', '$2b$12$YURakNqKC22mmWz0M68h7exRzHNCAdquLtkBa6qd9RsiDrNiui1P2', 20023, NULL, 'prayogawinarnosfarm21@mail.com', 1),
(26, 'Safina', '$2b$12$0x8jJb4KpDero7QwUeebs.Ab6Vx1CrTUBeZ8cDpf2TTnO7tHfn9Ve', 20024, NULL, 'drssafinagunawan22@mail.com', 1),
(27, 'kartika23', '$2b$12$7gzEKWS/jWfN/bs8IdrC2esTr7NGBYMN4sL71CvnGYjbJUkUtIAkq', 20025, NULL, 'kartikapuspasari23@mail.com', 1),
(28, 'garang24', '$2b$12$cfXnG7KbZMrH0HTkcAW0POFiMWfPr/36XEVsZQitu5X504LWywvAG', 20026, NULL, 'garangwinarno24@mail.com', 1),
(29, 'tasnim25', '$2b$12$59FsNFCC.Oi7CfA.9K0JZO1SSzjJUp.QLVFffNt1Tw5Uqnb2LZwni', 20027, NULL, 'tasnimiswahyudi25@mail.com', 1),
(30, 'mariadi26', '$2b$12$Yy6RbXqpbo.XdfZkCGzLNeGQyGMS7yD0/vuYRsUJ1EbMhy5xZT79a', 20028, NULL, 'mariadikusumo26@mail.com', 1),
(31, 'Puput', '$2b$12$7cwmiwiLAluefEG7/OdAJuOV6HgEMvsLHIjygRcqIq63tjQ.lAJ0O', 20029, NULL, 'drspuputjailani27@mail.com', 1),
(32, 'cemani28', '$2b$12$Cz3fesjDYJvqrXDsnzK5JOUj3ObQ9z/6tpyunENGykvvRgDT0NNkC', 20030, NULL, 'cemaninatsir28@mail.com', 1),
(33, 'maida29', '$2b$12$BE/LRhSj/r9k8iCEgJaaS.nf7rz9rnabbhWkN5mohXyTY1Bhum3.i', 20031, NULL, 'maidanarpati29@mail.com', 1),
(34, 'vinsen30', '$2b$12$7gJuSq4lb2BXBHaUcGjvdOQfivqtK1GCQpV1OpWQBbQ6x0B6lPYkC', 20032, NULL, 'vinsenwaluyo30@mail.com', 1),
(35, 'Jessica', '$2b$12$F43r5XWF/vUCTjYON4zrhecXs0DLq37sOGfkUFfVGS6MuNbjEHRW.', 20033, NULL, 'cutjessicanarpatisip31@mail.com', 1),
(36, 'harto32', '$2b$12$rnEfURom2NLCW0NpY5TnWeVijpu0glT9B18c1sPjnd5Lg5V32EfXG', 20034, NULL, 'hartomangunsong32@mail.com', 1),
(37, 'yani33', '$2b$12$iiEKWcaxdvXH1N20OByas.S/GM4p.psmnqZddSd/aqIVBW4SD/rey', 20035, NULL, 'yanihartati33@mail.com', 1),
(38, 'zizi34', '$2b$12$4Ww.iqqVRvLcz1KG2C2PKeNGXN8Ur9eM9v5cMsh4YVJooab8rb4v6', 20036, NULL, 'zizisirait34@mail.com', 1),
(39, 'sutan35', '$2b$12$W1YYvPp82L21.gM6UI8Y6uNMgJfrGQOw3fOyQni7V/Nl3u4DV1m4S', 20037, NULL, 'sutanlukitadongoran35@mail.com', 1),
(40, 'harja36', '$2b$12$t0jLzvRUcUxV4SapE2ONmesWgcm4zGB1WxWHihgbpZgNvlRykQ8oW', 20038, NULL, 'harjasimanjuntak36@mail.com', 1),
(41, 'hartana37', '$2b$12$T013H2HzZAlI7BimK2rgKuWLMUNPGzrp6PDphEg0T8AOjw2O0c4A.', 20039, NULL, 'hartanawahyuni37@mail.com', 1),
(42, 'cindy38', '$2b$12$IB1phpUIgVNHRgg9fH85veHEEyFtays2PZ51AuUMd7pMUZa8a8U9i', 20040, NULL, 'cindyanggriawan38@mail.com', 1),
(43, 'patricia39', '$2b$12$l2sg/C5.1MHyash.yrJRJ.pGNC9GVDrFUayBKh2XqVXQsRTUaNSJm', 20041, NULL, 'patriciaprayoga39@mail.com', 1),
(44, 'carla40', '$2b$12$q.I74noXbsFdS3CgBCtmxurhjyroPO3gqjgK0N5eCJ.mJcr2Z/3ZC', 20042, NULL, 'carlairawan40@mail.com', 1),
(45, 'gina41', '$2b$12$01obduHiyr6rIJaEJi6uGuzlMO6XxKyfPL2gfYYoWWajcICQQ2z6W', 20043, NULL, 'ginahutapea41@mail.com', 1),
(46, 'ulva42', '$2b$12$JsJ5kWWJs4hPsIZqYLjFNuj8n4r/Pmt01ZuYxoXN08QAA/S3x.67K', 20044, NULL, 'ulvawasita42@mail.com', 1),
(47, 'suci43', '$2b$12$xU7OOVScpkAPdLgEfn7.AO/5jW5XpbbdKFJIFhkQUKqYT44/4V1Ay', 20045, NULL, 'sucirajatamak43@mail.com', 1),
(48, 'tri44', '$2b$12$Samw57Nr9lKcm6DHFWxv.uJG5Egh2xnn5WW1pyXNfovJGE4ZdtAge', 20046, NULL, 'trisiraitse44@mail.com', 1),
(49, 'Hari45', '$2b$12$Wz5oQrtM3SdjW0Slrhkcy.KX9ByJuN5G.Agd407uQphkdafGBx.7K', 20047, NULL, 'rharimandala45@mail.com', 1),
(50, 'puti46', '$2b$12$rR3q65AeIL4afLZrPwO6qOj7L1RJ..3xw29vJaSTteI5xIqIylnG6', 20048, NULL, 'putiwulankuswoyosei46@mail.com', 1),
(51, 'upik47', '$2b$12$K2aUtEOCHwbW6yaUPgk9puQNdvCMFi1IxlUU0aDCcvkOjDYDp38py', 20049, NULL, 'upiksihotang47@mail.com', 1),
(52, 'Ayu9', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20050, NULL, 'irayupurnawati48@mail.com', 0),
(53, 'Hurwiyati', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198208202020042002', 'hurwiyati@example.com', 1),
(54, 'Titik', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198502152020042003', 'titikeko@example.com', 1),
(55, 'Biyanto', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198411102020041004', 'biyanto@example.com', 1),
(56, 'Ulinnuha', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198304072020042005', 'ulinnuha@example.com', 1),
(57, 'Purnadi', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '197901172020041006', 'purnadi@example.com', 1),
(58, 'Nur', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198606052020041007', 'nurarifin@example.com', 1),
(59, 'Riski', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '199012302020042008', 'riskiarofiyah@example.com', 1);

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES
(1, 1, 1),
(2, 2, 2),
(3, 3, 3),
(4, 4, 3),
(5, 5, 3),
(6, 6, 3),
(7, 7, 3),
(8, 8, 3),
(9, 9, 3),
(10, 10, 3),
(11, 11, 3),
(12, 12, 3),
(13, 13, 3),
(14, 14, 3),
(15, 15, 3),
(16, 16, 3),
(17, 17, 3),
(18, 18, 3),
(19, 19, 3),
(20, 20, 3),
(21, 21, 3),
(22, 22, 3),
(23, 23, 3),
(24, 24, 3),
(25, 25, 3),
(26, 26, 3),
(27, 27, 3),
(28, 28, 3),
(29, 29, 3),
(30, 30, 3),
(31, 31, 3),
(32, 32, 3),
(33, 33, 3),
(34, 34, 3),
(35, 35, 3),
(36, 36, 3),
(37, 37, 3),
(38, 38, 3),
(39, 39, 3),
(40, 40, 3),
(41, 41, 3),
(42, 42, 3),
(43, 43, 3),
(44, 44, 3),
(45, 45, 3),
(46, 46, 3),
(47, 47, 3),
(48, 48, 3),
(49, 49, 3),
(50, 50, 3),
(51, 51, 3),
(52, 52, 3),
(53, 53, 2),
(54, 54, 2),
(55, 55, 2),
(56, 56, 2),
(57, 57, 2),
(58, 58, 2),
(59, 59, 2);
/*data tambahan*/
-- INSERT USER + SISWA (30 entries full field)
-- Dinaandi
INSERT INTO user (id, username, email, password, nis, active) VALUES (91, 'dinaandi', 'dinaandi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20051, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20051, '99000081', 'Dinaandi', 'P', 'Bukittinggi', '2009-08-29', 'Jl. Kutisari Selatan', '087015430391', 'Bakiadi', 'Uchita', 3652128, 3903091, 'SDN 3', '1', 91);
-- Dinairfan
INSERT INTO user (id, username, email, password, nis, active) VALUES (92, 'dinairfan', 'dinairfan@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20052, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20052, '99000082', 'Dinairfan', 'L', 'Batam', '2011-01-05', 'Jl. Kapten Muslihat', '08248963834', 'Heru', 'Salsabila', 3389004, 4593530, 'SDN 1', '1', 92);

-- Andiani
INSERT INTO user (id, username, email, password, nis, active) VALUES (61, 'andiani', 'andiani@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20053, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20053, '99000051', 'Andiani', 'L', 'Bandar Lampung', '2008-10-26', 'Jl. HOS. Cokroaminoto', '0819600133', 'Johan', 'Rahmi', 3104902, 6110288, 'SDN 3', '1', 61);
-- Andibudi
INSERT INTO user (id, username, email, password, nis, active) VALUES (62, 'andibudi', 'andibudi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20054, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20054, '99000052', 'Andibudi', 'L', 'Sabang', '2008-03-03', 'Jalan Cihampelas', '08265423511', 'Harjasa', 'Cinta', 3936213, 3585264, 'SDN 1', '1', 62);
-- Andiwulan
INSERT INTO user (id, username, email, password, nis, active) VALUES (63, 'andiwulan', 'andiwulan@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20055, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20055, '99000053', 'Andiwulan', 'L', 'Malang', '2011-08-13', 'Jalan Erlangga', '0816184959', 'Dadi', 'Tiara', 5476705, 4769668, 'SDN 1', '1', 63);
-- Anidewi
INSERT INTO user (id, username, email, password, nis, active) VALUES (64, 'anidewi', 'anidewi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20056, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20056, '99000054', 'Anidewi', 'L', 'Banjar', '2012-02-08', 'Gg. Ciwastra', '08647525534', 'Nardi', 'Sabrina', 3392986, 3917034, 'SDN 2', '1', 64);
-- Arifbayu
INSERT INTO user (id, username, email, password, nis, active) VALUES (65, 'arifbayu', 'arifbayu@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20057,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20057, '99000055', 'Arifbayu', 'L', 'Sibolga', '2011-11-18', 'Jl. Jamika', '086483503056', 'Embuh', 'Bella', 5354032, 3833985, 'SDN Jatibarang', '1', 65);
-- Arifwahyu
INSERT INTO user (id, username, email, password, nis, active) VALUES (66, 'arifwahyu', 'arifwahyu@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20058,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20058, '99000056', 'Arifwahyu', 'P', 'Salatiga', '2009-02-26', 'Gg. Suniaraja', '082423884969', 'Heru', 'Karen', 3924594, 4884119, 'SDN Jatibarang', '1', 66);
-- Bayuandi
INSERT INTO user (id, username, email, password, nis, active) VALUES (67, 'bayuandi', 'bayuandi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20059,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20059, '99000057', 'Bayuandi', 'P', 'Bogor', '2010-10-25', 'Jalan Cikapayang', '08226916697', 'Karsana', 'Hafshah', 6394997, 6646109, 'SDN 1', '1', 67);
-- Budiwulan
INSERT INTO user (id, username, email, password, nis, active) VALUES (68, 'budiwulan', 'budiwulan@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20060,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20060, '99000058', 'Budiwulan', 'L', 'Tangerang Selatan', '2007-06-15', 'Gang Gardujati', '086270482814', 'Saadat', 'Suci', 5928208, 4772573, 'SDN 3', '1', 68);
-- Fajartari
INSERT INTO user (id, username, email, password, nis, active) VALUES (71, 'fajartari', 'fajartari@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20061,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20061, '99000061', 'Fajartari', 'P', 'Palembang', '2010-11-19', 'Jalan Pacuan Kuda', '081509839301', 'Nugraha', 'Siti', 6554649, 4442654, 'SDN Jatibarang', '1', 71);
-- Irfanlia
INSERT INTO user (id, username, email, password, nis, active) VALUES (72, 'irfanlia', 'irfanlia@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20062,  1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20062, '99000062', 'Irfanlia', 'P', 'Kediri', '2007-01-20', 'Gg. Ciumbuleuit', '0834738299', 'Jasmani', 'Hesti', 6385341, 3182244, 'SDN Tegal', '1', 72);
-- Jokoani
INSERT INTO user (id, username, email, password, nis, active) VALUES (73, 'jokoani', 'jokoani@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20063, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20063, '99000063', 'Jokoani', 'L', 'Padang Sidempuan', '2008-02-06', 'Jl. Kapten Muslihat', '08566701065', 'Raharja', 'Zelda', 6868387, 4587688, 'SDN 1', '1', 73);
-- Jokobudi
INSERT INTO user (id, username, email, password, nis, active) VALUES (74, 'jokobudi', 'jokobudi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20064,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20064, '99000064', 'Jokobudi', 'P', 'Kota Administrasi Jakarta Barat', '2008-02-10', 'Gg. HOS. Cokroaminoto', '08247317810', 'Martana', 'Puput', 6478775, 5636706, 'SDN Jatibarang', '1', 74);
-- Jokomega
INSERT INTO user (id, username, email, password, nis, active) VALUES (75, 'jokomega', 'jokomega@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20065, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20065, '99000065', 'Jokomega', 'P', 'Bekasi', '2008-06-28', 'Gg. Rajiman', '083602606474', 'Indra', 'Tami', 5421590, 3806516, 'SDN 1', '1', 75);
-- Jokonina
INSERT INTO user (id, username, email, password, nis, active) VALUES (76, 'jokonina', 'jokonina@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20066, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20066, '99000066', 'Jokonina', 'L', 'Bukittinggi', '2008-02-04', 'Jalan Cikutra Barat', '08205009788', 'Candrakanta', 'Amelia', 5773539, 3955874, 'SDN 3', '1', 76);
-- Jokotari
INSERT INTO user (id, username, email, password, nis, active) VALUES (77, 'jokotari', 'jokotari@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20067, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20067, '99000067', 'Jokotari', 'L', 'Denpasar', '2007-01-23', 'Jl. Surapati', '08939909169', 'Karya', 'Putri', 6587462, 3976395, 'SDN 1', '1', 77);
-- Megamega
INSERT INTO user (id, username, email, password, nis, active) VALUES (78, 'megamega', 'megamega@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20068, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20068, '99000068', 'Megamega', 'P', 'Kota Administrasi Jakarta Selatan', '2008-03-20', 'Jalan Pasirkoja', '082472510799', 'Baktianto', 'Belinda', 4165905, 4901740, 'SDN 3', '1', 78);
-- Ninaandi
INSERT INTO user (id, username, email, password, nis, active) VALUES (79, 'ninaandi', 'ninaandi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20069,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20069, '99000069', 'Ninaandi', 'L', 'Pekalongan', '2008-09-25', 'Gg. Cikutra Timur', '085427849808', 'Eja', 'Salimah', 4552651, 4490113, 'SDN 2', '1', 79);
-- Ninaarif
INSERT INTO user (id, username, email, password, nis, active) VALUES (80, 'ninaarif', 'ninaarif@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20070,  1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20070, '99000070', 'Ninaarif', 'P', 'Bogor', '2008-09-23', 'Jl. M.H Thamrin', '08449353487', 'Dwi', 'Zulfa', 5943647, 6928614, 'SDN 1', '1', 80);
-- Ninanina
INSERT INTO user (id, username, email, password, nis, active) VALUES (81, 'ninanina', 'ninanina@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20071,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20071, '99000071', 'Ninanina', 'L', 'Bekasi', '2011-11-16', 'Gang Cihampelas', '08524278680', 'Balidin', 'Citra', 5240345, 6058179, 'SDN 2', '1', 81);
-- Ninarama
INSERT INTO user (id, username, email, password, nis, active) VALUES (82, 'ninarama', 'ninarama@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20072, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20072, '99000072', 'Ninarama', 'L', 'Probolinggo', '2006-10-14', 'Jalan Bangka Raya', '0845053315', 'Purwadi', 'Putri', 4938859, 4591551, 'SDN 3', '1', 82);
-- Ramairfan
INSERT INTO user (id, username, email, password, nis, active) VALUES (83, 'ramairfan', 'ramairfan@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20073,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20073, '99000073', 'Ramairfan', 'L', 'Solok', '2007-10-18', 'Jl. Jend. Sudirman', '0825634216', 'Teddy', 'Ani', 5871480, 4360140, 'SDN 1', '1', 83);
-- Ramajoko
INSERT INTO user (id, username, email, password, nis, active) VALUES (84, 'ramajoko', 'ramajoko@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20074, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20074, '99000074', 'Ramajoko', 'L', 'Jayapura', '2008-03-06', 'Gang Rajawali Timur', '083036541458', 'Heru', 'Shania', 6446889, 3134638, 'SDN 3', '1', 84);
-- Sitidewi
INSERT INTO user (id, username, email, password, nis, active) VALUES (85, 'sitidewi', 'sitidewi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20075,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20075, '99000075', 'Sitidewi', 'P', 'Bandar Lampung', '2007-06-18', 'Jalan Indragiri', '08196556981', 'Harsana', 'Ratih', 4122986, 3277615, 'SDN 2', '1', 85);
-- Sitimega
INSERT INTO user (id, username, email, password, nis, active) VALUES (86, 'sitimega', 'sitimega@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20076, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20076, '99000076', 'Sitimega', 'P', 'Kota Administrasi Jakarta Pusat', '2006-11-09', 'Jalan M.T Haryono', '0835615951', 'Najib', 'Ifa', 3891820, 5749109, 'SDN Tegal', '1', 86);
-- Tarinina
INSERT INTO user (id, username, email, password, nis, active) VALUES (87, 'tarinina', 'tarinina@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20077,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20077, '99000077', 'Tarinina', 'P', 'Surakarta', '2009-12-14', 'Gang PHH. Mustofa', '0823662994', 'Halim', 'Pia', 6710630, 6835890, 'SDN Tegal', '1', 87);
-- Tariwulan
INSERT INTO user (id, username, email, password, nis, active) VALUES (88, 'tariwulan', 'tariwulan@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20078, 1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20078, '99000078', 'Tariwulan', 'L', 'Langsa', '2008-12-02', 'Gg. Indragiri', '087773872148', 'Mujur', 'Siska', 4110987, 3585652, 'SDN 2', '1', 88);
-- Wahyudewi
INSERT INTO user (id, username, email, password, nis, active) VALUES (89, 'wahyudewi', 'wahyudewi@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20079,1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20079, '99000079', 'Wahyudewi', 'P', 'Bekasi', '2008-06-23', 'Jalan Kiaracondong', '0839791769', 'Dagel', 'Tina', 6133203, 5451931, 'SDN Tegal', '1', 89);
-- Wulandina
INSERT INTO user (id, username, email, password, nis, active) VALUES (90, 'wulandina', 'wulandina@mail.com', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa',20080,  1);
INSERT INTO siswa (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`, `user_id`) VALUES (20080, '99000080', 'Wulandina', 'P', 'Payakumbuh', '2009-11-17', 'Jl. Suryakencana', '08163287083', 'Vero', 'Zizi', 4518323, 3919897, 'SDN 2', '1', 90);
-- Tambahan jika belum ada data referensi

INSERT IGNORE INTO semester (id_semester, semester) VALUES (0, 'Genap');
INSERT IGNORE INTO tahun_akademik (id_tahun_akademik, tahun_akademik) VALUES (6, '2024/2025');
INSERT IGNORE INTO mapel (id_mapel, nama_mapel) VALUES ('MTK', 'Matematika');
INSERT IGNORE INTO guru (nip, nama) VALUES ('198005122020041001', 'Pak Guru');
INSERT IGNORE INTO kelas (id_kelas, nama_kelas) VALUES ('7a', '7A');
INSERT IGNORE INTO keterangan (id_keterangan, keterangan) VALUES ('1', 'Hadir');

-- Seeder Data
INSERT INTO ampu_mapel (id_ampu, tanggal, id_semester, id_mapel, nip, id_tahun_akademik) VALUES
(3, '2025-06-25', 0, 'MTK', '198005122020041001', 6);
INSERT INTO kbm (id_kbm, tanggal, materi, sub_materi, id_ampu) VALUES
(5, '2025-06-25', 'Persamaan Linear', 'Pengenalan PLDV', 3);

INSERT INTO ampu_mapel (id_ampu, tanggal, id_semester, id_mapel, nip, id_tahun_akademik) VALUES
(3, '2025-06-25', 0, 'MTK', '198005122020041001', 6);
INSERT INTO kbm (id_kbm, tanggal, materi, sub_materi, id_ampu) VALUES
(5, '2025-06-25', 'Persamaan Linear', 'Pengenalan PLDV', 3);

-- Siswa NIS: 20001
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1001, '2025-05-29', 20001, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20001);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 71.94, '2025-05-01');

INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1002, (SELECT user_id FROM siswa WHERE nis = 20001), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-05-29');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20001', 1002, 20001, (SELECT email FROM user WHERE nis = 20001), 100000, 'settlement', NULL, '2025-05-29');

-- Siswa NIS: 20002
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1002, '2025-06-01', 20002, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20002);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 93.7, '2025-06-01');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1003, (SELECT user_id FROM siswa WHERE nis = 20002), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-01');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20002', 1003, 20002, (SELECT email FROM user WHERE nis = 20002), 100000, 'settlement', NULL, '2025-06-01');

-- Siswa NIS: 20003
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1003, '2025-06-05', 20003, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20003);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 71.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1004, (SELECT user_id FROM siswa WHERE nis = 20003), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20003', 1004, 20003, (SELECT email FROM user WHERE nis = 20003), 100000, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20004
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1004, '2025-06-14', 20004, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20004);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 94.04, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1005, (SELECT user_id FROM siswa WHERE nis = 20004), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20004', 1005, 20004, (SELECT email FROM user WHERE nis = 20004), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20005
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1005, '2025-06-21', 20005, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20005);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 79.14, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1006, (SELECT user_id FROM siswa WHERE nis = 20005), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20005', 1006, 20005, (SELECT email FROM user WHERE nis = 20005), 100000, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20006
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1006, '2025-06-14', 20006, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20006);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 87.71, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1007, (SELECT user_id FROM siswa WHERE nis = 20006), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20006', 1007, 20006, (SELECT email FROM user WHERE nis = 20006), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20007
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1007, '2025-06-14', 20007, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20007);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 70.02, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1008, (SELECT user_id FROM siswa WHERE nis = 20007), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20007', 1008, 20007, (SELECT email FROM user WHERE nis = 20007), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20008
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1008, '2025-06-14', 20008, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20008);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 95.98, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1009, (SELECT user_id FROM siswa WHERE nis = 20008), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20008', 1009, 20008, (SELECT email FROM user WHERE nis = 20008), 100000, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20009
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1009, '2025-05-28', 20009, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20009);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 72.9, '2025-05-28');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1010, (SELECT user_id FROM siswa WHERE nis = 20009), 'Ganjil', '2024/2025', 'SPP Bulanan', 100000, '2025-05-28');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20009', 1010, 20009, (SELECT email FROM user WHERE nis = 20009), 100000, 'settlement', NULL, '2025-05-28');

-- Siswa NIS: 20010
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1010, '2025-06-11', 20010, '7a', 6, '197901172020041006');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20010);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 79.17, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1011, (SELECT user_id FROM siswa WHERE nis = 20010), 'Ganjil', '2024/2025', 'SPP Bulanan', 835294, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20010', 1011, 20010, (SELECT email FROM user WHERE nis = 20010), 835294, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20011
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1011, '2025-05-31', 20011, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20011);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 83.87, '2025-05-31');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1012, (SELECT user_id FROM siswa WHERE nis = 20011), 'Ganjil', '2024/2025', 'SPP Bulanan', 532237, '2025-05-31');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20011', 1012, 20011, (SELECT email FROM user WHERE nis = 20011), 532237, 'settlement', NULL, '2025-05-31');

-- Siswa NIS: 20012
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1012, '2025-06-20', 20012, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20012);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 65.13, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1013, (SELECT user_id FROM siswa WHERE nis = 20012), 'Ganjil', '2024/2025', 'SPP Bulanan', 620692, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20012', 1013, 20012, (SELECT email FROM user WHERE nis = 20012), 620692, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20013
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1013, '2025-06-24', 20013, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20013);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 82.66, '2025-06-24');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1014, (SELECT user_id FROM siswa WHERE nis = 20013), 'Ganjil', '2024/2025', 'SPP Bulanan', 985109, '2025-06-24');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20013', 1014, 20013, (SELECT email FROM user WHERE nis = 20013), 985109, 'settlement', NULL, '2025-06-24');

-- Siswa NIS: 20014
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1014, '2025-06-10', 20014, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20014);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 95.62, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1015, (SELECT user_id FROM siswa WHERE nis = 20014), 'Ganjil', '2024/2025', 'SPP Bulanan', 738238, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20014', 1015, 20014, (SELECT email FROM user WHERE nis = 20014), 738238, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20015
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1015, '2025-06-16', 20015, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20015);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 78.25, '2025-06-16');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1016, (SELECT user_id FROM siswa WHERE nis = 20015), 'Ganjil', '2024/2025', 'SPP Bulanan', 632353, '2025-06-16');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20015', 1016, 20015, (SELECT email FROM user WHERE nis = 20015), 632353, 'settlement', NULL, '2025-06-16');

-- Siswa NIS: 20016
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1016, '2025-06-05', 20016, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20016);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 69.66, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1017, (SELECT user_id FROM siswa WHERE nis = 20016), 'Ganjil', '2024/2025', 'SPP Bulanan', 592007, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20016', 1017, 20016, (SELECT email FROM user WHERE nis = 20016), 592007, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20017
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1017, '2025-06-15', 20017, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20017);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 92.83, '2025-06-15');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1018, (SELECT user_id FROM siswa WHERE nis = 20017), 'Ganjil', '2024/2025', 'SPP Bulanan', 840817, '2025-06-15');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20017', 1018, 20017, (SELECT email FROM user WHERE nis = 20017), 840817, 'settlement', NULL, '2025-06-15');

-- Siswa NIS: 20018
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1018, '2025-06-19', 20018, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20018);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 73.83, '2025-06-19');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1019, (SELECT user_id FROM siswa WHERE nis = 20018), 'Ganjil', '2024/2025', 'SPP Bulanan', 548955, '2025-06-19');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20018', 1019, 20018, (SELECT email FROM user WHERE nis = 20018), 548955, 'settlement', NULL, '2025-06-19');

-- Siswa NIS: 20019
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1019, '2025-06-07', 20019, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20019);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 76.09, '2025-06-07');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1020, (SELECT user_id FROM siswa WHERE nis = 20019), 'Ganjil', '2024/2025', 'SPP Bulanan', 842354, '2025-06-07');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20019', 1020, 20019, (SELECT email FROM user WHERE nis = 20019), 842354, 'settlement', NULL, '2025-06-07');

-- Siswa NIS: 20020
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1020, '2025-06-13', 20020, '7b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20020);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 93.85, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1021, (SELECT user_id FROM siswa WHERE nis = 20020), 'Ganjil', '2024/2025', 'SPP Bulanan', 716834, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20020', 1021, 20020, (SELECT email FROM user WHERE nis = 20020), 716834, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20021
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1021, '2025-06-03', 20021, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20021);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 68.44, '2025-06-03');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1022, (SELECT user_id FROM siswa WHERE nis = 20021), 'Ganjil', '2024/2025', 'SPP Bulanan', 835974, '2025-06-03');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20021', 1022, 20021, (SELECT email FROM user WHERE nis = 20021), 835974, 'settlement', NULL, '2025-06-03');

-- Siswa NIS: 20022
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1022, '2025-06-11', 20022, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20022);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 84.46, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1023, (SELECT user_id FROM siswa WHERE nis = 20022), 'Ganjil', '2024/2025', 'SPP Bulanan', 556549, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20022', 1023, 20022, (SELECT email FROM user WHERE nis = 20022), 556549, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20023
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1023, '2025-05-31', 20023, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20023);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 81.26, '2025-05-31');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1024, (SELECT user_id FROM siswa WHERE nis = 20023), 'Ganjil', '2024/2025', 'SPP Bulanan', 817799, '2025-05-31');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20023', 1024, 20023, (SELECT email FROM user WHERE nis = 20023), 817799, 'settlement', NULL, '2025-05-31');

-- Siswa NIS: 20024
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1024, '2025-06-15', 20024, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20024);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 68.22, '2025-06-15');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1025, (SELECT user_id FROM siswa WHERE nis = 20024), 'Ganjil', '2024/2025', 'SPP Bulanan', 546778, '2025-06-15');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20024', 1025, 20024, (SELECT email FROM user WHERE nis = 20024), 546778, 'settlement', NULL, '2025-06-15');

-- Siswa NIS: 20025
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1025, '2025-06-12', 20025, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20025);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 81.63, '2025-06-12');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1026, (SELECT user_id FROM siswa WHERE nis = 20025), 'Ganjil', '2024/2025', 'SPP Bulanan', 601586, '2025-06-12');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20025', 1026, 20025, (SELECT email FROM user WHERE nis = 20025), 601586, 'settlement', NULL, '2025-06-12');

-- Siswa NIS: 20026
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1026, '2025-06-17', 20026, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20026);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 74.48, '2025-06-17');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1027, (SELECT user_id FROM siswa WHERE nis = 20026), 'Ganjil', '2024/2025', 'SPP Bulanan', 982130, '2025-06-17');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20026', 1027, 20026, (SELECT email FROM user WHERE nis = 20026), 982130, 'settlement', NULL, '2025-06-17');

-- Siswa NIS: 20027
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1027, '2025-06-02', 20027, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20027);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 77.38, '2025-06-02');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1028, (SELECT user_id FROM siswa WHERE nis = 20027), 'Ganjil', '2024/2025', 'SPP Bulanan', 509311, '2025-06-02');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20027', 1028, 20027, (SELECT email FROM user WHERE nis = 20027), 509311, 'settlement', NULL, '2025-06-02');

-- Siswa NIS: 20028
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1028, '2025-05-27', 20028, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20028);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 75.87, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1029, (SELECT user_id FROM siswa WHERE nis = 20028), 'Ganjil', '2024/2025', 'SPP Bulanan', 850290, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20028', 1029, 20028, (SELECT email FROM user WHERE nis = 20028), 850290, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20029
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1029, '2025-06-23', 20029, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20029);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 91.61, '2025-06-23');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1030, (SELECT user_id FROM siswa WHERE nis = 20029), 'Ganjil', '2024/2025', 'SPP Bulanan', 681729, '2025-06-23');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20029', 1030, 20029, (SELECT email FROM user WHERE nis = 20029), 681729, 'settlement', NULL, '2025-06-23');

-- Siswa NIS: 20030
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1030, '2025-06-25', 20030, '7c', 6, '198208202020042002');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20030);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 66.97, '2025-06-25');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1031, (SELECT user_id FROM siswa WHERE nis = 20030), 'Ganjil', '2024/2025', 'SPP Bulanan', 751238, '2025-06-25');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20030', 1031, 20030, (SELECT email FROM user WHERE nis = 20030), 751238, 'settlement', NULL, '2025-06-25');

-- Siswa NIS: 20031
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1031, '2025-06-23', 20031, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20031);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 71.83, '2025-06-23');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1032, (SELECT user_id FROM siswa WHERE nis = 20031), 'Ganjil', '2024/2025', 'SPP Bulanan', 804530, '2025-06-23');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20031', 1032, 20031, (SELECT email FROM user WHERE nis = 20031), 804530, 'settlement', NULL, '2025-06-23');

-- Siswa NIS: 20032
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1032, '2025-06-17', 20032, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20032);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 66.17, '2025-06-17');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1033, (SELECT user_id FROM siswa WHERE nis = 20032), 'Ganjil', '2024/2025', 'SPP Bulanan', 668053, '2025-06-17');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20032', 1033, 20032, (SELECT email FROM user WHERE nis = 20032), 668053, 'settlement', NULL, '2025-06-17');

-- Siswa NIS: 20033
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1033, '2025-06-04', 20033, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20033);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 66.72, '2025-06-04');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1034, (SELECT user_id FROM siswa WHERE nis = 20033), 'Ganjil', '2024/2025', 'SPP Bulanan', 910251, '2025-06-04');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20033', 1034, 20033, (SELECT email FROM user WHERE nis = 20033), 910251, 'settlement', NULL, '2025-06-04');

-- Siswa NIS: 20034
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1034, '2025-06-14', 20034, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20034);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 98.78, '2025-06-14');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1035, (SELECT user_id FROM siswa WHERE nis = 20034), 'Ganjil', '2024/2025', 'SPP Bulanan', 595942, '2025-06-14');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20034', 1035, 20034, (SELECT email FROM user WHERE nis = 20034), 595942, 'settlement', NULL, '2025-06-14');

-- Siswa NIS: 20035
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1035, '2025-06-03', 20035, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20035);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 85.33, '2025-06-03');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1036, (SELECT user_id FROM siswa WHERE nis = 20035), 'Ganjil', '2024/2025', 'SPP Bulanan', 964112, '2025-06-03');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20035', 1036, 20035, (SELECT email FROM user WHERE nis = 20035), 964112, 'settlement', NULL, '2025-06-03');

-- Siswa NIS: 20036
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1036, '2025-05-27', 20036, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20036);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 66.22, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1037, (SELECT user_id FROM siswa WHERE nis = 20036), 'Ganjil', '2024/2025', 'SPP Bulanan', 644343, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20036', 1037, 20036, (SELECT email FROM user WHERE nis = 20036), 644343, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20037
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1037, '2025-06-23', 20037, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20037);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 79.25, '2025-06-23');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1038, (SELECT user_id FROM siswa WHERE nis = 20037), 'Ganjil', '2024/2025', 'SPP Bulanan', 737370, '2025-06-23');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20037', 1038, 20037, (SELECT email FROM user WHERE nis = 20037), 737370, 'settlement', NULL, '2025-06-23');

-- Siswa NIS: 20038
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1038, '2025-06-15', 20038, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20038);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 95.65, '2025-06-15');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1039, (SELECT user_id FROM siswa WHERE nis = 20038), 'Ganjil', '2024/2025', 'SPP Bulanan', 720844, '2025-06-15');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20038', 1039, 20038, (SELECT email FROM user WHERE nis = 20038), 720844, 'settlement', NULL, '2025-06-15');

-- Siswa NIS: 20039
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1039, '2025-06-09', 20039, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20039);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 73.07, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1040, (SELECT user_id FROM siswa WHERE nis = 20039), 'Ganjil', '2024/2025', 'SPP Bulanan', 550330, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20039', 1040, 20039, (SELECT email FROM user WHERE nis = 20039), 550330, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20040
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1040, '2025-06-20', 20040, '8a', 6, '198304072020042005');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20040);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 88.18, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1041, (SELECT user_id FROM siswa WHERE nis = 20040), 'Ganjil', '2024/2025', 'SPP Bulanan', 945391, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20040', 1041, 20040, (SELECT email FROM user WHERE nis = 20040), 945391, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20041
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1041, '2025-05-29', 20041, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20041);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 86.94, '2025-05-29');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1042, (SELECT user_id FROM siswa WHERE nis = 20041), 'Ganjil', '2024/2025', 'SPP Bulanan', 982524, '2025-05-29');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20041', 1042, 20041, (SELECT email FROM user WHERE nis = 20041), 982524, 'settlement', NULL, '2025-05-29');

-- Siswa NIS: 20042
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1042, '2025-06-09', 20042, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20042);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1043, (SELECT user_id FROM siswa WHERE nis = 20042), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20042', 1043, 20042, (SELECT email FROM user WHERE nis = 20042), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20043
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1043, '2025-06-05', 20043, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20043);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1044, (SELECT user_id FROM siswa WHERE nis = 20043), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20043', 1044, 20043, (SELECT email FROM user WHERE nis = 20043), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20044
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1044, '2025-05-27', 20044, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20044);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1045, (SELECT user_id FROM siswa WHERE nis = 20044), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20044', 1045, 20044, (SELECT email FROM user WHERE nis = 20044), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20045
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1045, '2025-06-11', 20045, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20045);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1046, (SELECT user_id FROM siswa WHERE nis = 20045), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20045', 1046, 20045, (SELECT email FROM user WHERE nis = 20045), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20046
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1046, '2025-06-21', 20046, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20046);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1047, (SELECT user_id FROM siswa WHERE nis = 20046), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20046', 1047, 20046, (SELECT email FROM user WHERE nis = 20046), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20047
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1047, '2025-06-20', 20047, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20047);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1048, (SELECT user_id FROM siswa WHERE nis = 20047), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20047', 1048, 20047, (SELECT email FROM user WHERE nis = 20047), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20048
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1048, '2025-06-13', 20048, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20048);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1049, (SELECT user_id FROM siswa WHERE nis = 20048), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20048', 1049, 20048, (SELECT email FROM user WHERE nis = 20048), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20049
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1049, '2025-06-10', 20049, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20049);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1050, (SELECT user_id FROM siswa WHERE nis = 20049), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20049', 1050, 20049, (SELECT email FROM user WHERE nis = 20049), 623384, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20050
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1050, '2025-06-21', 20050, '8b', 6, '198411102020041004');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20050);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 66.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1051, (SELECT user_id FROM siswa WHERE nis = 20050), 'Ganjil', '2024/2025', 'SPP Bulanan', 858372, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20050', 1051, 20050, (SELECT email FROM user WHERE nis = 20050), 858372, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20051
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1051, '2025-06-09', 20051, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20051);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 76.31, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1052, (SELECT user_id FROM siswa WHERE nis = 20051), 'Ganjil', '2024/2025', 'SPP Bulanan', 638958, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20051', 1052, 20051, (SELECT email FROM user WHERE nis = 20051), 638958, 'settlement', NULL, '2025-06-09');


-- Siswa NIS: 20052
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1052, '2025-06-09', 20052, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20052);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1053, (SELECT user_id FROM siswa WHERE nis = 20052), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20052', 1053, 20052, (SELECT email FROM user WHERE nis = 20052), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20053
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1053, '2025-06-05', 20053, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20053);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1054, (SELECT user_id FROM siswa WHERE nis = 20053), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20053', 1054, 20053, (SELECT email FROM user WHERE nis = 20053), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20054
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1054, '2025-05-27', 20054, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20054);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1055, (SELECT user_id FROM siswa WHERE nis = 20054), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20054', 1055, 20054, (SELECT email FROM user WHERE nis = 20054), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20055
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1055, '2025-06-11', 20055, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20055);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1056, (SELECT user_id FROM siswa WHERE nis = 20055), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20055', 1056, 20055, (SELECT email FROM user WHERE nis = 20055), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20056
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1056, '2025-06-21', 20056, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20056);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1057, (SELECT user_id FROM siswa WHERE nis = 20056), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20056', 1057, 20056, (SELECT email FROM user WHERE nis = 20056), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20057
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1057, '2025-06-20', 20057, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20057);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1058, (SELECT user_id FROM siswa WHERE nis = 20057), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20057', 1058, 20057, (SELECT email FROM user WHERE nis = 20057), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20058
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1058, '2025-06-13', 20058, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20058);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1059, (SELECT user_id FROM siswa WHERE nis = 20058), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20058', 1059, 20058, (SELECT email FROM user WHERE nis = 20058), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20059
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1059, '2025-06-10', 20059, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20059);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1060, (SELECT user_id FROM siswa WHERE nis = 20059), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20059', 1060, 20059, (SELECT email FROM user WHERE nis = 20059), 623384, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20060
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1060, '2025-06-21', 20060, '8c', 6, '198502152020042003');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20060);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 66.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1061, (SELECT user_id FROM siswa WHERE nis = 20060), 'Ganjil', '2024/2025', 'SPP Bulanan', 858372, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20060', 1061, 20060, (SELECT email FROM user WHERE nis = 20060), 858372, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20061
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1061, '2025-06-09', 20061, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20061);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 76.31, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1062, (SELECT user_id FROM siswa WHERE nis = 20061), 'Ganjil', '2024/2025', 'SPP Bulanan', 638958, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20061', 1062, 20061, (SELECT email FROM user WHERE nis = 20061), 638958, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20062
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1062, '2025-06-09', 20062, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20062);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1063, (SELECT user_id FROM siswa WHERE nis = 20062), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20062', 1063, 20062, (SELECT email FROM user WHERE nis = 20062), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20063
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1063, '2025-06-05', 20063, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20063);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1064, (SELECT user_id FROM siswa WHERE nis = 20063), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20063', 1064, 20063, (SELECT email FROM user WHERE nis = 20063), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20064
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1064, '2025-05-27', 20064, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20064);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1065, (SELECT user_id FROM siswa WHERE nis = 20064), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20064', 1065, 20064, (SELECT email FROM user WHERE nis = 20064), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20065
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1065, '2025-06-11', 20065, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20065);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1066, (SELECT user_id FROM siswa WHERE nis = 20065), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20065', 1066, 20065, (SELECT email FROM user WHERE nis = 20065), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20066
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1066, '2025-06-21', 20066, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20066);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1067, (SELECT user_id FROM siswa WHERE nis = 20066), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20066', 1067, 20066, (SELECT email FROM user WHERE nis = 20066), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20067
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1067, '2025-06-20', 20067, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20067);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1068, (SELECT user_id FROM siswa WHERE nis = 20067), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20067', 1068, 20067, (SELECT email FROM user WHERE nis = 20067), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20068
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1068, '2025-06-13', 20068, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20068);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1069, (SELECT user_id FROM siswa WHERE nis = 20068), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20068', 1069, 20068, (SELECT email FROM user WHERE nis = 20068), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20069
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1069, '2025-06-10', 20069, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20069);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1070, (SELECT user_id FROM siswa WHERE nis = 20069), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20069', 1070, 20069, (SELECT email FROM user WHERE nis = 20069), 623384, 'settlement', NULL, '2025-06-10');


-- Siswa NIS: 20070
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1070, '2025-06-21', 20070, '9a', 6, '198606052020041007');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20070);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 66.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1071, (SELECT user_id FROM siswa WHERE nis = 20070), 'Ganjil', '2024/2025', 'SPP Bulanan', 858372, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20070', 1071, 20070, (SELECT email FROM user WHERE nis = 20070), 858372, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20071
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1071, '2025-06-09', 20071, '9b', 6, '198005122020041001');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20071);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 76.31, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1072, (SELECT user_id FROM siswa WHERE nis = 20071), 'Ganjil', '2024/2025', 'SPP Bulanan', 638958, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20071', 1072, 20071, (SELECT email FROM user WHERE nis = 20071), 638958, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20072
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1072, '2025-06-09', 20072, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20072);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 69.22, '2025-06-09');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1073, (SELECT user_id FROM siswa WHERE nis = 20072), 'Ganjil', '2024/2025', 'SPP Bulanan', 508087, '2025-06-09');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20072', 1073, 20072, (SELECT email FROM user WHERE nis = 20072), 508087, 'settlement', NULL, '2025-06-09');

-- Siswa NIS: 20073
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1073, '2025-06-05', 20073, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20073);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 79.58, '2025-06-05');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1074, (SELECT user_id FROM siswa WHERE nis = 20073), 'Ganjil', '2024/2025', 'SPP Bulanan', 712226, '2025-06-05');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20073', 1074, 20073, (SELECT email FROM user WHERE nis = 20073), 712226, 'settlement', NULL, '2025-06-05');

-- Siswa NIS: 20074
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1074, '2025-05-27', 20074, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20074);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 92.14, '2025-05-27');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1075, (SELECT user_id FROM siswa WHERE nis = 20074), 'Ganjil', '2024/2025', 'SPP Bulanan', 828073, '2025-05-27');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20074', 1075, 20074, (SELECT email FROM user WHERE nis = 20074), 828073, 'settlement', NULL, '2025-05-27');

-- Siswa NIS: 20075
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1075, '2025-06-11', 20075, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20075);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 68.61, '2025-06-11');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1076, (SELECT user_id FROM siswa WHERE nis = 20075), 'Ganjil', '2024/2025', 'SPP Bulanan', 623021, '2025-06-11');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20075', 1076, 20075, (SELECT email FROM user WHERE nis = 20075), 623021, 'settlement', NULL, '2025-06-11');

-- Siswa NIS: 20076
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1076, '2025-06-21', 20076, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20076);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 92.65, '2025-06-21');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1077, (SELECT user_id FROM siswa WHERE nis = 20076), 'Ganjil', '2024/2025', 'SPP Bulanan', 978854, '2025-06-21');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20076', 1077, 20076, (SELECT email FROM user WHERE nis = 20076), 978854, 'settlement', NULL, '2025-06-21');

-- Siswa NIS: 20077
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1077, '2025-06-20', 20077, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20077);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 99.04, '2025-06-20');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1078, (SELECT user_id FROM siswa WHERE nis = 20077), 'Ganjil', '2024/2025', 'SPP Bulanan', 620941, '2025-06-20');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20077', 1078, 20077, (SELECT email FROM user WHERE nis = 20077), 620941, 'settlement', NULL, '2025-06-20');

-- Siswa NIS: 20078
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1078, '2025-06-13', 20078, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20078);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 87.11, '2025-06-13');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1079, (SELECT user_id FROM siswa WHERE nis = 20078), 'Ganjil', '2024/2025', 'SPP Bulanan', 517879, '2025-06-13');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20078', 1079, 20078, (SELECT email FROM user WHERE nis = 20078), 517879, 'settlement', NULL, '2025-06-13');

-- Siswa NIS: 20079
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1079, '2025-06-10', 20079, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20079);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1080, (SELECT user_id FROM siswa WHERE nis = 20079), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20079', 1080, 20079, (SELECT email FROM user WHERE nis = 20079), 623384, 'settlement', NULL, '2025-06-10');

-- Siswa NIS: 20080
INSERT INTO pembagian_kelas (id_pembagian, tanggal, nis, id_kelas, id_tahun_akademik, nip) VALUES (1080, '2025-06-10', 20080, '9b', 6, '199012302020042008');
INSERT INTO kehadiran (id_keterangan, id_kbm, nis) VALUES ('1', 5, 20080);
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 91.04, '2025-06-10');
INSERT INTO tagihan (id_tagihan, user_id, semester, tahun_ajaran, deskripsi, total, created_at) VALUES (1081, (SELECT user_id FROM siswa WHERE nis = 20080), 'Ganjil', '2024/2025', 'SPP Bulanan', 623384, '2025-06-10');
INSERT INTO transaksi (kode_order, id_tagihan, nis, email, total, status, fraud_status, created_at) VALUES ('ORD20080', 1081, 20080, (SELECT email FROM user WHERE nis = 20080), 623384, 'settlement', NULL, '2025-06-10');


INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 70.15, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 69.2, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 69.84, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 87.77, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UH', 80.06, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 77.17, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 75.82, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 75.0, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 68.2, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 70.84, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 85.29, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 84.54, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 80.72, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 66.18, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'Tugas', 74.59, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UTS', 85.7, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20001, 3, 'UAS', 73.87, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 74.76, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 72.66, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 81.47, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 65.88, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UH', 73.14, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 73.57, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 83.02, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 81.68, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 86.0, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 89.6, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 89.59, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 77.61, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 88.85, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 73.8, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'Tugas', 86.73, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UTS', 77.39, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20002, 3, 'UAS', 84.51, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 67.99, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 88.21, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 71.4, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 76.13, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UH', 83.95, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 84.02, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 70.29, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 74.18, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 71.6, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 82.81, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 80.21, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 82.95, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 75.61, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 89.8, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'Tugas', 76.64, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UTS', 70.8, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20003, 3, 'UAS', 73.41, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 79.7, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 72.65, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 89.33, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 89.35, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UH', 76.88, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 85.69, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 78.48, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 65.34, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 66.0, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 74.93, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 70.53, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 83.31, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 89.37, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 73.77, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'Tugas', 78.27, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UTS', 74.86, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20004, 3, 'UAS', 66.84, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 80.32, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 76.05, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 88.56, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 69.94, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UH', 76.02, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 70.23, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 72.0, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 84.16, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 73.46, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 84.36, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 82.06, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 75.61, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 89.93, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 69.74, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'Tugas', 74.39, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UTS', 83.0, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20005, 3, 'UAS', 86.17, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 75.59, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 87.13, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 76.6, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 73.75, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UH', 71.78, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 70.18, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 70.6, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 83.18, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 74.27, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 89.51, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 80.56, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 79.54, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 82.97, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 81.63, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'Tugas', 84.23, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UTS', 66.69, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20006, 3, 'UAS', 78.06, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 78.03, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 79.7, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 73.0, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 85.62, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UH', 66.82, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 67.78, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 74.7, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 82.22, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 66.31, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 70.85, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 83.23, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 75.32, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 82.03, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 73.61, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'Tugas', 79.48, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UTS', 67.79, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20007, 3, 'UAS', 72.0, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 73.04, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 79.74, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 87.65, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 71.49, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UH', 83.79, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 76.55, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 69.58, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 84.32, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 69.77, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 66.42, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 69.8, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 67.11, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 88.8, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 88.01, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'Tugas', 79.35, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UTS', 80.62, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20008, 3, 'UAS', 82.2, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 68.3, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 66.82, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 68.69, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 76.97, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UH', 68.23, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 86.77, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 85.78, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 69.35, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 79.2, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 84.76, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 87.44, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 82.93, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 82.81, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 69.37, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'Tugas', 86.21, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UTS', 66.35, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20009, 3, 'UAS', 66.7, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 70.02, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 84.06, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 74.4, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 72.39, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UH', 80.42, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 68.38, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 70.31, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 87.38, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 83.11, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 85.86, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 66.78, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 88.22, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 89.31, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 83.49, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'Tugas', 74.64, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UTS', 88.8, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20010, 3, 'UAS', 80.32, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 74.57, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 81.23, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 82.29, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 86.83, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UH', 88.62, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 73.62, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 80.38, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 75.88, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 78.07, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 73.25, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 71.99, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 66.29, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 74.93, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 71.24, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'Tugas', 67.54, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UTS', 67.07, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20011, 3, 'UAS', 76.61, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 73.64, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 70.37, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 79.99, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 75.01, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UH', 70.88, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 89.45, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 74.35, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 66.44, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 86.12, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 81.24, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 73.42, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 89.32, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 87.26, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 71.49, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'Tugas', 79.74, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UTS', 73.1, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20012, 3, 'UAS', 71.59, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 81.3, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 71.64, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 72.12, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 69.74, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UH', 88.48, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 65.47, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 81.18, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 76.65, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 86.91, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 66.12, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 73.78, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 73.5, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 79.41, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 85.64, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'Tugas', 72.19, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UTS', 70.58, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20013, 3, 'UAS', 78.92, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 73.44, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 68.86, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 75.85, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 65.66, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UH', 85.71, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 84.65, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 86.49, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 87.45, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 89.89, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 87.71, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 74.32, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 69.9, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 71.28, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 76.41, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'Tugas', 71.5, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UTS', 80.88, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20014, 3, 'UAS', 82.93, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 80.0, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 75.94, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 71.74, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 88.61, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UH', 84.74, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 78.89, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 83.36, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 82.88, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 89.35, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 82.58, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 84.06, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 83.83, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 84.67, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 66.5, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'Tugas', 84.26, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UTS', 78.47, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20015, 3, 'UAS', 80.69, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 85.94, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 77.22, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 79.7, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 65.38, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UH', 85.87, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 85.1, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 88.5, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 86.83, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 65.8, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 84.89, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 76.75, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 81.19, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 73.35, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 75.26, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'Tugas', 67.81, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UTS', 80.51, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20016, 3, 'UAS', 75.8, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 75.93, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 79.26, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 73.2, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 78.94, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UH', 67.55, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 71.82, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 71.37, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 86.15, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 87.71, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 86.62, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 71.68, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 68.61, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 82.46, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 66.71, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'Tugas', 84.07, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UTS', 89.19, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20017, 3, 'UAS', 71.73, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 74.16, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 68.12, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 77.54, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 68.01, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UH', 83.25, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 76.83, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 70.95, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 71.26, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 65.78, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 79.97, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 75.79, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 89.8, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 81.79, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 75.53, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'Tugas', 77.01, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UTS', 67.63, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20018, 3, 'UAS', 78.15, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 81.45, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 80.89, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 74.53, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 87.05, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UH', 79.55, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 78.18, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 78.8, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 83.84, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 84.38, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 72.49, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 75.88, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 73.02, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 69.41, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 89.87, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'Tugas', 69.3, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UTS', 66.72, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20019, 3, 'UAS', 72.53, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 74.68, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 72.73, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 74.72, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 78.45, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UH', 66.07, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 77.11, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 68.17, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 83.39, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 76.05, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 67.05, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 66.45, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 76.31, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 80.74, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 69.71, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'Tugas', 84.71, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UTS', 87.68, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20020, 3, 'UAS', 89.73, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 79.11, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 76.02, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 80.9, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 71.1, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UH', 67.18, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 65.36, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 76.12, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 72.32, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 66.0, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 87.95, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 67.94, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 68.02, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 72.4, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 74.05, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'Tugas', 88.78, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UTS', 75.59, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20021, 3, 'UAS', 80.92, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 69.65, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 70.66, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 65.59, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 77.23, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UH', 83.69, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 78.41, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 71.53, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 69.49, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 88.91, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 69.2, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 74.0, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 88.47, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 69.95, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 67.3, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'Tugas', 66.74, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UTS', 73.72, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20022, 3, 'UAS', 79.0, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 65.8, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 72.44, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 66.37, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 66.19, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UH', 82.63, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 70.7, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 65.49, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 72.16, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 67.3, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 65.98, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 84.05, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 68.88, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 71.01, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 69.02, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'Tugas', 85.42, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UTS', 77.16, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20023, 3, 'UAS', 67.95, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 74.03, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 79.32, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 85.12, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 77.93, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UH', 83.6, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 78.93, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 79.79, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 67.74, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 71.44, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 77.53, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 71.7, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 88.5, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 67.51, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 87.76, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'Tugas', 82.91, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UTS', 82.76, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20024, 3, 'UAS', 84.53, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 71.04, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 81.26, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 66.37, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 80.86, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UH', 88.6, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 82.81, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 71.13, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 88.2, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 77.67, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 66.34, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 72.38, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 78.07, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 69.73, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 71.96, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'Tugas', 78.12, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UTS', 73.69, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20025, 3, 'UAS', 86.34, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 81.75, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 70.34, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 78.25, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 87.61, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UH', 75.83, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 65.54, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 74.89, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 79.59, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 88.6, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 85.49, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 75.14, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 88.1, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 77.44, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 83.07, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'Tugas', 80.84, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UTS', 68.93, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20026, 3, 'UAS', 72.09, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 76.46, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 78.2, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 81.44, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 86.17, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UH', 83.64, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 73.46, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 70.16, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 70.7, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 78.75, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 78.6, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 70.29, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 75.81, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 89.98, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 88.24, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'Tugas', 71.32, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UTS', 72.08, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20027, 3, 'UAS', 88.33, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 81.94, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 83.18, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 65.36, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 84.11, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UH', 77.38, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 82.33, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 84.14, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 67.92, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 89.62, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 82.38, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 82.11, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 70.15, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 88.22, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 74.12, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'Tugas', 70.41, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UTS', 89.43, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20028, 3, 'UAS', 89.21, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 68.56, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 65.14, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 75.07, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 80.86, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UH', 89.27, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 73.94, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 85.01, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 86.13, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 67.3, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 82.39, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 72.61, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 81.1, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 74.84, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 83.35, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'Tugas', 74.56, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UTS', 78.89, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20029, 3, 'UAS', 73.93, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 84.85, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 74.82, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 74.28, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 85.04, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UH', 67.75, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 77.52, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 87.44, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 79.5, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 87.14, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 71.92, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 77.87, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 81.09, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 70.68, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 80.98, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'Tugas', 72.3, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UTS', 83.06, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20030, 3, 'UAS', 77.06, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 70.33, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 83.22, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 87.78, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 77.83, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UH', 75.0, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 67.83, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 85.05, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 73.77, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 75.12, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 85.0, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 72.83, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 88.69, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 84.6, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 67.61, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'Tugas', 75.81, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UTS', 83.29, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20031, 3, 'UAS', 76.03, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 76.31, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 87.92, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 79.01, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 84.58, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UH', 80.02, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 86.87, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 82.54, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 67.24, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 79.23, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 70.2, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 84.0, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 68.16, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 87.94, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 68.15, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'Tugas', 80.6, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UTS', 74.88, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20032, 3, 'UAS', 84.5, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 80.02, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 70.43, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 68.45, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 81.53, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UH', 78.51, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 66.78, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 67.03, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 80.18, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 65.55, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 68.14, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 86.95, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 78.12, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 86.22, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 76.25, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'Tugas', 82.81, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UTS', 84.95, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20033, 3, 'UAS', 85.39, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 79.92, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 89.57, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 87.25, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 85.77, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UH', 76.61, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 77.53, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 88.46, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 87.75, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 86.66, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 84.74, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 74.85, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 75.59, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 76.58, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 84.06, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'Tugas', 73.12, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UTS', 78.88, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20034, 3, 'UAS', 73.75, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 74.78, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 85.69, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 86.72, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 79.18, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UH', 67.01, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 83.63, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 77.16, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 87.29, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 82.25, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 71.03, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 72.15, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 69.08, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 74.25, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 69.95, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'Tugas', 75.15, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UTS', 66.64, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20035, 3, 'UAS', 67.91, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 65.22, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 76.57, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 85.02, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 75.76, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UH', 72.22, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 83.01, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 66.66, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 89.01, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 75.01, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 89.6, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 71.24, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 66.14, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 80.22, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 87.28, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'Tugas', 71.64, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UTS', 88.23, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20036, 3, 'UAS', 84.3, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 77.93, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 70.81, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 79.77, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 70.11, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UH', 81.78, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 70.86, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 88.28, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 79.87, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 65.94, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 80.64, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 88.69, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 89.06, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 80.84, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 85.54, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'Tugas', 74.06, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UTS', 87.45, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20037, 3, 'UAS', 75.22, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 89.13, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 80.55, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 67.61, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 72.88, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UH', 87.43, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 86.82, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 77.38, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 85.03, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 74.86, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 83.13, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 84.19, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 81.93, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 70.59, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 70.99, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'Tugas', 87.49, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UTS', 75.36, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20038, 3, 'UAS', 66.71, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 84.72, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 80.15, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 88.76, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 82.46, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UH', 68.19, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 89.74, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 79.58, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 80.86, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 81.8, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 78.3, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 85.64, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 84.5, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 86.92, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 77.6, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'Tugas', 88.11, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UTS', 89.34, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20039, 3, 'UAS', 68.79, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 75.57, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 73.74, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 76.22, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 79.48, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UH', 69.77, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 89.06, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 88.45, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 70.32, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 79.36, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 82.34, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 79.79, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 77.1, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 77.29, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 73.02, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'Tugas', 88.75, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UTS', 66.12, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20040, 3, 'UAS', 72.74, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 74.24, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 89.35, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 68.32, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 89.41, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UH', 73.61, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 69.88, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 82.98, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 88.34, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 68.36, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 73.02, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 74.14, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 84.55, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 74.87, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 72.62, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'Tugas', 73.54, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UTS', 69.73, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20041, 3, 'UAS', 84.23, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 81.06, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 72.91, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 88.21, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 77.95, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UH', 70.28, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 79.97, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 75.11, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 82.2, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 68.41, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 89.18, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 68.27, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 72.27, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 73.33, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 67.97, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'Tugas', 70.95, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UTS', 82.72, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20042, 3, 'UAS', 88.5, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 71.0, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 78.4, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 89.23, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 68.27, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UH', 81.14, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 82.33, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 68.43, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 65.8, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 65.45, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 81.39, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 89.93, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 70.74, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 70.18, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 72.7, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'Tugas', 69.5, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UTS', 87.58, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20043, 3, 'UAS', 71.2, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 74.0, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 76.99, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 67.13, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 70.61, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UH', 75.36, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 79.98, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 65.27, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 69.07, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 71.38, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 89.24, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 78.48, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 85.32, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 73.54, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 68.84, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'Tugas', 68.51, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UTS', 82.52, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20044, 3, 'UAS', 71.98, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 82.51, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 86.09, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 70.94, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 84.28, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UH', 84.33, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 66.28, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 77.83, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 79.11, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 79.2, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 83.65, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 73.43, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 67.62, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 84.9, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 67.75, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'Tugas', 87.98, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UTS', 86.35, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20045, 3, 'UAS', 81.2, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 70.61, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 79.82, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 80.52, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 70.39, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UH', 68.1, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 84.3, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 84.27, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 75.36, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 79.1, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 66.63, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 78.28, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 76.54, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 86.43, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 71.58, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'Tugas', 73.86, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UTS', 85.36, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20046, 3, 'UAS', 87.59, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 88.49, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 76.06, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 83.72, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 89.56, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UH', 88.95, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 83.24, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 73.72, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 87.76, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 66.53, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 77.12, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 69.89, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 68.82, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 75.65, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 75.05, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'Tugas', 72.85, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UTS', 79.15, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20047, 3, 'UAS', 70.28, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 76.48, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 65.77, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 76.55, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 83.44, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UH', 86.31, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 70.91, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 77.71, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 76.08, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 89.33, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 66.02, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 70.86, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 72.46, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 81.42, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 79.66, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'Tugas', 68.83, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UTS', 86.28, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20048, 3, 'UAS', 83.87, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 89.33, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 76.54, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 83.63, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 79.86, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UH', 81.23, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 79.8, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 78.75, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 65.29, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 70.45, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 73.62, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 75.71, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 81.42, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 66.1, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 71.02, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'Tugas', 71.41, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UTS', 75.82, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20049, 3, 'UAS', 70.33, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 75.96, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 69.94, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 69.69, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 89.51, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UH', 72.83, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 76.87, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 75.64, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 74.66, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 66.77, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 88.88, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 84.61, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 86.6, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 86.34, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 80.46, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'Tugas', 80.63, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UTS', 89.73, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20050, 3, 'UAS', 74.29, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 87.12, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 71.95, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 78.0, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 69.21, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UH', 86.48, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 74.6, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 76.38, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 81.3, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 66.92, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 84.96, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 83.66, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 75.64, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 65.07, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 75.1, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'Tugas', 87.0, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UTS', 70.7, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20051, 3, 'UAS', 75.84, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 65.19, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 82.99, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 67.71, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 66.07, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UH', 71.69, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 73.81, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 65.11, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 73.86, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 69.51, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 66.82, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 69.52, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 87.29, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 65.94, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 82.42, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'Tugas', 87.28, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UTS', 87.94, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20052, 3, 'UAS', 78.32, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 88.98, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 75.49, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 80.85, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 76.26, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UH', 81.87, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 76.76, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 88.04, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 82.79, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 80.92, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 71.95, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 72.77, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 72.82, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 77.92, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 85.07, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'Tugas', 77.94, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UTS', 75.71, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20053, 3, 'UAS', 83.21, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 73.16, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 74.01, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 75.46, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 85.61, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UH', 66.98, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 73.61, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 87.7, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 82.83, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 67.65, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 78.57, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 77.6, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 74.83, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 71.23, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 81.47, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'Tugas', 88.82, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UTS', 73.83, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20054, 3, 'UAS', 71.08, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 74.44, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 75.01, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 82.82, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 88.11, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UH', 89.28, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 79.09, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 79.54, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 86.89, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 84.77, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 71.4, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 71.06, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 81.57, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 82.24, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 68.83, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'Tugas', 85.0, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UTS', 88.87, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20055, 3, 'UAS', 66.24, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 79.36, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 83.59, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 80.8, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 67.82, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UH', 85.42, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 82.56, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 73.75, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 83.7, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 72.29, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 68.46, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 71.9, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 78.95, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 82.67, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 65.09, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'Tugas', 86.12, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UTS', 65.15, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20056, 3, 'UAS', 68.42, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 81.16, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 79.16, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 67.69, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 81.31, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UH', 69.29, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 76.32, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 88.63, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 72.06, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 76.56, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 71.06, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 87.18, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 79.84, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 71.87, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 70.82, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'Tugas', 76.16, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UTS', 79.19, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20057, 3, 'UAS', 73.35, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 76.5, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 85.43, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 69.07, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 77.21, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UH', 80.11, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 85.2, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 69.37, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 88.56, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 82.39, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 86.92, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 66.95, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 66.12, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 83.14, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 82.51, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'Tugas', 80.54, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UTS', 68.52, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20058, 3, 'UAS', 85.64, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 81.34, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 77.14, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 77.07, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 76.77, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UH', 78.15, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 82.01, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 77.78, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 81.68, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 85.51, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 69.79, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 67.53, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 80.2, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 85.23, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 78.15, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'Tugas', 70.71, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UTS', 84.17, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20059, 3, 'UAS', 80.72, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 74.42, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 89.82, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 89.45, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 71.96, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UH', 68.39, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 86.27, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 83.37, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 72.3, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 70.06, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 66.3, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 67.66, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 69.01, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 81.03, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 72.9, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'Tugas', 70.44, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UTS', 88.55, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20060, 3, 'UAS', 88.68, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 83.02, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 66.34, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 88.21, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 80.47, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UH', 89.31, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 89.9, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 85.95, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 69.62, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 70.03, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 88.13, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 80.57, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 82.21, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 75.01, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 73.93, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'Tugas', 84.8, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UTS', 84.97, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20061, 3, 'UAS', 89.78, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 79.02, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 84.53, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 78.0, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 66.72, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UH', 86.32, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 72.17, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 72.43, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 88.02, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 73.62, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 77.59, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 73.23, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 86.73, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 73.2, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 68.43, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'Tugas', 73.14, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UTS', 80.87, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20062, 3, 'UAS', 87.76, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 70.42, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 84.15, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 85.38, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 80.44, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UH', 73.07, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 70.44, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 75.91, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 81.71, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 68.17, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 84.33, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 78.31, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 71.72, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 77.66, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 76.86, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'Tugas', 66.19, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UTS', 66.17, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20063, 3, 'UAS', 70.85, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 84.86, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 89.01, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 65.05, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 87.84, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UH', 87.78, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 73.45, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 77.39, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 81.81, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 68.91, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 83.28, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 75.78, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 84.05, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 80.7, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 71.01, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'Tugas', 89.55, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UTS', 81.16, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20064, 3, 'UAS', 72.04, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 76.44, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 84.26, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 76.48, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 76.84, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UH', 69.02, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 68.98, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 65.2, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 81.02, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 89.98, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 76.44, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 74.59, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 68.88, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 84.54, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 74.65, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'Tugas', 81.29, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UTS', 79.98, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20065, 3, 'UAS', 81.26, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 81.15, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 77.59, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 67.37, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 74.42, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UH', 88.79, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 83.98, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 81.15, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 81.23, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 89.0, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 88.21, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 79.17, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 67.63, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 75.09, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 89.07, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'Tugas', 73.11, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UTS', 82.66, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20066, 3, 'UAS', 89.01, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 78.74, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 68.17, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 81.34, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 88.66, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UH', 80.17, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 74.59, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 77.11, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 89.26, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 73.66, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 73.29, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 69.27, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 85.95, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 82.2, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 77.5, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'Tugas', 89.27, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UTS', 68.91, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20067, 3, 'UAS', 71.03, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 84.34, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 84.64, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 85.25, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 67.14, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UH', 74.54, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 71.07, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 89.48, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 73.03, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 87.89, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 65.58, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 68.95, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 74.48, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 81.69, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 82.27, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'Tugas', 67.66, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UTS', 67.83, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20068, 3, 'UAS', 88.01, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 85.16, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 76.47, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 76.97, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 81.83, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UH', 82.15, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 87.37, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 88.71, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 88.73, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 87.44, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 78.05, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 73.12, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 73.18, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 82.91, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 82.2, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'Tugas', 67.43, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UTS', 82.21, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20069, 3, 'UAS', 78.73, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 77.98, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 67.51, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 78.49, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 87.29, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UH', 83.65, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 70.09, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 69.66, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 84.5, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 78.17, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 84.97, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 68.29, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 78.56, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 66.18, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 73.28, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'Tugas', 84.34, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UTS', 72.06, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20070, 3, 'UAS', 76.52, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 73.05, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 87.74, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 74.67, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 75.9, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UH', 83.25, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 77.27, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 69.61, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 82.26, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 75.84, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 71.41, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 77.44, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 89.46, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 86.01, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 77.46, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'Tugas', 74.74, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UTS', 86.08, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20071, 3, 'UAS', 72.63, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 67.24, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 84.41, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 87.56, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 87.95, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UH', 71.94, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 79.84, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 80.44, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 79.21, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 66.9, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 67.97, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 73.26, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 68.16, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 79.29, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 74.47, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'Tugas', 79.41, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UTS', 87.73, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20072, 3, 'UAS', 87.23, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 69.09, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 77.78, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 89.52, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 71.9, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UH', 85.79, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 85.77, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 78.35, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 85.13, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 73.28, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 78.42, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 73.3, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 73.65, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 71.94, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 78.07, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'Tugas', 66.62, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UTS', 78.07, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20073, 3, 'UAS', 76.6, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 87.99, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 82.4, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 66.42, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 79.16, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UH', 78.3, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 75.3, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 67.0, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 83.4, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 88.27, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 71.79, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 80.07, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 82.93, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 74.78, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 66.98, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'Tugas', 74.2, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UTS', 76.11, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20074, 3, 'UAS', 84.32, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 73.56, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 70.98, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 76.97, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 89.34, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UH', 72.94, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 75.14, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 77.57, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 74.74, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 71.87, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 71.64, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 77.83, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 84.15, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 87.24, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 85.55, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'Tugas', 83.32, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UTS', 68.37, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20075, 3, 'UAS', 77.71, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 84.34, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 67.79, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 89.51, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 69.82, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UH', 74.88, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 74.68, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 74.81, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 80.74, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 74.78, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 78.96, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 78.11, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 79.63, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 77.24, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 88.8, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'Tugas', 68.55, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UTS', 79.82, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20076, 3, 'UAS', 66.07, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 75.2, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 70.83, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 78.2, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 65.25, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UH', 85.33, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 71.85, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 89.14, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 67.67, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 89.64, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 71.38, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 79.76, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 84.31, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 68.24, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 85.23, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'Tugas', 66.91, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UTS', 76.91, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20077, 3, 'UAS', 66.65, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 88.93, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 66.19, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 65.63, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 65.74, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UH', 84.83, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 76.57, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 86.48, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 88.66, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 84.57, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 74.84, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 80.64, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 86.44, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 65.9, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 80.92, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'Tugas', 69.9, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UTS', 79.81, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20078, 3, 'UAS', 86.29, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 76.77, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 76.12, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 78.85, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 69.56, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UH', 73.52, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 76.79, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 82.11, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 85.88, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 65.16, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 70.53, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 85.07, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 82.39, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 66.81, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 73.86, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'Tugas', 86.13, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UTS', 75.69, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20079, 3, 'UAS', 83.98, '2025-06-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 79.98, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 84.35, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 72.63, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 78.02, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UH', 82.34, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 67.22, '2025-05-01');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 81.46, '2025-05-07');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 69.37, '2025-05-14');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 70.51, '2025-05-21');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 65.35, '2025-05-28');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 88.58, '2025-05-05');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 66.32, '2025-05-11');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 65.03, '2025-05-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 78.47, '2025-05-25');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'Tugas', 76.25, '2025-05-30');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UTS', 86.47, '2025-04-18');
INSERT INTO penilaian (nis, id_ampu, jenis_penilaian, nilai, tanggal) VALUES (20080, 3, 'UAS', 78.36, '2025-06-25');


COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
