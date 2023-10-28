// To parse this JSON data, do
//
//     final admin = adminFromJson(jsonString);

import 'dart:convert';

Admin adminFromJson(String str) => Admin.fromJson(json.decode(str));

String adminToJson(Admin data) => json.encode(data.toJson());

class Admin {
  final int? idAdmin;
  final String? nama;
  final String? username;
  final String? password;
  final String? alamat;
  final String? email;
  final String? noTelpon;
  final String? jenisKelamin;
  final dynamic tanggalBergabung;

  Admin({
    this.idAdmin,
    this.nama,
    this.username,
    this.password,
    this.alamat,
    this.email,
    this.noTelpon,
    this.jenisKelamin,
    this.tanggalBergabung,
  });

  Admin copyWith({
    int? idAdmin,
    String? nama,
    String? username,
    String? password,
    String? alamat,
    String? email,
    String? noTelpon,
    String? jenisKelamin,
    dynamic tanggalBergabung,
  }) =>
      Admin(
        idAdmin: idAdmin ?? this.idAdmin,
        nama: nama ?? this.nama,
        username: username ?? this.username,
        password: password ?? this.password,
        alamat: alamat ?? this.alamat,
        email: email ?? this.email,
        noTelpon: noTelpon ?? this.noTelpon,
        jenisKelamin: jenisKelamin ?? this.jenisKelamin,
        tanggalBergabung: tanggalBergabung ?? this.tanggalBergabung,
      );

  factory Admin.fromJson(Map<String, dynamic> json) => Admin(
        idAdmin: json["id_admin"],
        nama: json["nama"],
        username: json["username"],
        password: json["password"],
        alamat: json["alamat"],
        email: json["email"],
        noTelpon: json["no_telpon"],
        jenisKelamin: json["jenis_kelamin"],
        tanggalBergabung: json["tanggal_bergabung"],
      );

  Map<String, dynamic> toJson() => {
        "id_admin": idAdmin,
        "nama": nama,
        "username": username,
        "password": password,
        "alamat": alamat,
        "email": email,
        "no_telpon": noTelpon,
        "jenis_kelamin": jenisKelamin,
        "tanggal_bergabung": tanggalBergabung,
      };
}
