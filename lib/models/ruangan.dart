// To parse this JSON data, do
//
//     final ruangan = ruanganFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Ruangan> ruanganFromJson(String str) =>
    List<Ruangan>.from(json.decode(str).map((x) => Ruangan.fromJson(x)));

String ruanganToJson(List<Ruangan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ruangan {
  final int idRuangan;
  final String namaRuangan;
  final String deskripsiRuangan;

  Ruangan({
    required this.idRuangan,
    required this.namaRuangan,
    required this.deskripsiRuangan,
  });

  Ruangan copyWith({
    int? idRuangan,
    String? namaRuangan,
    String? deskripsiRuangan,
  }) =>
      Ruangan(
        idRuangan: idRuangan ?? this.idRuangan,
        namaRuangan: namaRuangan ?? this.namaRuangan,
        deskripsiRuangan: deskripsiRuangan ?? this.deskripsiRuangan,
      );

  factory Ruangan.fromJson(Map<String, dynamic> json) => Ruangan(
        idRuangan: json["id_ruangan"],
        namaRuangan: json["nama_ruangan"],
        deskripsiRuangan: json["deskripsi_ruangan"],
      );

  Map<String, dynamic> toJson() => {
        "id_ruangan": idRuangan,
        "nama_ruangan": namaRuangan,
        "deskripsi_ruangan": deskripsiRuangan,
      };
}
