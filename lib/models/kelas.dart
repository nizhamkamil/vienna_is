// To parse this JSON data, do
//
//     final kelas = kelasFromJson(jsonString);

import 'dart:convert';

List<Kelas> kelasFromJson(String str) =>
    List<Kelas>.from(json.decode(str).map((x) => Kelas.fromJson(x)));

Kelas kelasSingleFromJson(String str) => Kelas.fromJson(json.decode(str));

String kelasToJson(List<Kelas> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String kelasSingleToJson(Kelas data) => json.encode(data.toJson());

class Kelas {
  final int? idKelas;
  final String? namaKelas;
  final String? deskripsiKelas;

  Kelas({
    this.idKelas,
    this.namaKelas,
    this.deskripsiKelas,
  });

  Kelas copyWith({
    int? idKelas,
    String? namaKelas,
    String? deskripsiKelas,
  }) =>
      Kelas(
        idKelas: idKelas ?? this.idKelas,
        namaKelas: namaKelas ?? this.namaKelas,
        deskripsiKelas: deskripsiKelas ?? this.deskripsiKelas,
      );

  factory Kelas.fromJson(Map<String, dynamic> json) => Kelas(
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
        deskripsiKelas: json["deskripsi_kelas"],
      );

  Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
        "deskripsi_kelas": deskripsiKelas,
      };
}
