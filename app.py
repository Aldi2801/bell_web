from app import app, db, Role, generate_siswa_data, import_data_guru # pastikan Role diimpor dari model kamu

def add_default_roles():
    role_names = ['murid', 'guru', 'admin']
    for role_name in role_names:
        if not Role.query.filter_by(name=role_name).first():
            db.session.add(Role(name=role_name))
    db.session.commit()

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        add_default_roles()
        generate_siswa_data()
        import_data_guru()

    app.run(host="0.0.0.0", debug=True, port=4040)
