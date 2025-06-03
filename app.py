from app import app, db, Role, generate_siswa_data, import_data_guru # pastikan Role diimpor dari model kamu

def add_default_roles():
    role_names = ['murid', 'guru', 'admin']
    for role_name in role_names:
        if not Role.query.filter_by(name=role_name).first():
            db.session.add(Role(name=role_name))
    db.session.commit()
import random

mapel = ['BI', 'ENG', 'IPA', 'IPS', 'MTK']
guru = ['JMR', 'HRW', 'TEP', 'BYT', 'ULN', 'PRN', 'NAR', 'RA']

kombinasi = [f"{m}-{g}" for m in mapel for g in guru]  # 40 kombinasi unik
hasil_acak = [random.choice(kombinasi) for _ in range(0)]  # pilih 265 dengan duplikat

for i, data in enumerate(hasil_acak, 1):
    print(f"{i}. {data}")

if __name__ == '__main__':
    with app.app_context():
        db.create_all()
        add_default_roles()
        generate_siswa_data()
        import_data_guru()

    app.run(host="0.0.0.0", debug=True, port=4040)
