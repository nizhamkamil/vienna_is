// To parse this JSON data, do
//
//     final kelasKomplit = kelasKomplitFromJson(jsonString);
import 'dart:convert';

List<KelasKomplit> kelasKomplitFromJson(String str) => List<KelasKomplit>.from(
    json.decode(str).map((x) => KelasKomplit.fromJson(x)));

KelasFoto kelasFotoSingleFromJson(String str) =>
    KelasFoto.fromJson(json.decode(str));

String kelasKomplitToJson(List<KelasKomplit> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String kelasFotoSingleToJson(KelasFoto data) => json.encode(data.toJson());

List<KelasFoto> kelasFotoFromJson(String str) =>
    List<KelasFoto>.from(json.decode(str).map((x) => KelasFoto.fromJson(x)));

String kelasFotoToJson(List<KelasFoto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class KelasKomplit {
  final int idKelas;
  final String namaKelas;
  final String deskripsiKelas;
  final List<KelasFoto> kelasFoto;

  KelasKomplit({
    required this.idKelas,
    required this.namaKelas,
    required this.deskripsiKelas,
    required this.kelasFoto,
  });

  KelasKomplit copyWith({
    int? idKelas,
    String? namaKelas,
    String? deskripsiKelas,
    List<KelasFoto>? kelasFoto,
  }) =>
      KelasKomplit(
        idKelas: idKelas ?? this.idKelas,
        namaKelas: namaKelas ?? this.namaKelas,
        deskripsiKelas: deskripsiKelas ?? this.deskripsiKelas,
        kelasFoto: kelasFoto ?? this.kelasFoto,
      );

  factory KelasKomplit.fromJson(Map<String, dynamic> json) => KelasKomplit(
        idKelas: json["id_kelas"],
        namaKelas: json["nama_kelas"],
        deskripsiKelas: json["deskripsi_kelas"],
        kelasFoto: List<KelasFoto>.from(
            json["kelas_foto"].map((x) => KelasFoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_kelas": idKelas,
        "nama_kelas": namaKelas,
        "deskripsi_kelas": deskripsiKelas,
        "kelas_foto": List<dynamic>.from(kelasFoto.map((x) => x.toJson())),
      };
}

class KelasFoto {
  final int? idKelasFoto;
  final String? namaFoto;
  final String? pathFoto;
  final int? idKelas;

  KelasFoto({
    this.idKelasFoto,
    this.namaFoto,
    this.pathFoto,
    this.idKelas,
  });

  KelasFoto copyWith({
    int? idKelasFoto,
    String? namaFoto,
    String? pathFoto,
    int? idKelas,
  }) =>
      KelasFoto(
        idKelasFoto: idKelasFoto ?? this.idKelasFoto,
        namaFoto: namaFoto ?? this.namaFoto,
        pathFoto: pathFoto ?? this.pathFoto,
        idKelas: idKelas ?? this.idKelas,
      );

  factory KelasFoto.fromJson(Map<String, dynamic> json) => KelasFoto(
        idKelasFoto: json["id_kelas_foto"],
        namaFoto: json["nama_foto"],
        pathFoto: json["path_foto"],
        idKelas: json["id_kelas"],
      );

  Map<String, dynamic> toJson() => {
        "id_kelas_foto": idKelasFoto,
        "nama_foto": namaFoto,
        "path_foto": pathFoto,
        "id_kelas": idKelas,
      };
}
