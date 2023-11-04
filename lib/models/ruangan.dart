// To parse this JSON data, do
//
//     final ruangan = ruanganFromJson(jsonString);

import 'dart:convert';

List<Ruangan> ruanganFromJson(String str) =>
    List<Ruangan>.from(json.decode(str).map((x) => Ruangan.fromJson(x)));

Ruangan ruanganSingleFromJson(String str) => Ruangan.fromJson(json.decode(str));

String ruanganToJson(List<Ruangan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String ruanganSingleToJson(Ruangan data) => json.encode(data.toJson());

class Ruangan {
  final int? idRuangan;
  final String? namaRuangan;
  final String? deskripsiRuangan;

  Ruangan({
    this.idRuangan,
    this.namaRuangan,
    this.deskripsiRuangan,
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
