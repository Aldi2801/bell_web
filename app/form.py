from flask_wtf import FlaskForm
from wtforms import StringField, IntegerField, DateField, SelectField, SubmitField
from wtforms.validators import DataRequired, Length, Optional
from . import db, Gender, Status

class FormSiswa(FlaskForm):
    nis = IntegerField("NIS", validators=[DataRequired()])
    nisn = StringField("NISN", validators=[Optional(), Length(max=10)])
    nama = StringField("Nama", validators=[Optional(), Length(max=255)])
    tempat_lahir = StringField("Tempat Lahir", validators=[Optional(), Length(max=20)])
    tanggal_lahir = DateField("Tanggal Lahir", format="%Y-%m-%d", validators=[Optional()])
    alamat = StringField("Alamat", validators=[Optional(), Length(max=125)])
    no_hp = StringField("No HP", validators=[Optional(), Length(max=15)])
    nama_ayah = StringField("Nama Ayah", validators=[Optional(), Length(max=35)])
    nama_ibu = StringField("Nama Ibu", validators=[Optional(), Length(max=35)])
    penghasilan_ayah = IntegerField("Penghasilan Ayah", validators=[Optional()])
    penghasilan_ibu = IntegerField("Penghasilan Ibu", validators=[Optional()])
    asal_sekolah = StringField("Asal Sekolah", validators=[Optional(), Length(max=30)])
    
    # Foreign key: Gender dan Status
    id_gender = SelectField("Gender", coerce=str, validators=[Optional()])
    id_status = SelectField("Status", coerce=str, validators=[Optional()])

    submit = SubmitField("Simpan")

    def __init__(self, *args, **kwargs):
        super(FormSiswa, self).__init__(*args, **kwargs)
        self.id_gender.choices = [(g.id_gender, g.gender) for g in Gender.query.all()]
        self.id_status.choices = [(s.id_status, s.status) for s in Status.query.all()]
