from system import app
import socket
import requests

def get_local_ip():
    """
    Mendapatkan IP lokal dari komputer
    """
    try:
        # Buat socket untuk mendapatkan IP lokal
        hostname = socket.gethostname()
        local_ip = socket.gethostbyname(hostname)
        return local_ip
    except Exception as e:
        return f"Error mendapatkan IP lokal: {e}"

def get_public_ip():
    """
    Mendapatkan IP publik dari layanan eksternal
    """
    try:
        # Menggunakan layanan 'httpbin.org' untuk mendapatkan IP publik
        response = requests.get("https://httpbin.org/ip")
        response.raise_for_status()
        public_ip = response.json().get("origin", "Tidak ditemukan")
        return public_ip
    except Exception as e:
        return f"Error mendapatkan IP publik: {e}"

if __name__ == "__main__":
    print("Deteksi Alamat IP")
    print("=================")
    local_ip = get_local_ip()
    print(f"IP Lokal: {local_ip}")

    public_ip = get_public_ip()
    print(f"IP Publik: {public_ip}")

if __name__ == '__main__':
    app.run(host="0.0.0.0", debug=True, port=4040)