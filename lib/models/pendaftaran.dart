// To parse this JSON data, do
//
//     final pendaftaran = pendaftaranFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Pendaftaran> pendaftaranFromJson(String str) => List<Pendaftaran>.from(
    json.decode(str).map((x) => Pendaftaran.fromJson(x)));

String pendaftaranToJson(List<Pendaftaran> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Pendaftaran {
  final int idPendaftaran;
  final int idMurid;
  final int idAdmin;
  final int idKelas;
  final dynamic tanggalPendaftaran;
  final String statusPendaftaran;

  Pendaftaran({
    required this.idPendaftaran,
    required this.idMurid,
    required this.idAdmin,
    required this.idKelas,
    required this.tanggalPendaftaran,
    required this.statusPendaftaran,
  });

  Pendaftaran copyWith({
    int? idPendaftaran,
    int? idMurid,
    int? idAdmin,
    int? idKelas,
    dynamic tanggalPendaftaran,
    String? statusPendaftaran,
  }) =>
      Pendaftaran(
        idPendaftaran: idPendaftaran ?? this.idPendaftaran,
        idMurid: idMurid ?? this.idMurid,
        idAdmin: idAdmin ?? this.idAdmin,
        idKelas: idKelas ?? this.idKelas,
        tanggalPendaftaran: tanggalPendaftaran ?? this.tanggalPendaftaran,
        statusPendaftaran: statusPendaftaran ?? this.statusPendaftaran,
      );

  factory Pendaftaran.fromJson(Map<String, dynamic> json) => Pendaftaran(
        idPendaftaran: json["id_pendaftaran"],
        idMurid: json["id_murid"],
        idAdmin: json["id_admin"],
        idKelas: json["id_kelas"],
        tanggalPendaftaran: json["tanggal_pendaftaran"],
        statusPendaftaran: json["status_pendaftaran"],
      );

  Map<String, dynamic> toJson() => {
        "id_pendaftaran": idPendaftaran,
        "id_murid": idMurid,
        "id_admin": idAdmin,
        "id_kelas": idKelas,
        "tanggal_pendaftaran": tanggalPendaftaran,
        "status_pendaftaran": statusPendaftaran,
      };
}
