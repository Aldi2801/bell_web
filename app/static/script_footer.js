
const now = new Date();
const year = now.getFullYear();
const semester = now.getMonth() + 1 >= 7 ? "Ganjil" : "Genap";
const startYear = semester === "Ganjil" ? year : year - 1;
const endYear = startYear + 1;
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
        } else {
            redirectToLogin();
        }
    }  catch (error) {
        console.error("Error verifying token:", error); // Log error untuk debugging
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
