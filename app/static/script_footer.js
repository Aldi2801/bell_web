async function verifyToken() {
    const token = localStorage.getItem('authToken');
    if (!token) return redirectToLogin();

    try {
        const res = await fetch('/verify-token', {
            method: 'POST',
            headers: {'Content-Type': 'application/json', 'Authorization': token}
        });
        const { valid, username,nama_lengkap, role } = await res.json();
        if (valid) {
            localStorage.setItem('tokenValid', 'true');
            setupRoleBasedContent(role,nama_lengkap);
        } else {
            redirectToLogin();
        }
    }  catch (error) {
        console.error("Error verifying token:", error); // Log error untuk debugging
    }
}

function setupRoleBasedContent(role,username) {
    const roleText = role === 'murid' ? 'Murid' : 'Guru';
    document.getElementById('role-title').textContent = roleText;
    document.getElementById('role-detail').textContent = roleText;
    document.getElementById('username').textContent = username;
    if (role === 'murid') {
        document.getElementById('link-jadwal').href = "/jadwal";
        document.getElementById('link-kehadiran').href = "/daftar_hadir";
        document.getElementById('link-ujian').href = "/daftar_hadir_ujian";
        document.getElementById('nav-menu').insertAdjacentHTML('beforeend', `<a href="/menu_pembayaran"><i class="fas fa-credit-card mr-2"></i> Pembayaran</a>`);
        document.getElementById('additional-info').textContent = 'Kelas: IX IPA';
    } else {
        document.getElementById('link-jadwal').href= "/manage_jadwal";
        document.getElementById('link-kehadiran').href = "/manage_kehadiran";
        document.getElementById('link-ujian').href = "/manage_ujian";
        document.getElementById('additional-info').textContent = 'Mata Pelajaran: IPA';
    }
}

function handleLogout() {
    localStorage.clear();
    redirectToLogin();
}

function redirectToLogin() {
    window.location.href = "/login";
}

document.addEventListener("DOMContentLoaded", verifyToken);

const now = new Date();
const year = now.getFullYear();
const semester = now.getMonth() + 1 >= 7 ? "Ganjil" : "Genap";
const startYear = semester === "Ganjil" ? year : year - 1;
const endYear = startYear + 1;

$("#tahunPelajaran").text(`Tahun Pelajaran ${startYear}/${endYear} - Semester ${semester}`);