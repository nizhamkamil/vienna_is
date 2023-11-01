// To parse this JSON data, do
//
//     final guru = guruFromJson(jsonString);

import 'dart:convert';

List<Guru> guruFromJson(String str) =>
    List<Guru>.from(json.decode(str).map((x) => Guru.fromJson(x)));

Guru guruSingleFromJson(String str) => Guru.fromJson(json.decode(str));

String guruToJson(List<Guru> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String guruSingleToJson(Guru data) => json.encode(data.toJson());

class Guru {
  final int? idGuru;
  final String? nama;
  final String? username;
  final String? password;
  final String? alamat;
  final String? email;
  final String? noTelepon;
  final String? agama;
  final String? kewarganegaraan;
  final String? jenisKelamin;
  final String? statusNikah;

  Guru({
    this.idGuru,
    this.nama,
    this.username,
    this.password,
    this.alamat,
    this.email,
    this.noTelepon,
    this.agama,
    this.kewarganegaraan,
    this.jenisKelamin,
    this.statusNikah,
  });

  Guru copyWith({
    int? idGuru,
    String? nama,
    String? username,
    String? password,
    String? alamat,
    String? email,
    String? noTelepon,
    String? agama,
    String? kewarganegaraan,
    String? jenisKelamin,
    String? statusNikah,
  }) =>
      Guru(
        idGuru: idGuru ?? this.idGuru,
        nama: nama ?? this.nama,
        username: username ?? this.username,
        password: password ?? this.password,
        alamat: alamat ?? this.alamat,
        email: email ?? this.email,
        noTelepon: noTelepon ?? this.noTelepon,
        agama: agama ?? this.agama,
        kewarganegaraan: kewarganegaraan ?? this.kewarganegaraan,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        statusNikah: statusNikah ?? this.statusNikah,
      );

  factory Guru.fromJson(Map<String, dynamic> json) => Guru(
        idGuru: json["id_guru"],
        nama: json["nama"],
        username: json["username"],
        password: json["password"],
        alamat: json["alamat"],
        email: json["email"],
        noTelepon: json["no_telepon"],
        agama: json["agama"],
        kewarganegaraan: json["kewarganegaraan"],
        jenisKelamin: json["jenis_kelamin"],
        statusNikah: json["status_nikah"],
      );

  Map<String, dynamic> toJson() => {
        "id_guru": idGuru,
        "nama": nama,
        "username": username,
        "password": password,
        "alamat": alamat,
        "email": email,
        "no_telepon": noTelepon,
        "agama": agama,
        "kewarganegaraan": kewarganegaraan,
        "jenis_kelamin": jenisKelamin,
        "status_nikah": statusNikah,
      };
}
