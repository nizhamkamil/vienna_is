// To parse this JSON data, do
//
//     final murid = muridFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Murid> muridFromJson(String str) =>
    List<Murid>.from(json.decode(str).map((x) => Murid.fromJson(x)));

String muridToJson(List<Murid> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Murid {
  final int idMurid;
  final String nama;
  final String username;
  final String password;
  final String alamat;
  final String email;
  final String noTelepon;
  final String jenisKelamin;
  final dynamic tanggalMasuk;
  final String agama;
  final String kewarganegaraan;
  final String statusDaftar;
  final String namaWali;
  final dynamic tanggalLahir;
  final dynamic tempatLahir;

  Murid({
    required this.idMurid,
    required this.nama,
    required this.username,
    required this.password,
    required this.alamat,
    required this.email,
    required this.noTelepon,
    required this.jenisKelamin,
    required this.tanggalMasuk,
    required this.agama,
    required this.kewarganegaraan,
    required this.statusDaftar,
    required this.namaWali,
    required this.tanggalLahir,
    required this.tempatLahir,
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
    dynamic tanggalMasuk,
    String? agama,
    String? kewarganegaraan,
    String? statusDaftar,
    String? namaWali,
    dynamic tanggalLahir,
    dynamic tempatLahir,
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
        tanggalMasuk: json["tanggal_masuk"],
        agama: json["agama"],
        kewarganegaraan: json["kewarganegaraan"],
        statusDaftar: json["status_daftar"],
        namaWali: json["nama_wali"],
        tanggalLahir: json["tanggal_lahir"],
        tempatLahir: json["tempat_lahir"],
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
        "tanggal_masuk": tanggalMasuk,
        "agama": agama,
        "kewarganegaraan": kewarganegaraan,
        "status_daftar": statusDaftar,
        "nama_wali": namaWali,
        "tanggal_lahir": tanggalLahir,
        "tempat_lahir": tempatLahir,
      };
}
