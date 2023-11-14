// To parse this JSON data, do
//
//     final ujian = ujianFromJson(jsonString);

import 'dart:convert';

List<Ujian> ujianFromJson(String str) =>
    List<Ujian>.from(json.decode(str).map((x) => Ujian.fromJson(x)));

Ujian ujianSingleFromJson(String str) => Ujian.fromJson(json.decode(str));

String ujianToJson(List<Ujian> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String ujianSingleToJson(Ujian data) => json.encode(data.toJson());

class Ujian {
  final int? idUjian;
  final int? idGuru;
  final String? namaGuru;
  final int? idMurid;
  final String? namaMurid;
  final String? statusUjian;
  final String? hasilUjian;

  Ujian({
    this.idUjian,
    this.idGuru,
    this.namaGuru,
    this.idMurid,
    this.namaMurid,
    this.statusUjian,
    this.hasilUjian,
  });

  Ujian copyWith({
    int? idUjian,
    int? idGuru,
    String? namaGuru,
    int? idMurid,
    String? namaMurid,
    String? statusUjian,
    String? hasilUjian,
  }) =>
      Ujian(
        idUjian: idUjian ?? this.idUjian,
        idGuru: idGuru ?? this.idGuru,
        namaGuru: namaGuru ?? this.namaGuru,
        idMurid: idMurid ?? this.idMurid,
        namaMurid: namaMurid ?? this.namaMurid,
        statusUjian: statusUjian ?? this.statusUjian,
        hasilUjian: hasilUjian ?? this.hasilUjian,
      );

  factory Ujian.fromJson(Map<String, dynamic> json) => Ujian(
        idUjian: json["id_ujian"],
        idGuru: json["id_guru"],
        namaGuru: json["nama_guru"],
        idMurid: json["id_murid"],
        namaMurid: json["nama_murid"],
        statusUjian: json["status_ujian"],
        hasilUjian: json["hasil_ujian"],
      );

  Map<String, dynamic> toJson() => {
        "id_ujian": idUjian,
        "id_guru": idGuru,
        "nama_guru": namaGuru,
        "id_murid": idMurid,
        "nama_murid": namaMurid,
        "status_ujian": statusUjian,
        "hasil_ujian": hasilUjian,
      };
}
