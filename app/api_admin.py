from . import app, db, is_valid_email, bcrypt, users_collection, mail, s
from flask import request, jsonify, url_for, render_template, render_template_string,session
from flask_mail import Message
from itsdangerous import BadSignature, SignatureExpired
import jwt, re, datetime, os 
from bson.objectid import ObjectId

@app.route('/tambah_pengumuman', methods=['POST'])
def tambah_pengumuman():
    data = request.get_json()

    judul_pengumuman = data['judul_pengumuman']
    penulis_pengumuman = data['penulis_pengumuman']

    isi_pengumuman = data['isi_pengumuman']
    jenis_pengumuman = data['jenis_pengumuman']

    if not judul_pengumuman or not jenis_pengumuman or not penulis_pengumuman or not isi_pengumuman:
        return jsonify({"msg": "All fields are required"}), 400

    # Simpan user baru
    pengumuman = {
        'judul_pengumuman': judul_pengumuman,
        'penulis_pengumuman': penulis_pengumuman,
        'isi_pengumuman': isi_pengumuman,
        'jenis_pengumuman': jenis_pengumuman
    }
    try:
        result = db.pengumuman.insert_one(pengumuman)
        if result.inserted_id:
            return jsonify({'msg': 'Pengumuman Berhasil Dibuat'}), 201
        else:
            return jsonify({'error': 'Failed to add Pengumuman'}), 500
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500

@app.route('/edit_pengumuman/<id>', methods=['PUT'])
def edit_pengumuman(id):
    data = request.json
    result = db.pengumuman.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
        'judul_pengumuman': data['judul_pengumuman'],
        'penulis_pengumuman': data['penulis_pengumuman'],
        'isi_pengumuman': data['isi_pengumuman'],
        'jenis_pengumuman': data['jenis_pengumuman']
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_pengumuman/<id>', methods=['DELETE'])
def delete_pengumuman(id):
    result = db.pengumuman.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200

@app.route('/tambah_laporan', methods=['POST'])
def tambah_laporan():
    data = request.get_json()

    judul_laporan = data['judul_laporan']
    penulis_laporan = data['penulis_laporan']

    isi_laporan = data['isi_laporan']
    mapel_laporan = data['mapel_laporan']

    if not judul_laporan or not mapel_laporan or not penulis_laporan or not isi_laporan:
        return jsonify({"msg": "All fields are required"}), 400

    # Simpan user baru
    laporan = {
        'judul_laporan': judul_laporan,
        'penulis_laporan': penulis_laporan,
        'isi_laporan': isi_laporan,
        'mapel_laporan': mapel_laporan
    }
    try:
        result = db.laporan.insert_one(laporan)
        if result.inserted_id:
            return jsonify({'msg': 'Laporan Berhasil Dibuat'}), 201
        else:
            return jsonify({'error': 'Failed to add Laporan'}), 500
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500

@app.route('/edit_laporan/<id>', methods=['PUT'])
def edit_laporan(id):
    data = request.json
    result = db.laporan.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
        'judul_laporan': data['judul_laporan'],
        'penulis_laporan': data['penulis_laporan'],
        'isi_laporan': data['isi_laporan'],
        'mapel_laporan': data['mapel_laporan']
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_laporan/<id>', methods=['DELETE'])
def delete_laporan(id):
    result = db.laporan.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200

@app.route('/tambah_tugas', methods=['POST'])
def tambah_tugas():
    data = request.get_json()
    judul_tugas = data['judul_tugas']
    penulis_tugas = data['penulis_tugas']
    isi_tugas = data['isi_tugas']
    mapel_tugas = data['mapel_tugas']
    if not judul_tugas or not mapel_tugas or not penulis_tugas or not isi_tugas:
        return jsonify({"msg": "All fields are required"}), 400

    # Simpan user baru
    tugas = {
        'judul_tugas': judul_tugas,
        'penulis_tugas': penulis_tugas,
        'isi_tugas': isi_tugas,
        'mapel_tugas': mapel_tugas
    }
    try:
        result = db.tugas.insert_one(tugas)
        if result.inserted_id:
            return jsonify({'msg': 'Tugas Berhasil Dibuat'}), 201
        else:
            return jsonify({'error': 'Failed to add Tugas'}), 500
    except Exception as e:
        return jsonify({'error': f"Database error: {str(e)}"}), 500

@app.route('/edit_tugas/<id>', methods=['PUT'])
def edit_tugas(id):
    data = request.json
    result = db.tugas.update_one(
        {"_id": ObjectId(id)},
        {"$set": {
        'judul_tugas': data['judul_tugas'],
        'penulis_tugas': data['penulis_tugas'],
        'isi_tugas': data['isi_tugas'],
        'mapel_tugas': data['mapel_tugas']
        }}
    )

    if result.modified_count == 0:
        return jsonify({"error": "No document updated"}), 404

    return jsonify({"message": "Attendance updated successfully"}), 200

@app.route('/hapus_tugas/<id>', methods=['DELETE'])
def delete_tugas(id):
    result = db.tugas.delete_one({"_id": ObjectId(id)})

    if result.deleted_count == 0:
        return jsonify({"error": "No document found to delete"}), 404

    return jsonify({"message": "Attendance deleted successfully"}), 200
