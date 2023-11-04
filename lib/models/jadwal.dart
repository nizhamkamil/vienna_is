// To parse this JSON data, do
//
//     final jadwal = jadwalFromJson(jsonString);

import 'dart:convert';

List<Jadwal> jadwalFromJson(String str) =>
    List<Jadwal>.from(json.decode(str).map((x) => Jadwal.fromJson(x)));

Jadwal jadwalSingleFromJson(String str) => Jadwal.fromJson(json.decode(str));

String jadwalToJson(List<Jadwal> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String jadwalSingleToJson(Jadwal data) => json.encode(data.toJson());

class Jadwal {
  final int? idJadwal;
  final DateTime? jamMulai;
  final DateTime? jamSelesai;
  final String? hari;
  final int? idGuru;
  final String? namaGuru;
  final int? idMurid;
  final String? namaMurid;
  final int? idKelas;
  final String? namaKelas;
  final int? idTingkatan;
  final String? namaTingkatan;
  final int? idRuangan;
  final String? namaRuangan;

  Jadwal({
    this.idJadwal,
    this.jamMulai,
    this.jamSelesai,
    this.hari,
    this.idGuru,
    this.namaGuru,
    this.idMurid,
    this.namaMurid,
    this.idKelas,
    this.namaKelas,
    this.idTingkatan,
    this.namaTingkatan,
    this.idRuangan,
    this.namaRuangan,
  });

  Jadwal copyWith({
    int? idJadwal,
    DateTime? jamMulai,
    DateTime? jamSelesai,
    String? hari,
    int? idGuru,
    String? namaGuru,
    int? idMurid,
    String? namaMurid,
    int? idKelas,
    String? namaKelas,
    int? idTingkatan,
    String? namaTingkatan,
    int? idRuangan,
    String? namaRuangan,
  }) =>
      Jadwal(
        idJadwal: idJadwal ?? this.idJadwal,
        jamMulai: jamMulai ?? this.jamMulai,
        jamSelesai: jamSelesai ?? this.jamSelesai,
        hari: hari ?? this.hari,
        idGuru: idGuru ?? this.idGuru,
        namaGuru: namaGuru ?? this.namaGuru,
        idMurid: idMurid ?? this.idMurid,
        namaMurid: namaMurid ?? this.namaMurid,
        idKelas: idKelas ?? this.idKelas,
        namaKelas: namaKelas ?? this.namaKelas,
        idTingkatan: idTingkatan ?? this.idTingkatan,
        namaTingkatan: namaTingkatan ?? this.namaTingkatan,
        idRuangan: idRuangan ?? this.idRuangan,
        namaRuangan: namaRuangan ?? this.namaRuangan,
      );

  factory Jadwal.fromJson(Map<String, dynamic> json) => Jadwal(
        idJadwal: json["id_jadwal"],
        jamMulai: json["jam_mulai"] == null
            ? null
            : DateTime.parse(json["jam_mulai"]),
        jamSelesai: json["jam_selesai"] == null
            ? null
            : DateTime.parse(json["jam_selesai"]),
        hari: json["hari"],
        idGuru: json["id_guru"],
        namaGuru: json["nama_guru"],
        idMurid: json["id_murid"],
        namaMurid: json["nama_murid"],
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
        idTingkatan: json["id_tingkatan"],
        namaTingkatan: json["nama_tingkatan"],
        idRuangan: json["id_ruangan"],
        namaRuangan: json["nama_ruangan"],
      );

  Map<String, dynamic> toJson() => {
        "id_jadwal": idJadwal,
        "jam_mulai": jamMulai?.toIso8601String(),
        "jam_selesai": jamSelesai?.toIso8601String(),
        "hari": hari,
        "id_guru": idGuru,
        "nama_guru": namaGuru,
        "id_murid": idMurid,
        "nama_murid": namaMurid,
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
        "id_tingkatan": idTingkatan,
        "nama_tingkatan": namaTingkatan,
        "id_ruangan": idRuangan,
        "nama_ruangan": namaRuangan,
      };
}
