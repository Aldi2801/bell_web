from . import app, bcrypt, User,Role,UserRoles, mail,db
from flask import request, render_template, redirect, url_for, jsonify, session, flash
from flask_jwt_extended import create_access_token, unset_jwt_cookies
from datetime import datetime, timedelta
import jwt
from flask_mail import Message
from jwt import ExpiredSignatureError, InvalidTokenError
from itsdangerous import URLSafeTimedSerializer
import secrets
@app.route('/')
def homepahe():
    return redirect(url_for('login'))
    #return render_template('index.html')
@app.route('/login')
def login():
    return render_template('admin/admin.html')

@app.route('/proses_login', methods=['POST'])
def proses_login():
    username = request.json['username']
    password = request.json['password']

    user = User.query.filter_by(username=username).first()

    if not user:
        return jsonify(success=False, message="Username salah")

    if bcrypt.check_password_hash(user.password, password):
        payload = {
            'username': username,
            'role': user.roles[0].name if user.roles else None,
            'email' : user.email,
            'exp': datetime.utcnow() + timedelta(hours=24)
        }
        access_token = jwt.encode(payload, app.config['SECRET_KEY'], algorithm='HS256')
        session['jwt_token'] = access_token
        session['username'] = username
        session['email'] = user.email
        if user.roles:
            session['role'] = user.roles[0].name
        else:
            session['role'] = None
        if user.roles[0].name == 'guru':
            session['nip'] = user.nip
        elif user.roles[0].name == 'murid':
            session['nis'] = user.nis
        else:
            session['role'] = 'admin'

        return jsonify(success=True, token=access_token)
    else:
        return jsonify(success=False, message="Password salah")
@app.route('/reset_password_admin', methods=['GET'])
def reset_password_admin():
    admin = User.query.join(UserRoles).join(Role).filter(Role.name == 'admin').first()
    if admin:
        print(admin.email)

    email = admin.email
    if not admin:
        return jsonify(success=False, message="Email tidak ditemukan"), 404

    # Buat token dengan email
    serializer = URLSafeTimedSerializer(app.config['SECRET_KEY'])
    token = serializer.dumps(email, salt='reset-password')

    # Kirim link via email
    reset_link = url_for('reset_password_form', token=token, _external=True)
    print(reset_link)
    msg = Message("Reset Password Admin",
                  sender=app.config['MAIL_USERNAME'],
                  recipients=[email])
    msg.body = f"Klik link untuk reset password:\n{reset_link}"
    mail.send(msg)

    return jsonify(success=True, message="Link reset password dikirim ke email")
@app.route('/reset_password/<token>', methods=['GET'])
def reset_password_form(token):
    admin = Admin.query.filter_by(reset_token=token).first()

    if not admin or datetime.utcnow() > admin.token_expiry:
        return "<h3>Token tidak valid atau kadaluarsa</h3>"

    # Tampilkan HTML form
    return render_template('render_password_admin.html',token=token)
@app.route('/reset_admin_form', methods=['POST'])
def reset_password_submit():
    token = request.form.get('token')
    new_password = request.form.get('new_password')

    admin = Admin.query.filter_by(reset_token=token).first()
    if not admin:
        return "Token tidak valid", 400

    if datetime.utcnow() > admin.token_expiry:
        return "Token kadaluarsa", 400

    from werkzeug.security import generate_password_hash
    admin.password = generate_password_hash(new_password)
    admin.reset_token = None
    admin.token_expiry = None
    db.session.commit()

    return "<h3>Password berhasil diubah. Silakan </h3><a href='/'>login kembali</a>."


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
    

@app.before_request
def global_jwt_check():
    # Lewatkan route tertentu seperti login, register, static, dll.
    allowed_routes = ['login', 'static', 'proses_login', 'register','reset_password_admin','reset_password_form','reset_password_submit']
    if request.endpoint in allowed_routes or request.endpoint is None:
        return  # skip checking

    token = session.get('jwt_token') or request.headers.get('Authorization')

    if not token:
        return redirect(url_for('login'))

    try:
        decoded = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
        # Simpan user info jika perlu
        request.user = decoded
    except ExpiredSignatureError:
        session.clear()  # hapus sesi
        return redirect(url_for('login'))
    except InvalidTokenError:
        session.clear()
        return redirect(url_for('login'))

# @app.route('/bikin_akun', methods=['GET', 'POST'])
# def register():
#     if request.method == 'POST':
#         # Tidak perlu jwt_required()

#         username = request.form.get('username')
#         password = request.form.get('password')

#         if not username or not password:
#             return jsonify({"msg": "Username dan password wajib diisi"}), 400

#         if User.query.filter_by(username=username).first():
#             return jsonify({"msg": "Username sudah digunakan"}), 400

#         hashed_password = bcrypt.generate_password_hash(password).decode('utf-8')

#         user = User(username=username, password=hashed_password, active=True)
#         db.session.add(user)
#         db.session.commit()

#         return jsonify({"msg": "Akun berhasil dibuat"}), 201

#     # Jika GET request, tampilkan form HTML atau pesan
#     return render_template('admin/register.html')

#         # Logout setelah registrasi berhasil
#         response = jsonify({'message': 'Logout berhasil'})
#         unset_jwt_cookies(response)
#         session.pop('jwt_token', None)
#         session.pop('username', None)
#         flash('Sukses Logout')
#         return redirect(url_for('login', msg='Registration Successful'))

#     return render_template('admin/register.html')
