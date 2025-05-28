from . import app, db, bcrypt, jwt, User, Role
import uuid
from flask import request, render_template, redirect, url_for, jsonify, session, flash
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity, unset_jwt_cookies

hashed_password = bcrypt.generate_password_hash('admin123').decode('utf-8')
print(str(uuid.uuid4()))
print(hashed_password)
hashed_password = bcrypt.generate_password_hash('guru123').decode('utf-8')
print(str(uuid.uuid4()))
print(hashed_password)
@app.route('/')
def homepahe():
    return redirect(url_for('login'))
    #return render_template('index.html')
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        username = request.json['username']
        password = request.json['password']
        # Mencari pengguna berdasarkan username
        user = User.query.filter_by(username=username).first()

        if not user:
            return "Username salah", 401

        # Memverifikasi password
        if bcrypt.check_password_hash(user.password, password):
            access_token = create_access_token(identity=username)
            session['jwt_token'] = access_token
            session['username'] = username
            # Ambil role pertama (jika ada)
            if user.roles:
                session['role'] = user.roles[0].name
            else:
                session['role'] = None  # atau bisa kasih nilai default

            # Jika user bisa punya lebih dari satu role dan kamu ingin menyimpannya semua:
            # session['roles'] = [role.name for role in user.roles]
            return jsonify({'token':access_token})
        else:
            return "Password salah", 402
        
    else:
        msg = request.args.get('msg')
        return render_template('login.html', msg=msg)
    

# Endpoint yang memerlukan autentikasi
@app.route('/keluar')
def keluar():
    # Hapus token dari cookie (anda bisa menghapus token dari header juga jika tidak menggunakan cookie)
    response = jsonify({'message': 'Logout berhasil'})
    unset_jwt_cookies(response)
    session.pop('jwt_token', None)
    session.pop('username', None)
    flash('Sukses Logout')
    return redirect(url_for('login'))

@jwt.expired_token_loader
def expired_token_callback():
    return redirect(url_for('login'))

@app.route('/register', methods=['POST'])
def register_():
        # Tidak perlu jwt_required()
        username = request.json.get('username')
        password = request.json.get('password')
        re_password = request.json.get('re_password')
        email = request.json.get('email')
        nama_lengkap = request.json.get('nama_lengkap')

        if not username or not password or not email or not nama_lengkap:
            return jsonify({"msg": "Username , password , email, nama lengkap wajib diisi"}), 400
        if re_password != password:
            return jsonify({"msg": "Password tidak sama"}), 400

        if User.query.filter_by(username=username).first():
            return jsonify({"msg": "Username sudah digunakan"}), 400

        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

        user = User(username=username, password=hashed_password, email=email, active=True,
        fs_uniquifier = str(uuid.uuid4()), )
        db.session.add(user)
        db.session.commit()

        # Tambahkan role 'murid' ke user
        murid_role = Role.query.filter_by(name='murid').first()
        if murid_role:
            user.roles.append(murid_role)
            db.session.commit()
        else:
            raise Exception("Role 'murid' belum ada di tabel role. Pastikan sudah dibuat.")
        return jsonify({"msg": "Register Berhasil"}), 200
