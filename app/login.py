from . import app, db, bcrypt, jwt, User, Role, mail, s
import uuid
from flask import request, render_template, redirect, url_for, jsonify, session,render_template_string,  flash
from flask_jwt_extended import JWTManager, create_access_token, jwt_required, get_jwt_identity, unset_jwt_cookies
from flask_mail import Mail, Message
from flask_bcrypt import Bcrypt
from itsdangerous import URLSafeTimedSerializer, SignatureExpired, BadSignature
# hashed_password = bcrypt.generate_password_hash('admin123').decode('utf-8')
# print(str(uuid.uuid4()))
# print(hashed_password)
# hashed_passwordd = bcrypt.generate_password_hash('guru123').decode('utf-8')
# print(str(uuid.uuid4()))
# print(hashed_passwordd)
# hashed_passworddd = bcrypt.generate_password_hash('123').decode('utf-8')
# print(str(uuid.uuid4()))
# print(hashed_password)
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
        try:
            token = s.dumps(email, salt='email-confirm')

            conf_email_url = url_for('confirm_email', token=token, _external=True)
            email_body = render_template_string('''
                Hello {{ username }},
                
                Anda menerima email ini, karena kami memerlukan verifikasi email untuk akun Anda agar aktif dan dapat digunakan.
                
                Silakan klik tautan di bawah ini untuk verifikasi email Anda. Tautan ini akan kedaluwarsa dalam 1 jam.
                
                confirm your email: {{ conf_email_url }}
                
                hubungi dukungan jika Anda memiliki pertanyaan.
                
                Untuk bantuan lebih lanjut, silakan hubungi tim dukungan kami di developer masteraldi2809@gmail.com .
                
                Salam Hangat,
                
                Admin
            ''', username=username,  conf_email_url=conf_email_url)

            msg = Message('Confirmasi Email Anda',
                        sender='masteraldi2809@gmail.com', recipients=[email])

            msg.body = email_body
            mail.send(msg)
            return jsonify({"msg": "Register Berhasil"}), 200
        except Exception as e:
            return jsonify({'error': f"Database error: {str(e)}"}), 500


@app.route('/confirm_email/<token>', methods=['GET', 'POST'])
def confirm_email(token):
    try:
        email = s.loads(token, salt='email-confirm', max_age=3600)
    except SignatureExpired:
        return jsonify({"msg": "Token telah kedaluwarsa"}), 400
    except BadSignature:
        return jsonify({"msg": "Token tidak valid"}), 400
    
    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"msg": "User not found"}), 404

    user.verify_email = True
    db.session.commit()

    return '''
    <!doctype html>
    <html lang="en">
    <head><meta charset="utf-8"><title>Email Verify</title></head>
    <body><h1>Email Telah Terverifikasi </h1></body>
    </html>
    '''
#### Verif Email

@app.route("/verif_email", methods=["POST"])
def verif_email():
    data = request.get_json()
    email = data.get("email")
    if not email:
        return jsonify({"msg": "Email harus diisi"})

    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"msg": "Email tidak ditemukan"})

    if user.verify_email:
        return jsonify({"msg": "user sudah terverifikasi"})

    token = s.dumps(email, salt='email-confirm')
    conf_email_url = url_for('confirm_email', token=token, _external=True)

    email_body = render_template_string('''
        Hello {{ username }},
        Anda menerima email ini untuk verifikasi.
        Klik tautan berikut: {{ conf_email_url }}
        Berlaku 1 jam.
    ''', username=user.username, conf_email_url=conf_email_url)

    msg = Message('Konfirmasi Email Anda', sender='masteraldi2809@gmail.com', recipients=[email])
    msg.body = email_body
    mail.send(msg)

    return jsonify({"msg": "Silahkan cek email anda."})

#### Forgot Password
@app.route("/forgotpassword", methods=["POST"])
def forgot_password():
    data = request.get_json()
    email = data.get("email")
    if not email:
        return jsonify({"msg": "Email harus diisi"})

    user = User.query.filter_by(email=email).first()
    if not user:
        return jsonify({"msg": "Email tidak ditemukan"})

    token = s.dumps(email, salt='reset-password')
    from_param = request.args.get('from')

    if "forgot_password.html" in (from_param or ""):
        mod = from_param.replace('forgot_password.html', '')
        reset_password_url = mod + "/reset_password.html?token=" + token
    else:
        reset_password_url = url_for('reset_password', token=token, _external=True)

    email_body = render_template_string('''
        Hello {{ user.name }},
        Reset password Anda: {{ reset_password_url }}
        Berlaku 1 jam.
    ''', user=user, reset_password_url=reset_password_url)

    msg = Message('Reset Kata Sandi Anda', sender='masteraldi2809@gmail.com', recipients=[email])
    msg.body = email_body
    mail.send(msg)

    return jsonify({"msg": "Email untuk mereset kata sandi telah dikirim."})

#### Reset Password
@app.route('/reset_password/<token>', methods=['GET', 'POST'])
def reset_password(token):
    if request.method == 'POST':
        try:
            email = s.loads(token, salt='reset-password', max_age=3600)
        except SignatureExpired:
            return jsonify({"msg": "Token telah kedaluwarsa"}), 400
        except BadSignature:
            return jsonify({"msg": "Token tidak valid"}), 400

        user = User.query.filter_by(email=email).first()
        if not user:
            return jsonify({"msg": "User not found"}), 404

        data = request.get_json()
        password = data.get('password')
        hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')
        user.password = hashed_password
        db.session.commit()

        return jsonify({"msg": "Sukses"})

    return render_template("reset_password.html", token=token)
