// To parse this JSON data, do
//
//     final tingkatan = tingkatanFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Tingkatan> tingkatanFromJson(String str) =>
    List<Tingkatan>.from(json.decode(str).map((x) => Tingkatan.fromJson(x)));

String tingkatanToJson(List<Tingkatan> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Tingkatan {
  final int idTingkatan;
  final String deskripsiTingkatan;
  final String namaTingkatan;

  Tingkatan({
    required this.idTingkatan,
    required this.deskripsiTingkatan,
    required this.namaTingkatan,
  });

  Tingkatan copyWith({
    int? idTingkatan,
    String? deskripsiTingkatan,
    String? namaTingkatan,
  }) =>
      Tingkatan(
        idTingkatan: idTingkatan ?? this.idTingkatan,
        deskripsiTingkatan: deskripsiTingkatan ?? this.deskripsiTingkatan,
        namaTingkatan: namaTingkatan ?? this.namaTingkatan,
      );

  factory Tingkatan.fromJson(Map<String, dynamic> json) => Tingkatan(
        idTingkatan: json["id_tingkatan"],
        deskripsiTingkatan: json["deskripsi_tingkatan"],
        namaTingkatan: json["nama_tingkatan"],
      );

  Map<String, dynamic> toJson() => {
        "id_tingkatan": idTingkatan,
        "deskripsi_tingkatan": deskripsiTingkatan,
        "nama_tingkatan": namaTingkatan,
      };
}
