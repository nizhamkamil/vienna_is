// To parse this JSON data, do
//
//     final jadwal = jadwalFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<Jadwal> jadwalFromJson(String str) =>
    List<Jadwal>.from(json.decode(str).map((x) => Jadwal.fromJson(x)));

String jadwalToJson(List<Jadwal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Jadwal {
  final int idJadwal;
  final int idRuangan;
  final int idKelas;
  final int idTingkatan;
  final int idGuru;
  final int idMurid;
  final dynamic jamMulai;
  final dynamic jamSelesai;
  final String hari;

  Jadwal({
    required this.idJadwal,
    required this.idRuangan,
    required this.idKelas,
    required this.idTingkatan,
    required this.idGuru,
    required this.idMurid,
    required this.jamMulai,
    required this.jamSelesai,
    required this.hari,
  });

  Jadwal copyWith({
    int? idJadwal,
    int? idRuangan,
    int? idKelas,
    int? idTingkatan,
    int? idGuru,
    int? idMurid,
    dynamic jamMulai,
    dynamic jamSelesai,
    String? hari,
  }) =>
      Jadwal(
        idJadwal: idJadwal ?? this.idJadwal,
        idRuangan: idRuangan ?? this.idRuangan,
        idKelas: idKelas ?? this.idKelas,
        idTingkatan: idTingkatan ?? this.idTingkatan,
        idGuru: idGuru ?? this.idGuru,
        idMurid: idMurid ?? this.idMurid,
        jamMulai: jamMulai ?? this.jamMulai,
        jamSelesai: jamSelesai ?? this.jamSelesai,
        hari: hari ?? this.hari,
      );

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        idJadwal: json["id_jadwal"],
        idRuangan: json["id_ruangan"],
        idKelas: json["id_kelas"],
        idTingkatan: json["id_tingkatan"],
        idGuru: json["id_guru"],
        idMurid: json["id_murid"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        hari: json["hari"],
      );

  Map<String, dynamic> toJson() => {
        "id_jadwal": idJadwal,
        "id_ruangan": idRuangan,
        "id_kelas": idKelas,
        "id_tingkatan": idTingkatan,
        "id_guru": idGuru,
        "id_murid": idMurid,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "hari": hari,
      };
}
