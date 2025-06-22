-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 21, 2025 at 06:33 PM
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

INSERT INTO `ampu_mapel` (`id_ampu`, `tanggal`, `id_semester`, `id_mapel`, `nip`, `id_tahun_akademik`, `id_pembagian`) VALUES
(1, '2025-05-02', '0', 'BI', '198005122020041001', '1', 1),
(2, '2025-07-02', '1', 'BI', '198005122020041001', '1', 2);

--
-- Dumping data for table `berita`
--

INSERT INTO `berita` (`id_berita`, `judul`, `isi`, `nip`) VALUES
(1, 'pengumuan pembagian kelas', 'seluruh orang tua diharapkan mengantar anaknya sampe kedepan sekolah jangan telat ada apel', '198005122020041001');

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

INSERT INTO `kbm` (`id_kbm`, `tanggal`, `materi`, `sub_materi`, `id_ampu`) VALUES
(1, '2025-05-04', 'membuat cerpen', NULL, 1),
(2, '2025-06-10', 'nedkjsewfn', NULL, 2),
(3, '2025-06-10', 'wiqendioqw', NULL, 2),
(4, '2025-06-10', 'blablabla', NULL, 1);

--
-- Dumping data for table `kehadiran`
--

INSERT INTO `kehadiran` (`id_kehadiran`, `id_keterangan`, `id_kbm`, `nis`) VALUES
(1, '1', 1, 20001),
(3, '3', 2, 20001),
(4, '3', 2, 20001),
(5, '0', 2, 20001),
(6, '3', 2, 20001),
(7, '3', 4, 20001);

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

--
-- Dumping data for table `pembagian_kelas`
--

INSERT INTO `pembagian_kelas` (`id_pembagian`, `tanggal`, `nis`, `id_kelas`, `id_tahun_akademik`, `nip`) VALUES
(1, '2019-07-01', 20001, '7a', '1', '198005122020041001'),
(2, '2020-07-01', 20001, '8a', '2', '198005122020041001'),
(3, '2021-07-01', 20001, '9a', '3', '198208202020042002'),
(5, '2020-07-01', 20025, '7a', '2', '198005122020041001'),
(6, '2021-07-01', 20025, '8a', '3', '198005122020041001'),
(7, '2022-07-01', 20025, '9a', '4', '198208202020042002'),
(8, '2021-07-01', 20050, '7a', '3', '198005122020041001'),
(9, '2022-07-01', 20050, '8a', '4', '198208202020042002'),
(10, '2023-07-01', 20050, '9a', '5', '198502152020042003');

--
-- Dumping data for table `penilaian`
--

INSERT INTO `penilaian` (`id_penilaian`, `tugas`, `uts`, `uas`, `id_ampu`, `nis`) VALUES
(1, 80, 80, 80, 1, 20001),
(2, 90, 90, 90, 2, 20001);

--
-- Dumping data for table `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(3, 'admin'),
(2, 'guru'),
(1, 'murid');

--
-- Dumping data for table `semester`
--

INSERT INTO `semester` (`id_semester`, `semester`) VALUES
('0', 'genap'),
('1', 'ganjil');

--
-- Dumping data for table `siswa`
--

INSERT INTO `siswa` (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `email`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`) VALUES
(20001, '99000001', 'salman alfaridzi', 'L', 'tega;', '2004-05-01', 'balamoa', '08997635673', 'man@gmail.com', 'jokowi', 'kartini', 5000000, 5000000, 'sd balamoa 2', '1'),
(20002, '99000002', 'Ulya Kuswandari SPt', 'L', 'Sorong', '2010-05-04', 'Gg. Monginsidi No. 707, Kupang, BB 73648', '083534174743', 'ulyakuswandarispt0@mail.com', 'Raihan', 'Tari', 5349707, 5567012, 'SDN 46 Tebingtinggi', '1'),
(20003, '99000003', 'Rina Tampubolon', 'P', 'Pagaralam', '2009-04-07', 'Gg. Raya Ujungberung No. 702, Langsa, YO 86622', '081751969992', 'rinatampubolon1@mail.com', 'Rafi', 'Uli', 3903607, 3624521, 'SDN 11 Kota Administrasi Jakar', '1'),
(20004, '99000004', 'Kanda Pradana', 'L', 'Pekanbaru', '2009-07-23', 'Jl. Otto Iskandardinata No. 64, Jayapura, Nusa Tenggara Barat 24069', '086137536812', 'kandapradana2@mail.com', 'Wira', 'Winda', 3022701, 4820059, 'SDN 43 Kota Administrasi Jakar', '1'),
(20005, '99000005', 'Edison Gunawan', 'P', 'Tegal', '2009-08-10', 'Jl. Ahmad Yani No. 8, Magelang, KI 93406', '083919082822', 'edisongunawan3@mail.com', 'Ikin', 'Farhunnisa', 6848812, 4659764, 'SDN 50 Tarakan', '1'),
(20006, '99000006', 'Chelsea Prayoga', 'L', 'Cirebon', '2009-01-29', 'Gang S. Parman No. 12, Pangkalpinang, JI 39077', '088020423937', 'chelseaprayoga4@mail.com', 'Marsito', 'Paris', 4297256, 4545479, 'SDN 7 Makassar', '1'),
(20007, '99000007', 'Wage Prasetyo ST', 'P', 'Bitung', '2008-07-24', 'Jalan Rajawali Timur No. 6, Tangerang, SB 09260', '084806497890', 'wageprasetyost5@mail.com', 'Garan', 'Jessica', 4155649, 4722682, 'SDN 32 Yogyakarta', '1'),
(20008, '99000008', 'Lantar Saputra MKom', 'L', 'Ambon', '2010-07-03', 'Gang Pacuan Kuda No. 27, Pangkalpinang, DI Yogyakarta 80001', '085431568664', 'lantarsaputramkom6@mail.com', 'Kemba', 'Eka', 5406403, 2407788, 'SDN 34 Singkawang', '1'),
(20009, '99000009', 'Usman Nuraini', 'P', 'Kota Administrasi Ja', '2009-09-25', 'Gang BKR No. 5, Semarang, Nusa Tenggara Timur 35573', '084492532959', 'usmannuraini7@mail.com', 'Marsito', 'Lala', 6785452, 3920845, 'SDN 28 Padang Sidempuan', '1'),
(20010, '99000010', 'Jagapati Agustina MFarm', 'L', 'Binjai', '2010-06-17', 'Jalan Medokan Ayu No. 7, Sibolga, Sumatera Selatan 37647', '083527763960', 'jagapatiagustinamfarm8@mail.co', 'Arta', 'Uli', 6918907, 5166908, 'SDN 35 Tegal', '1'),
(20011, '99000011', 'Cinta Kuswandari', 'P', 'Mataram', '2009-05-28', 'Jl. Rajawali Timur No. 453, Sibolga, Bali 24175', '088089610534', 'cintakuswandari9@mail.com', 'Dimaz', 'Zalindra', 6569985, 4664886, 'SDN 19 Pekanbaru', '1'),
(20012, '99000012', 'Kartika Riyanti', 'L', 'Denpasar', '2009-09-27', 'Gg. Cikutra Timur No. 062, Bau-Bau, DI Yogyakarta 45334', '084536944192', 'kartikariyanti10@mail.com', 'Cengkir', 'Kasiyah', 4990166, 5038262, 'SDN 21 Sorong', '1'),
(20013, '99000013', 'Raisa Widodo', 'P', 'Tangerang Selatan', '2010-08-15', 'Gang Cempaka No. 30, Solok, PA 37783', '081396397510', 'raisawidodo11@mail.com', 'Pangeran', 'Yunita', 4705423, 3508738, 'SDN 22 Banjarbaru', '1'),
(20014, '99000014', 'Galuh Situmorang', 'L', 'Semarang', '2010-10-26', 'Jl. Sentot Alibasa No. 2, Kota Administrasi Jakarta Timur, Nusa Tenggara Barat 01193', '082545816729', 'galuhsitumorang12@mail.com', 'Embuh', 'Samiah', 3449626, 3052411, 'SDN 26 Padang', '1'),
(20015, '99000015', 'Martana Saragih', 'P', 'Tebingtinggi', '2010-07-26', 'Gg. Surapati No. 98, Sukabumi, AC 29998', '088936399887', 'martanasaragih13@mail.com', 'Eman', 'Lala', 3966083, 3473204, 'SDN 31 Manado', '1'),
(20016, '99000016', 'Rangga Winarsih', 'L', 'Meulaboh', '2009-01-17', 'Gg. Dipatiukur No. 39, Bandar Lampung, JK 19942', '084529282125', 'ranggawinarsih14@mail.com', 'Galih', 'Patricia', 6837478, 2691268, 'SDN 3 Probolinggo', '1'),
(20017, '99000017', 'g Zizi Mulyani MTI', 'P', 'Pangkalpinang', '2011-04-24', 'Gang Moch. Ramdan No. 46, Palopo, Banten 52629', '081214313519', 'gzizimulyanimti15@mail.com', 'Kardi', 'Yuni', 4206936, 2350061, 'SDN 10 Sabang', '1'),
(20018, '99000018', 'Laksana Pradana', 'L', 'Magelang', '2010-08-25', 'Jalan Gegerkalong Hilir No. 9, Langsa, Kalimantan Selatan 92221', '086693897872', 'laksanapradana16@mail.com', 'Salman', 'Victoria', 5416154, 2789512, 'SDN 48 Semarang', '1'),
(20019, '99000019', 'KH Latif Aniani', 'P', 'Kupang', '2010-08-19', 'Gg. Ahmad Dahlan No. 274, Tebingtinggi, KI 10573', '083307566250', 'khlatifaniani17@mail.com', 'Hartaka', 'Tania', 5005931, 2123075, 'SDN 18 Palopo', '1'),
(20020, '99000020', 'Kezia Wibisono', 'L', 'Bandung', '2008-08-19', 'Jl. Cihampelas No. 979, Pasuruan, Jawa Tengah 81784', '084814416361', 'keziawibisono18@mail.com', 'Bagya', 'Nabila', 5756761, 5657136, 'SDN 26 Prabumulih', '1'),
(20021, '99000021', 'Vanesa Kusumo SPsi', 'P', 'Sorong', '2008-10-30', 'Gg. Asia Afrika No. 26, Denpasar, Banten 49195', '084275504352', 'vanesakusumospsi19@mail.com', 'Opan', 'Kamila', 3917432, 2806700, 'SDN 37 Yogyakarta', '1'),
(20022, '99000022', 'Harsaya Marpaung', 'L', 'Balikpapan', '2009-04-16', 'Gang Veteran No. 310, Kotamobagu, Maluku Utara 66223', '088140977757', 'harsayamarpaung20@mail.com', 'Hasim', 'Tami', 3603660, 5251578, 'SDN 8 Binjai', '1'),
(20023, '99000023', 'Prayoga Winarno SFarm', 'P', 'Kota Administrasi Ja', '2010-07-11', 'Gg. Rawamangun No. 47, Banjarmasin, Gorontalo 35373', '082313505300', 'prayogawinarnosfarm21@mail.com', 'Latif', 'Salimah', 6077157, 2268842, 'SDN 42 Balikpapan', '1'),
(20024, '99000024', 'Drs Safina Gunawan', 'L', 'Salatiga', '2009-10-23', 'Gg. Surapati No. 920, Bau-Bau, NT 48810', '084045189223', 'drssafinagunawan22@mail.com', 'Jagapati', 'Vera', 5088211, 3613787, 'SDN 13 Tangerang', '1'),
(20025, '99000025', 'Kartika Puspasari', 'P', 'Bima', '2009-12-29', 'Gg. Dipenogoro No. 78, Kota Administrasi Jakarta Barat, BB 88025', '088201317217', 'kartikapuspasari23@mail.com', 'Rahman', 'Raina', 5459873, 3163849, 'SDN 18 Kotamobagu', '1'),
(20026, '99000026', 'Garang Winarno', 'L', 'Pagaralam', '2009-05-06', 'Gang Asia Afrika No. 436, Bekasi, SU 63708', '084797990718', 'garangwinarno24@mail.com', 'Margana', 'Diana', 6161251, 4852569, 'SDN 27 Depok', '1'),
(20027, '99000027', 'Tasnim Iswahyudi', 'P', 'Tangerang', '2009-04-29', 'Jl. M.H Thamrin No. 35, Bukittinggi, Jawa Tengah 81492', '088616112822', 'tasnimiswahyudi25@mail.com', 'Darman', 'Maimunah', 4428355, 5684865, 'SDN 25 Langsa', '1'),
(20028, '99000028', 'Mariadi Kusumo', 'L', 'Tegal', '2008-09-09', 'Jl. Ciumbuleuit No. 1, Palopo, Sumatera Selatan 09139', '085585272500', 'mariadikusumo26@mail.com', 'Bagya', 'Gina', 5671742, 5070841, 'SDN 17 Kota Administrasi Jakar', '1'),
(20029, '99000029', 'Drs Puput Jailani', 'P', 'Bandung', '2010-07-28', 'Jl. Ciumbuleuit No. 81, Kendari, Sulawesi Selatan 01776', '081953570877', 'drspuputjailani27@mail.com', 'Lasmono', 'Vera', 6185623, 3210179, 'SDN 10 Kota Administrasi Jakar', '1'),
(20030, '99000030', 'Cemani Natsir', 'L', 'Madiun', '2011-02-15', 'Gang Suniaraja No. 043, Solok, Sumatera Barat 49118', '083764336462', 'cemaninatsir28@mail.com', 'Adikara', 'Latika', 4349769, 3973582, 'SDN 24 Bima', '1'),
(20031, '99000031', 'Maida Narpati', 'P', 'Batu', '2009-04-22', 'Gang KH Amin Jasuta No. 341, Bandar Lampung, BA 55988', '083728872294', 'maidanarpati29@mail.com', 'Cahya', 'Sakura', 5867907, 3099792, 'SDN 36 Kediri', '1'),
(20032, '99000032', 'Vinsen Waluyo', 'L', 'Pagaralam', '2010-05-23', 'Jl. Kutai No. 5, Cimahi, BB 87970', '084027781699', 'vinsenwaluyo30@mail.com', 'Jagapati', 'Maida', 3160534, 2673410, 'SDN 41 Blitar', '1'),
(20033, '99000033', 'Cut Jessica Narpati SIP', 'P', 'Lubuklinggau', '2008-10-01', 'Jalan M.T Haryono No. 19, Purwokerto, YO 89753', '086160290319', 'cutjessicanarpatisip31@mail.co', 'Taswir', 'Vicky', 3513305, 3657289, 'SDN 26 Serang', '1'),
(20034, '99000034', 'Harto Mangunsong', 'L', 'Bandung', '2011-04-01', 'Jl. M.T Haryono No. 651, Ambon, SR 51360', '084502261055', 'hartomangunsong32@mail.com', 'Satya', 'Ika', 4635896, 5513288, 'SDN 5 Padang Sidempuan', '1'),
(20035, '99000035', 'Yani Hartati', 'P', 'Sawahlunto', '2009-10-01', 'Jl. K.H. Wahid Hasyim No. 59, Cimahi, Jawa Timur 64646', '087099346431', 'yanihartati33@mail.com', 'Caket', 'Titin', 3524314, 2928113, 'SDN 7 Bogor', '1'),
(20036, '99000036', 'Zizi Sirait', 'L', 'Bukittinggi', '2010-09-21', 'Jalan Jakarta No. 67, Gorontalo, JB 23386', '084366672746', 'zizisirait34@mail.com', 'Estiawan', 'Iriana', 6417459, 2536301, 'SDN 20 Tangerang', '1'),
(20037, '99000037', 'Sutan Lukita Dongoran', 'P', 'Samarinda', '2010-12-17', 'Gang Rungkut Industri No. 4, Bitung, Aceh 11987', '083662321406', 'sutanlukitadongoran35@mail.com', 'Irsad', 'Victoria', 5768375, 5754281, 'SDN 2 Tangerang Selatan', '1'),
(20038, '99000038', 'Harja Simanjuntak', 'L', 'Malang', '2009-12-12', 'Jalan Suryakencana No. 8, Bandar Lampung, ST 34605', '086216392279', 'harjasimanjuntak36@mail.com', 'Mujur', 'Gasti', 6454944, 2947373, 'SDN 23 Palopo', '1'),
(20039, '99000039', 'Hartana Wahyuni', 'P', 'Kendari', '2009-09-09', 'Jl. Medokan Ayu No. 4, Lhokseumawe, LA 31380', '085799067527', 'hartanawahyuni37@mail.com', 'Dimas', 'Samiah', 5928103, 3324317, 'SDN 13 Pasuruan', '1'),
(20040, '99000040', 'Cindy Anggriawan', 'L', 'Surakarta', '2008-08-04', 'Gang Raya Setiabudhi No. 6, Surakarta, JA 27887', '088805777574', 'cindyanggriawan38@mail.com', 'Balidin', 'Yulia', 5101001, 4202127, 'SDN 10 Kota Administrasi Jakar', '1'),
(20041, '99000041', 'Patricia Prayoga', 'P', 'Tangerang', '2008-06-20', 'Gg. Ir. H. Djuanda No. 03, Sawahlunto, JK 21119', '083206630419', 'patriciaprayoga39@mail.com', 'Kasusra', 'Eva', 6698862, 4788482, 'SDN 45 Palopo', '1'),
(20042, '99000042', 'Carla Irawan', 'L', 'Metro', '2008-12-31', 'Gg. Rajiman No. 6, Depok, NB 90732', '088404643169', 'carlairawan40@mail.com', 'Koko', 'Chelsea', 3006879, 5830031, 'SDN 25 Lubuklinggau', '1'),
(20043, '99000043', 'Gina Hutapea', 'P', 'Madiun', '2009-05-18', 'Gang Rajiman No. 066, Gorontalo, KS 57742', '089197887393', 'ginahutapea41@mail.com', 'Kajen', 'Ghaliyati', 4113120, 5555686, 'SDN 41 Samarinda', '1'),
(20044, '99000044', 'Ulva Wasita', 'L', 'Gorontalo', '2010-09-07', 'Jalan Kebonjati No. 891, Surabaya, DI Yogyakarta 56943', '089085211229', 'ulvawasita42@mail.com', 'Caraka', 'Cici', 5086070, 5086056, 'SDN 24 Denpasar', '1'),
(20045, '99000045', 'Suci Rajata MAk', 'P', 'Metro', '2009-05-02', 'Jalan Raya Setiabudhi No. 23, Bandar Lampung, Sulawesi Selatan 37463', '081883952468', 'sucirajatamak43@mail.com', 'Cemani', 'Diah', 4788210, 3675811, 'SDN 3 Pariaman', '1'),
(20046, '99000046', 'Tri Sirait SE', 'L', 'Madiun', '2008-11-21', 'Gang Jamika No. 5, Tidore Kepulauan, Kalimantan Utara 69645', '083629339450', 'trisiraitse44@mail.com', 'Manah', 'Jamalia', 3791988, 4871070, 'SDN 30 Ternate', '1'),
(20047, '99000047', 'R Hari Mandala', 'P', 'Sabang', '2009-05-24', 'Gg. Ronggowarsito No. 50, Kota Administrasi Jakarta Timur, Jawa Tengah 97130', '089463858417', 'rharimandala45@mail.com', 'Taufan', 'Nabila', 6249401, 3514094, 'SDN 40 Tasikmalaya', '1'),
(20048, '99000048', 'Puti Wulan Kuswoyo SEI', 'L', 'Yogyakarta', '2009-07-28', 'Jalan HOS. Cokroaminoto No. 8, Palu, YO 82011', '088480156629', 'putiwulankuswoyosei46@mail.com', 'Tirtayasa', 'Kayla', 6878563, 5807993, 'SDN 49 Jayapura', '1'),
(20049, '99000049', 'Upik Sihotang', 'P', 'Meulaboh', '2009-06-22', 'Gang Kendalsari No. 119, Tanjungbalai, JK 61131', '083979617784', 'upiksihotang47@mail.com', 'Bajragin', 'Salwa', 3515438, 5753624, 'SDN 43 Metro', '1'),
(20050, '99000050', 'Ir Ayu Purnawati', 'L', 'Padangpanjang', '2009-07-14', 'Jalan Ciumbuleuit No. 2, Batam, KS 56258', '086540159636', 'irayupurnawati48@mail.com', 'Niyaga', 'Ratna', 3015723, 4656067, 'SDN 24 Jambi', '1');

--
-- Dumping data for table `status`
--

INSERT INTO `status` (`id_status`, `status`) VALUES
('0', 'tidak aktif '),
('1', 'aktif');

--
-- Dumping data for table `tagihan`
--

INSERT INTO `tagihan` (`id_tagihan`, `user_email`, `semester`, `tahun_ajaran`, `deskripsi`, `total`, `created_at`) VALUES
(1, 'man@gmail.com', NULL, NULL, 'pembayaran kemah', 100000, NULL),
(2, 'global@system.com', NULL, NULL, 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-03 18:18:53'),
(3, 'global@system.com', NULL, NULL, 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-03 18:18:53'),
(4, 'man@gmail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(5, 'man@gmail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(6, 'ulyakuswandarispt0@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(7, 'ulyakuswandarispt0@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(8, 'rinatampubolon1@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(9, 'rinatampubolon1@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(10, 'kandapradana2@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(11, 'kandapradana2@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(12, 'edisongunawan3@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(13, 'edisongunawan3@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(14, 'chelseaprayoga4@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(15, 'chelseaprayoga4@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(16, 'wageprasetyost5@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(17, 'wageprasetyost5@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(18, 'lantarsaputramkom6@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(19, 'lantarsaputramkom6@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(20, 'usmannuraini7@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(21, 'usmannuraini7@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(22, 'jagapatiagustinamfarm8@mail.co', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(23, 'jagapatiagustinamfarm8@mail.co', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(24, 'cintakuswandari9@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(25, 'cintakuswandari9@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(26, 'kartikariyanti10@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(27, 'kartikariyanti10@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(28, 'raisawidodo11@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(29, 'raisawidodo11@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(30, 'galuhsitumorang12@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(31, 'galuhsitumorang12@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(32, 'martanasaragih13@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(33, 'martanasaragih13@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(34, 'ranggawinarsih14@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(35, 'ranggawinarsih14@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(36, 'gzizimulyanimti15@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(37, 'gzizimulyanimti15@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(38, 'laksanapradana16@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(39, 'laksanapradana16@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(40, 'khlatifaniani17@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(41, 'khlatifaniani17@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(42, 'keziawibisono18@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(43, 'keziawibisono18@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(44, 'vanesakusumospsi19@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(45, 'vanesakusumospsi19@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(46, 'harsayamarpaung20@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(47, 'harsayamarpaung20@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(48, 'prayogawinarnosfarm21@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(49, 'prayogawinarnosfarm21@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(50, 'drssafinagunawan22@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(51, 'drssafinagunawan22@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(52, 'kartikapuspasari23@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(53, 'kartikapuspasari23@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(54, 'garangwinarno24@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(55, 'garangwinarno24@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(56, 'tasnimiswahyudi25@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(57, 'tasnimiswahyudi25@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(58, 'mariadikusumo26@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(59, 'mariadikusumo26@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(60, 'drspuputjailani27@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(61, 'drspuputjailani27@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(62, 'cemaninatsir28@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(63, 'cemaninatsir28@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(64, 'maidanarpati29@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(65, 'maidanarpati29@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(66, 'vinsenwaluyo30@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(67, 'vinsenwaluyo30@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(68, 'cutjessicanarpatisip31@mail.co', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(69, 'cutjessicanarpatisip31@mail.co', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(70, 'hartomangunsong32@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:37'),
(71, 'hartomangunsong32@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:37'),
(72, 'yanihartati33@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(73, 'yanihartati33@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(74, 'zizisirait34@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(75, 'zizisirait34@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(76, 'sutanlukitadongoran35@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(77, 'sutanlukitadongoran35@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(78, 'harjasimanjuntak36@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(79, 'harjasimanjuntak36@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(80, 'hartanawahyuni37@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(81, 'hartanawahyuni37@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(82, 'cindyanggriawan38@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(83, 'cindyanggriawan38@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(84, 'patriciaprayoga39@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(85, 'patriciaprayoga39@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(86, 'carlairawan40@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(87, 'carlairawan40@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(88, 'ginahutapea41@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(89, 'ginahutapea41@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(90, 'ulvawasita42@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(91, 'ulvawasita42@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(92, 'sucirajatamak43@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(93, 'sucirajatamak43@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(94, 'trisiraitse44@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(95, 'trisiraitse44@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(96, 'rharimandala45@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(97, 'rharimandala45@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(98, 'putiwulankuswoyosei46@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(99, 'putiwulankuswoyosei46@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(100, 'upiksihotang47@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(101, 'upiksihotang47@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38'),
(102, 'irayupurnawati48@mail.com', 'Ganjil', '2024/2025', 'SPP Bulanan - Juni 2024/2025 Ganjil', 10000, '2025-06-08 20:07:38'),
(103, 'irayupurnawati48@mail.com', 'Ganjil', '2024/2025', 'Uang Ujian 2024/2025 Ganjil', 1000000, '2025-06-08 20:07:38');

--
-- Dumping data for table `tahun_akademik`
--

INSERT INTO `tahun_akademik` (`id_tahun_akademik`, `tahun_akademik`, `mulai`, `sampai`) VALUES
('1', '2019/2020', '2019-07-01', '2020-06-30'),
('2', '2020/2021', '2020-07-01', '2021-06-30'),
('3', '2021/2022', '2021-07-01', '2022-06-30'),
('4', '2022/2023', '2022-07-01', '2023-06-30'),
('5', '2023/2024', '2023-07-01', '2024-06-30'),
('6', '2024/2025', '2024-07-01', '2025-06-30');

--
-- Dumping data for table `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `kode_order`, `id_tagihan`, `email`, `total`, `status`, `fraud_status`, `created_at`, `updated_at`) VALUES
(1, 'Bla-123', 1, 'man@gmail.com', 100000, 'paid', '0', NULL, NULL);

--
-- Dumping data for table `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `jenis_tugas`, `deskripsi`, `id_mapel`, `nip`) VALUES
(1, 'essai', 'buatlah cerpen maximal 100 kata', 'BI', '198005122020041001');

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `nis`, `nip`, `email`, `active`, `fs_uniquifier`) VALUES
(4, 'man', '$2b$12$N2D4cncbxLazOpAUX1GZnOsbyr7uFCTc41NtbxMgCO6ZGPJFtlHc.', 20001, NULL, 'man@gmail.com', 1, '4a001fc9-812f-44dd-880a-9ddbd86a5c27'),
(5, 'admin', '$2b$12$0CDIw.GPbUrAsVfn4bhbKeEcwjRd.hyAqomQunp1S3gX1tmJvd2mC', NULL, NULL, 'ADMIN@mail.com', 1, '3d512e43-db2c-4df5-8984-d104c1b65d29'),
(6, 'jamar', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, '198005122020041001', 'pakarisW@mial.com', 1, '0f25b888-ab48-43c4-a574-a09bb28f2743'),
(7, 'ulya0', '$2b$12$zmdlJW2byTw/eW.1PQIPQ.0rQyUqoCId6VPyOGeVlLo1mtgNCwtPW', 20002, NULL, 'ulyakuswandarispt0@mail.com', 1, '241a96df-bd1a-4877-acbc-406028b540a6'),
(8, 'rina1', '$2b$12$PixQjsyx0XyoI86eaNMGquAkF9K6t.Z3dcQE.OJWMkLMN3e.sS4vi', 20003, NULL, 'rinatampubolon1@mail.com', 1, 'ec57d2dd-2178-4cf8-b0ee-c9fa6a65097b'),
(9, 'kanda2', '$2b$12$tlKcCB3xg1JiljMslSzgquC/Pn1Mx4wPeWxY4ApLTQWAvnG53uUWq', 20004, NULL, 'kandapradana2@mail.com', 1, 'f4e66a3b-301b-48e7-874f-72b058824fff'),
(10, 'edison3', '$2b$12$FfYByen3SOt9FO.lmyXFQ.qzLVC6YbEO3iBpvPZXqrFUkWRDi768K', 20005, NULL, 'edisongunawan3@mail.com', 1, 'be0e1c62-1224-4ddc-9ee7-be78255fefeb'),
(11, 'chelsea4', '$2b$12$iqVgfjU0hG.RTW8DbkF/iOIRp4qOibEFtEaXApdLrJWtIsQevnjh.', 20006, NULL, 'chelseaprayoga4@mail.com', 1, '31fe463d-08ed-40cc-beea-3e4ef7f2a522'),
(12, 'wage5', '$2b$12$mudk8k88ZFeTlM.SWdVyAebV2NWW9jBzGhDnE8pAlOpp9d.SSvuPK', 20007, NULL, 'wageprasetyost5@mail.com', 1, 'f3fb5d97-7829-46ad-9faa-3c84f49d62b0'),
(13, 'lantar6', '$2b$12$Z5R5X1bfy1u020bFYRIIZuJLutNK/uxLpkviCYCYo3JH2ViA7vVG.', 20008, NULL, 'lantarsaputramkom6@mail.com', 1, '0e72eb30-2cec-4615-9d72-3667dd01b945'),
(14, 'usman7', '$2b$12$/xh8sX.zG0vl24Wqp1U5jOGYJTWbVFUoK42C5PAJJsOwlXnKUEIf.', 20009, NULL, 'usmannuraini7@mail.com', 1, 'fad999b7-5ac0-4ffd-9f84-758d44c5e41f'),
(15, 'jagapati8', '$2b$12$LKih7Ps6RhKO3UMu3lBGwu/sCYWAIcWh0muXgg33JyFLMkgp1Ze.S', 20010, NULL, 'jagapatiagustinamfarm8@mail.com', 1, 'cf268fae-5db4-4874-841e-308e342bcfde'),
(16, 'cinta9', '$2b$12$k3lA9Uw/Nlo0vFPHgtFCbegtIh0K57iPZlUqm0Ac9mZDx.UZeXmVS', 20011, NULL, 'cintakuswandari9@mail.com', 1, '7986092a-6edc-408e-9315-ea9cdc4af86a'),
(17, 'kartika10', '$2b$12$JxRLMqwJ0eHNH5k9q.DOju4sjvizX6/LlFcqRmgFy4oyN6BginM5q', 20012, NULL, 'kartikariyanti10@mail.com', 1, 'acaaa337-b7b1-4eef-b765-c3326775217a'),
(18, 'raisa11', '$2b$12$RrZ8Y03H51DmbVdLnW0GnO8cWLbObpM9/Jyz4MKTOer1M0TVOZVBm', 20013, NULL, 'raisawidodo11@mail.com', 1, '882a4d9b-2936-410c-9836-fba7daaa077f'),
(19, 'galuh12', '$2b$12$FqsdvuR81T7eUZSQagF1VO8HiRm435SVS2FO6Z6620ZwapNNERcKW', 20014, NULL, 'galuhsitumorang12@mail.com', 1, '56e49c80-79c0-4a76-9e78-6827acc22cf5'),
(20, 'martana13', '$2b$12$Ymz.Fkfr8ju670h8d2jwwO30wIe/AYsBrhraotxD962RcAj666amO', 20015, NULL, 'martanasaragih13@mail.com', 1, 'fc5de450-bf86-4bd7-b068-8fe7759518a4'),
(21, 'rangga14', '$2b$12$SlDZieVb.MK.iO.Uyypbk..nmFqR5yW3Hm44Px8elOWMyLdEhTjQi', 20016, NULL, 'ranggawinarsih14@mail.com', 1, '77535c1c-b9c2-438a-a7a0-e2e28a7900ab'),
(22, 'g15', '$2b$12$BRmPWICp5eHlf0haEKlkpOgClBLvRyn8EWAclyftHPBZI7ZSvTQCS', 20017, NULL, 'gzizimulyanimti15@mail.com', 1, 'db5423bc-f61b-41e2-801d-2c26ec4ab8e2'),
(23, 'laksana16', '$2b$12$ErTQasH1GR7i5aLVR1RJvO4Xa8aPzQA09IDX196rRVaQAOe.vuxUW', 20018, NULL, 'laksanapradana16@mail.com', 1, '6428698e-c7c3-4bc8-ae55-8d82ab116b23'),
(24, 'kh17', '$2b$12$XwvC.yzKggq7x7y6N7XfjexOKAaR6nYxgMnaoEfMIs7EabqaGzNNG', 20019, NULL, 'khlatifaniani17@mail.com', 1, '1cc778c9-ab7c-496f-9174-f86ddcc89452'),
(25, 'kezia18', '$2b$12$NxBKjiBUdriZ2wdlqewjpOLnvSwBtNOIcSKHvZVZtHDl5.OFYM3g.', 20020, NULL, 'keziawibisono18@mail.com', 1, 'fda258cc-9ae5-4dce-b79c-98d1097c8ad2'),
(26, 'vanesa19', '$2b$12$CeLWKak152Ev05oOM3NyneBjQ63XYToaqudikODgE8QbxtGJz0fNW', 20021, NULL, 'vanesakusumospsi19@mail.com', 1, '9c6c9066-5952-4696-afe5-b21ad6deb040'),
(27, 'harsaya20', '$2b$12$5bvjZtvSRh3GqmalaJJVS.4SomXsGYCyiXPQPGM8d3qUPURaZ86XK', 20022, NULL, 'harsayamarpaung20@mail.com', 1, '5c8616c1-5e4c-4026-932b-48ff4e7c99ff'),
(28, 'prayoga21', '$2b$12$YURakNqKC22mmWz0M68h7exRzHNCAdquLtkBa6qd9RsiDrNiui1P2', 20023, NULL, 'prayogawinarnosfarm21@mail.com', 1, '75d172e5-0fe2-45d1-8c37-6be8558f30f0'),
(29, 'drs22', '$2b$12$0x8jJb4KpDero7QwUeebs.Ab6Vx1CrTUBeZ8cDpf2TTnO7tHfn9Ve', 20024, NULL, 'drssafinagunawan22@mail.com', 1, '61377ff3-353d-4613-86f8-086ed5a745f6'),
(30, 'kartika23', '$2b$12$7gzEKWS/jWfN/bs8IdrC2esTr7NGBYMN4sL71CvnGYjbJUkUtIAkq', 20025, NULL, 'kartikapuspasari23@mail.com', 1, '390f2d68-42c1-44e3-b2d0-df19be3868bc'),
(31, 'garang24', '$2b$12$cfXnG7KbZMrH0HTkcAW0POFiMWfPr/36XEVsZQitu5X504LWywvAG', 20026, NULL, 'garangwinarno24@mail.com', 1, '2fc69d71-ae76-482e-9dfd-361337124987'),
(32, 'tasnim25', '$2b$12$59FsNFCC.Oi7CfA.9K0JZO1SSzjJUp.QLVFffNt1Tw5Uqnb2LZwni', 20027, NULL, 'tasnimiswahyudi25@mail.com', 1, '48d89f97-46b6-48c9-9dd5-d6358e21e634'),
(33, 'mariadi26', '$2b$12$Yy6RbXqpbo.XdfZkCGzLNeGQyGMS7yD0/vuYRsUJ1EbMhy5xZT79a', 20028, NULL, 'mariadikusumo26@mail.com', 1, '5b806dea-8d0e-462d-bf52-5073ced13c6b'),
(34, 'drs27', '$2b$12$7cwmiwiLAluefEG7/OdAJuOV6HgEMvsLHIjygRcqIq63tjQ.lAJ0O', 20029, NULL, 'drspuputjailani27@mail.com', 1, '6e42da8a-433e-44c4-9619-34debc6c2d6e'),
(35, 'cemani28', '$2b$12$Cz3fesjDYJvqrXDsnzK5JOUj3ObQ9z/6tpyunENGykvvRgDT0NNkC', 20030, NULL, 'cemaninatsir28@mail.com', 1, '42e06118-f63e-4a0a-a2fa-5684314e3e38'),
(36, 'maida29', '$2b$12$BE/LRhSj/r9k8iCEgJaaS.nf7rz9rnabbhWkN5mohXyTY1Bhum3.i', 20031, NULL, 'maidanarpati29@mail.com', 1, '0cae967f-bf77-4b2a-bf63-95af15795f5c'),
(37, 'vinsen30', '$2b$12$7gJuSq4lb2BXBHaUcGjvdOQfivqtK1GCQpV1OpWQBbQ6x0B6lPYkC', 20032, NULL, 'vinsenwaluyo30@mail.com', 1, '3dccd559-c067-4c69-85bc-0c9a81b1c808'),
(38, 'cut31', '$2b$12$F43r5XWF/vUCTjYON4zrhecXs0DLq37sOGfkUFfVGS6MuNbjEHRW.', 20033, NULL, 'cutjessicanarpatisip31@mail.com', 1, '15b0ef54-de28-4ee6-8fbb-85d86dd2a028'),
(39, 'harto32', '$2b$12$rnEfURom2NLCW0NpY5TnWeVijpu0glT9B18c1sPjnd5Lg5V32EfXG', 20034, NULL, 'hartomangunsong32@mail.com', 1, '49b028b2-81bb-4118-84e5-b1ad038188d9'),
(40, 'yani33', '$2b$12$iiEKWcaxdvXH1N20OByas.S/GM4p.psmnqZddSd/aqIVBW4SD/rey', 20035, NULL, 'yanihartati33@mail.com', 1, '27545646-aff6-41bd-a7c7-9ae587cd7f61'),
(41, 'zizi34', '$2b$12$4Ww.iqqVRvLcz1KG2C2PKeNGXN8Ur9eM9v5cMsh4YVJooab8rb4v6', 20036, NULL, 'zizisirait34@mail.com', 1, '4ca56ed3-4e05-4bc3-b54a-88cc124f49e8'),
(42, 'sutan35', '$2b$12$W1YYvPp82L21.gM6UI8Y6uNMgJfrGQOw3fOyQni7V/Nl3u4DV1m4S', 20037, NULL, 'sutanlukitadongoran35@mail.com', 1, '1af0f059-8dd6-464a-8331-e6e9c922fd36'),
(43, 'harja36', '$2b$12$t0jLzvRUcUxV4SapE2ONmesWgcm4zGB1WxWHihgbpZgNvlRykQ8oW', 20038, NULL, 'harjasimanjuntak36@mail.com', 1, '7e4dbe3a-2608-4e40-9bc1-6986fcce0efa'),
(44, 'hartana37', '$2b$12$T013H2HzZAlI7BimK2rgKuWLMUNPGzrp6PDphEg0T8AOjw2O0c4A.', 20039, NULL, 'hartanawahyuni37@mail.com', 1, '3efde603-8e84-4be2-bbe5-a63eb0718aa8'),
(45, 'cindy38', '$2b$12$IB1phpUIgVNHRgg9fH85veHEEyFtays2PZ51AuUMd7pMUZa8a8U9i', 20040, NULL, 'cindyanggriawan38@mail.com', 1, 'b287c75e-2ade-42c4-b93e-8eb16f3821bf'),
(46, 'patricia39', '$2b$12$l2sg/C5.1MHyash.yrJRJ.pGNC9GVDrFUayBKh2XqVXQsRTUaNSJm', 20041, NULL, 'patriciaprayoga39@mail.com', 1, '1a11a398-82f7-453c-8881-82db969f5f7d'),
(47, 'carla40', '$2b$12$q.I74noXbsFdS3CgBCtmxurhjyroPO3gqjgK0N5eCJ.mJcr2Z/3ZC', 20042, NULL, 'carlairawan40@mail.com', 1, '75707355-4bc3-405d-917a-93e122863a81'),
(48, 'gina41', '$2b$12$01obduHiyr6rIJaEJi6uGuzlMO6XxKyfPL2gfYYoWWajcICQQ2z6W', 20043, NULL, 'ginahutapea41@mail.com', 1, '51e24607-0406-4801-bab2-f98c65682fa5'),
(49, 'ulva42', '$2b$12$JsJ5kWWJs4hPsIZqYLjFNuj8n4r/Pmt01ZuYxoXN08QAA/S3x.67K', 20044, NULL, 'ulvawasita42@mail.com', 1, '9daf2c33-1281-41af-985b-968903af2496'),
(50, 'suci43', '$2b$12$xU7OOVScpkAPdLgEfn7.AO/5jW5XpbbdKFJIFhkQUKqYT44/4V1Ay', 20045, NULL, 'sucirajatamak43@mail.com', 1, '4265307f-b508-4369-819b-86c4b5c114f4'),
(51, 'tri44', '$2b$12$Samw57Nr9lKcm6DHFWxv.uJG5Egh2xnn5WW1pyXNfovJGE4ZdtAge', 20046, NULL, 'trisiraitse44@mail.com', 1, '5ab24cde-bcd7-4a61-8791-042b3f8cb79f'),
(52, 'r45', '$2b$12$Wz5oQrtM3SdjW0Slrhkcy.KX9ByJuN5G.Agd407uQphkdafGBx.7K', 20047, NULL, 'rharimandala45@mail.com', 1, '9cdc2d1c-dd55-49fe-962e-90da5e81cc33'),
(53, 'puti46', '$2b$12$rR3q65AeIL4afLZrPwO6qOj7L1RJ..3xw29vJaSTteI5xIqIylnG6', 20048, NULL, 'putiwulankuswoyosei46@mail.com', 1, '713e4ccf-4ede-4985-818f-b9a242a179b8'),
(54, 'upik47', '$2b$12$K2aUtEOCHwbW6yaUPgk9puQNdvCMFi1IxlUU0aDCcvkOjDYDp38py', 20049, NULL, 'upiksihotang47@mail.com', 1, '40fcd2da-7b52-42a6-849b-07cf96d24db7'),
(55, 'ir48', '$2b$12$sb3vOTiNC49Y4Z8Wr3euruMCpQgQNO9vG5tMKUyyb4OmamCkch8pa', 20050, NULL, 'irayupurnawati48@mail.com', 0, '9750d507-49a8-4063-8ac9-109dd695e450'),
(56, 'pangeran49', '$2b$12$BBoSZRengnKD2xITr.iczuzg4tJEkNOrgqBegLnL/dttdnz9NfrJW', NULL, NULL, 'pangerantarihoran49@mail.com', 1, 'abec7b6e-b122-4c62-a18e-01b1c616349a');

--
-- Dumping data for table `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES
(4, 4, 1),
(5, 5, 3),
(6, 6, 2);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
