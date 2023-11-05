// To parse this JSON data, do
//
//     final pendaftaran = pendaftaranFromJson(jsonString);

import 'dart:convert';

List<Pendaftaran> pendaftaranFromJson(String str) => List<Pendaftaran>.from(
    json.decode(str).map((x) => Pendaftaran.fromJson(x)));

Pendaftaran pendaftaranSingleFromJson(String str) =>
    Pendaftaran.fromJson(json.decode(str));

String pendaftaranToJson(List<Pendaftaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String pendaftaranSingleToJson(Pendaftaran data) => json.encode(data.toJson());

class Pendaftaran {
  final int? idPendaftaran;
  final int? idMurid;
  final String? namaMurid;
  final int? idAdmin;
  final String? namaAdmin;
  final int? idKelas;
  final String? namaKelas;
  final DateTime? tanggalPendaftaran;
  final String? statusPendaftaran;

  Pendaftaran({
    this.idPendaftaran,
    this.idMurid,
    this.namaMurid,
    this.idAdmin,
    this.namaAdmin,
    this.idKelas,
    this.namaKelas,
    this.tanggalPendaftaran,
    this.statusPendaftaran,
  });

  Pendaftaran copyWith({
    int? idPendaftaran,
    int? idMurid,
    String? namaMurid,
    int? idAdmin,
    String? namaAdmin,
    int? idKelas,
    String? namaKelas,
    DateTime? tanggalPendaftaran,
    String? statusPendaftaran,
  }) =>
      Pendaftaran(
        idPendaftaran: idPendaftaran ?? this.idPendaftaran,
        idMurid: idMurid ?? this.idMurid,
        namaMurid: namaMurid ?? this.namaMurid,
        idAdmin: idAdmin ?? this.idAdmin,
        namaAdmin: namaAdmin ?? this.namaAdmin,
        idKelas: idKelas ?? this.idKelas,
        namaKelas: namaKelas ?? this.namaKelas,
        tanggalPendaftaran: tanggalPendaftaran ?? this.tanggalPendaftaran,
        statusPendaftaran: statusPendaftaran ?? this.statusPendaftaran,
      );

  factory Pendaftaran.fromJson(Map<String, dynamic> json) => Pendaftaran(
        idPendaftaran: json["id_pendaftaran"],
        idMurid: json["id_murid"],
        namaMurid: json["nama_murid"],
        idAdmin: json["id_admin"],
        namaAdmin: json["nama_admin"],
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
        tanggalPendaftaran: json["tanggal_pendaftaran"] == null
            ? null
            : DateTime.parse(json["tanggal_pendaftaran"]),
        statusPendaftaran: json["status_pendaftaran"],
      );

  Map<String, dynamic> toJson() => {
        "id_pendaftaran": idPendaftaran,
        "id_murid": idMurid,
        "nama_murid": namaMurid,
        "id_admin": idAdmin,
        "nama_admin": namaAdmin,
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
        "tanggal_pendaftaran": tanggalPendaftaran?.toIso8601String(),
        "status_pendaftaran": statusPendaftaran,
      };
}
