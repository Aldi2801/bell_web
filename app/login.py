from . import app, bcrypt, jwt, User
from flask import request, render_template, redirect, url_for, jsonify, session, flash
from flask_jwt_extended import create_access_token, unset_jwt_cookies
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
        access_token = create_access_token(identity=username)
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
