// To parse this JSON data, do
//
//     final murid = muridFromJson(jsonString);

import 'dart:convert';

List<Murid> muridFromJson(String str) =>
    List<Murid>.from(json.decode(str).map((x) => Murid.fromJson(x)));

Murid muridSingleFromJson(String str) => Murid.fromJson(json.decode(str));

String muridToJson(List<Murid> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String muridSingleToJson(Murid data) => json.encode(data.toJson());

class Murid {
  final int? idMurid;
  final String? nama;
  final String? username;
  final String? password;
  final String? alamat;
  final String? email;
  final String? noTelepon;
  final String? jenisKelamin;
  final DateTime? tanggalMasuk;
  final String? agama;
  final String? kewarganegaraan;
  final String? statusDaftar;
  final String? namaWali;
  final DateTime? tanggalLahir;
  final String? tempatLahir;
  final String? tipePembelajaran;

  Murid({
    this.idMurid,
    this.nama,
    this.username,
    this.password,
    this.alamat,
    this.email,
    this.noTelepon,
    this.jenisKelamin,
    this.tanggalMasuk,
    this.agama,
    this.kewarganegaraan,
    this.statusDaftar,
    this.namaWali,
    this.tanggalLahir,
    this.tempatLahir,
    this.tipePembelajaran,
  });

  Murid copyWith({
    int? idMurid,
    String? nama,
    String? username,
    String? password,
    String? alamat,
    String? email,
    String? noTelepon,
    String? jenisKelamin,
    DateTime? tanggalMasuk,
    String? agama,
    String? kewarganegaraan,
    String? statusDaftar,
    String? namaWali,
    DateTime? tanggalLahir,
    String? tempatLahir,
    String? tipePembelajaran,
  }) =>
      Murid(
        idMurid: idMurid ?? this.idMurid,
        nama: nama ?? this.nama,
        username: username ?? this.username,
        password: password ?? this.password,
        alamat: alamat ?? this.alamat,
        email: email ?? this.email,
        noTelepon: noTelepon ?? this.noTelepon,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        tanggalMasuk: tanggalMasuk ?? this.tanggalMasuk,
        agama: agama ?? this.agama,
        kewarganegaraan: kewarganegaraan ?? this.kewarganegaraan,
        statusDaftar: statusDaftar ?? this.statusDaftar,
        namaWali: namaWali ?? this.namaWali,
        tanggalLahir: tanggalLahir ?? this.tanggalLahir,
        tempatLahir: tempatLahir ?? this.tempatLahir,
        tipePembelajaran: tipePembelajaran ?? this.tipePembelajaran,
      );

  factory Murid.fromJson(Map<String, dynamic> json) => Murid(
        idMurid: json["id_murid"],
        nama: json["nama"],
        username: json["username"],
        password: json["password"],
        alamat: json["alamat"],
        email: json["email"],
        noTelepon: json["no_telepon"],
        jenisKelamin: json["jenis_kelamin"],
        tanggalMasuk: json["tanggal_masuk"] == null
            ? null
            : DateTime.parse(json["tanggal_masuk"]),
        agama: json["agama"],
        kewarganegaraan: json["kewarganegaraan"],
        statusDaftar: json["status_daftar"],
        namaWali: json["nama_wali"],
        tanggalLahir: json["tanggal_lahir"] == null
            ? null
            : DateTime.parse(json["tanggal_lahir"]),
        tempatLahir: json["tempat_lahir"],
        tipePembelajaran: json["tipe_pembelajaran"],
      );

  Map<String, dynamic> toJson() => {
        "id_murid": idMurid,
        "nama": nama,
        "username": username,
        "password": password,
        "alamat": alamat,
        "email": email,
        "no_telepon": noTelepon,
        "jenis_kelamin": jenisKelamin,
        "tanggal_masuk": tanggalMasuk?.toIso8601String(),
        "agama": agama,
        "kewarganegaraan": kewarganegaraan,
        "status_daftar": statusDaftar,
        "nama_wali": namaWali,
        "tanggal_lahir": tanggalLahir?.toIso8601String(),
        "tempat_lahir": tempatLahir,
        "tipe_pembelajaran": tipePembelajaran,
      };
}
