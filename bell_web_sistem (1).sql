-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 31 Bulan Mei 2025 pada 17.02
-- Versi server: 10.4.32-MariaDB
-- Versi PHP: 8.2.12

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
-- Dumping data untuk tabel `ampu_mapel`
--


--
-- Dumping data untuk tabel `berita`
--

--
-- Dumping data untuk tabel `gender`
--

INSERT INTO `gender` (`id_gender`, `gender`) VALUES
('L', 'laki-laki'),
('P', 'perempuan');

--
-- Dumping data untuk tabel `guru`
--

--
-- Dumping data untuk tabel `kbm`
--


--
-- Dumping data untuk tabel `kehadiran`
--

INSERT INTO `keterangan` (`id_keterangan`, `keterangan`) VALUES
('0', 'Alpa'),
('1', 'hadir'),
('2', 'izin'),
('3', 'sakit');


--
-- Dumping data untuk tabel `kelas`
--

INSERT INTO `kelas` (`id_kelas`, `nama_kelas`, `tingkat`) VALUES
('7a', '7A', '7'),
('8a', '8A', '8');

--
-- Dumping data untuk tabel `keterangan`
--


--
-- Dumping data untuk tabel `mapel`
--

INSERT INTO `mapel` (`id_mapel`, `nama_mapel`) VALUES
('1', 'bahasa indonesia');

--
-- Dumping data untuk tabel `pembagian_kelas`
--

INSERT INTO `tahun_akademik` (`id_tahun_akademik`, `tahun_akademik`, `mulai`, `sampai`) VALUES
('0', '2023/2024', '2024-01-01', '2024-06-30'),
('1', '2024/2025', '2024-07-01', '2024-12-31');


--
-- Dumping data untuk tabel `penilaian`
--


--
-- Dumping data untuk tabel `role`
--

INSERT INTO `role` (`id`, `name`) VALUES
(3, 'admin'),
(2, 'guru'),
(1, 'murid');

--
-- Dumping data untuk tabel `semester`
--

INSERT INTO `semester` (`id_semester`, `semester`) VALUES
('0', 'genap'),
('1', 'ganjil');

--
-- Dumping data untuk tabel `siswa`
--

INSERT INTO `status` (`id_status`, `status`) VALUES
('0', 'tidak aktif '),
('1', 'aktif');
INSERT INTO `siswa` (`nis`, `nisn`, `nama`, `id_gender`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `email`, `nama_ayah`, `nama_ibu`, `penghasilan_ayah`, `penghasilan_ibu`, `asal_sekolah`, `id_status`) VALUES
(12345678, '12345678', 'salman alfaridzi', 'L', 'tega;', '2004-05-01', 'balamoa', '08997635673', 'man@gmail.com', 'jokowi', 'kartini', 5000000, 5000000, 'sd balamoa 2', '1');

INSERT INTO `guru` (`nip`, `inisial`, `nama`, `tempat_lahir`, `tanggal_lahir`, `alamat`, `no_hp`, `email`, `spesialisasi`, `id_gender`, `id_status`) VALUES
(12345678, NULL, 'aris sugiono', 'tegal', '1998-05-01', 'tegal', '08997687457', 'aris@gmail.com', NULL, 'L', '1');

INSERT INTO `berita` (`id_berita`, `judul`, `isi`, `nip`) VALUES
(1, 'pengumuan pembagian kelas', 'seluruh orang tua diharapkan mengantar anaknya sampe kedepan sekolah jangan telat ada apel', 12345678);


INSERT INTO `pembagian_kelas` (`id_pembagian`, `tanggal`, `nis`, `id_kelas`, `id_tahun_akademik`, `nip`) VALUES
(1, '2024-01-01', 12345678, '7a', '0', 12345678),
(2, '2025-07-01', 12345678, '8a', '1', 12345678);
--
-- Dumping data untuk tabel `status`
--


--
-- Dumping data untuk tabel `tagihan`
--

INSERT INTO `tagihan` (`id_tagihan`, `user_email`, `deskripsi`, `total`, `created_at`) VALUES
(1, 'man@gmail.com', 'pembayaran kemah', 100000, NULL);

--
-- Dumping data untuk tabel `transaksi`
--

INSERT INTO `transaksi` (`id_transaksi`, `kode_order`, `id_tagihan`, `email`, `total`, `status`, `fraud_status`, `created_at`, `updated_at`) VALUES
(1, 'Bla-123', 1, 'man@gmail.com', 100000, 'paid', '0', NULL, NULL);

--
-- Dumping data untuk tabel `tugas`
--

INSERT INTO `tugas` (`id_tugas`, `jenis_tugas`, `deskripsi`, `id_mapel`, `nip`) VALUES
(1, 'essai', 'buatlah cerpen maximal 100 kata', '1', 12345678);

--
-- Dumping data untuk tabel `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `nis`, `nip`, `email`, `active`, `fs_uniquifier`) VALUES
(4, 'man', '$2b$12$N2D4cncbxLazOpAUX1GZnOsbyr7uFCTc41NtbxMgCO6ZGPJFtlHc.', NULL, NULL, 'man@gmail.com', 1, '4a001fc9-812f-44dd-880a-9ddbd86a5c27'),
(5, 'admin', '$2b$12$0CDIw.GPbUrAsVfn4bhbKeEcwjRd.hyAqomQunp1S3gX1tmJvd2mC', NULL, NULL, 'ADMIN@mail.com', 1, '3d512e43-db2c-4df5-8984-d104c1b65d29'),
(6, 'Pak Aris', '$2b$12$jUdOw7DYoMGhEZ7.UwpNJu707GTJZJ9zaRuKiPidCdjvA6NDWD5ka', NULL, NULL, 'pakarisW@mial.com', 1, '0f25b888-ab48-43c4-a574-a09bb28f2743');

--
-- Dumping data untuk tabel `user_roles`
--

INSERT INTO `user_roles` (`id`, `user_id`, `role_id`) VALUES
(4, 4, 1),
(5, 5, 3),
(6, 6, 2);
COMMIT;

INSERT INTO `ampu_mapel` (`id_ampu`, `tanggal`, `id_semester`, `id_mapel`, `nip`, `id_tahun_akademik`, `id_pembagian`) VALUES
(1, '2025-05-02', '0', '1', 12345678, '0', 1),
(2, '2025-07-02', '1', '1', 12345678, '1', 2);

INSERT INTO `kbm` (`id_kbm`, `tanggal`, `materi`, `sub_materi`, `id_ampu`) VALUES
(1, '2025-05-04', 'membuat cerpen', NULL, 1);

INSERT INTO `penilaian` (`id_penilaian`, `tugas`, `uts`, `uas`, `id_ampu`, `nis`) VALUES
(1, 80, 80, 80, 1, 12345678),
(2, 90, 90, 90, 2, 12345678);

INSERT INTO `kehadiran` (`id_kehadiran`, `id_keterangan`, `id_kbm`, `nis`) VALUES
(1, '1', 1, 12345678);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
