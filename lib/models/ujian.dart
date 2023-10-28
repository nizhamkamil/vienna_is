// To parse this JSON data, do
//
//     final ujian = ujianFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Ujian> ujianFromJson(String str) =>
    List<Ujian>.from(json.decode(str).map((x) => Ujian.fromJson(x)));

String ujianToJson(List<Ujian> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Ujian {
  final int idUjian;
  final int idGuru;
  final int idMurid;
  final String statusUjian;
  final String hasilUjian;

  Ujian({
    required this.idUjian,
    required this.idGuru,
    required this.idMurid,
    required this.statusUjian,
    required this.hasilUjian,
  });

  Ujian copyWith({
    int? idUjian,
    int? idGuru,
    int? idMurid,
    String? statusUjian,
    String? hasilUjian,
  }) =>
      Ujian(
        idUjian: idUjian ?? this.idUjian,
        idGuru: idGuru ?? this.idGuru,
        idMurid: idMurid ?? this.idMurid,
        statusUjian: statusUjian ?? this.statusUjian,
        hasilUjian: hasilUjian ?? this.hasilUjian,
      );

  factory Ujian.fromJson(Map<String, dynamic> json) => Ujian(
        idUjian: json["id_ujian"],
        idGuru: json["id_guru"],
        idMurid: json["id_murid"],
        statusUjian: json["status_ujian"],
        hasilUjian: json["hasil_ujian"],
      );

  Map<String, dynamic> toJson() => {
        "id_ujian": idUjian,
        "id_guru": idGuru,
        "id_murid": idMurid,
        "status_ujian": statusUjian,
        "hasil_ujian": hasilUjian,
      };
}
