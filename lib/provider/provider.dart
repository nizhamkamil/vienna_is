import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:http/http.dart' as client;
import 'package:image_picker/image_picker.dart';
import 'package:vienna_is/models/admin.dart';
import 'package:vienna_is/models/guru.dart';
import 'package:vienna_is/models/jadwal.dart';
import 'package:vienna_is/models/kelas.dart';
import 'package:vienna_is/models/murid.dart';
import 'package:vienna_is/models/pendaftaran.dart';
import 'package:vienna_is/models/ruangan.dart';
import 'package:vienna_is/models/tingkatan.dart';
import 'package:vienna_is/models/ujian.dart';

import '../models/kelas_complete.dart';

class AppProvider extends GetConnect {
  static var config = 'http://localhost:3000';
  static var headers = {
    'Content-Type': 'application/json',
  };

  static Future<List<Kelas>> getKelas() async {
    var respose = await client.get(Uri.parse('$config/kelas'));
    if (respose.statusCode == 200) {
      return kelasFromJson(respose.body);
    } else {
      return <Kelas>[];
    }
  }

  static Future<List<KelasFoto>> getKelasFotoById(int id) async {
    var respose = await client.get(Uri.parse('$config/kelas_foto/kelas/$id'));
    if (respose.statusCode == 200) {
      return kelasFotoFromJson(respose.body);
    } else {
      return <KelasFoto>[];
    }
  }

  static Future<List<Murid>> loginMurid(String body) async {
    var response = await client.post(Uri.parse('$config/murid/login'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      if (response.body == 'FAILED') {
        print('FAILED TO LOGIN');

        return <Murid>[];
      }
      print('Response body: ${response.body}');
      return muridFromJson(response.body);
    } else {
      return <Murid>[];
    }
  }

  static Future<List<Guru>> loginGuru(String body) async {
    var response = await client.post(Uri.parse('$config/guru/login'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      if (response.body == 'FAILED') {
        print('FAILED TO LOGIN');
        return <Guru>[];
      }
      print('Response body: ${response.body}');
      return guruFromJson(response.body);
    } else {
      return <Guru>[];
    }
  }

  static Future<Admin> loginAdmin(String body) async {
    var response = await client.post(Uri.parse('$config/admin/login'),
        body: body, headers: headers);
    print(body);
    if (response.statusCode == 200) {
      if (response.body == 'FAILED') {
        print('FAILED TO LOGIN');
        return Admin();
      }
      return adminFromJson(response.body);
    } else {
      return Admin();
    }
  }

  static Future<KelasFoto> addKelasFoto(String body) {
    return client
        .post(Uri.parse('$config/kelas_foto'), body: body, headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        return kelasFotoSingleFromJson(response.body);
      } else {
        return KelasFoto();
      }
    });
  }

  static Future<Pendaftaran> addPendaftaran(String body) {
    return client
        .post(Uri.parse('$config/pendaftaran'), body: body, headers: headers)
        .then((response) {
      if (response.statusCode == 200) {
        return pendaftaranSingleFromJson(response.body);
      } else {
        return Pendaftaran();
      }
    });
  }

  static Future<Ujian> addUjian(String body) async {
    var response = await client.post(Uri.parse('$config/ujian'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return ujianSingleFromJson(response.body);
    } else {
      return Ujian();
    }
  }

  static Future<Uint8List> getFoto(String path) {
    print('$config/assets/$path');
    return client.get(Uri.parse('$config/assets/$path')).then((response) {
      if (response.statusCode == 200) {
        return response.bodyBytes;
      } else {
        return Uint8List(0);
      }
    });
  }

  static Future<Kelas> addKelas(String body, RxList<XFile?> files) async {
    try {
      var uploadFailed = false;
      var response2 = await client.MultipartRequest(
        "POST",
        Uri.parse('$config/kelas_foto/upload'),
      );

      for (var i = 0; i < files.length; i++) {
        List<int> fileBytes = await files[i]!.readAsBytes();
        var multipartFile = client.MultipartFile.fromBytes(
          'photo',
          fileBytes,
          filename: files[i]!.name,
        );
        response2.files.add(multipartFile);
      }

      var streamedResponse = await response2.send();
      var res = await client.Response.fromStream(streamedResponse);

      if (res.statusCode != 200) {
        uploadFailed = true;
        print('Failed to upload image: ${res.body}');
      }

      if (uploadFailed) {
        throw Exception('One or more images failed to upload');
      }

      var response = await client.post(Uri.parse('$config/kelas'),
          body: body, headers: headers);

      if (response.statusCode == 200) {
        return kelasSingleFromJson(response.body);
      } else {
        return Kelas();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Guru> addGuru(String body) async {
    var response = await client.post(Uri.parse('$config/guru'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return guruSingleFromJson(response.body);
    } else {
      return Guru();
    }
  }

  static Future<Murid> addMurid(String body) async {
    var response = await client.post(Uri.parse('$config/murid'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return muridSingleFromJson(response.body);
    } else {
      return Murid();
    }
  }

  static Future<Jadwal> addJadwal(String body) async {
    var response = await client.post(Uri.parse('$config/jadwal_pembelajaran'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return jadwalSingleFromJson(response.body);
    } else {
      return Jadwal();
    }
  }

  static Future<Ruangan> addRuangan(String body) async {
    var response = await client.post(Uri.parse('$config/ruangan'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return ruanganSingleFromJson(response.body);
    } else {
      return Ruangan();
    }
  }

  static Future<Murid> updateMurid(String body, int id) async {
    var response = await client.put(Uri.parse('$config/murid/$id'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return muridSingleFromJson(response.body);
    } else {
      return Murid();
    }
  }

  static Future<Pendaftaran> updatePendaftaran(String body, int id) async {
    var response = await client.put(Uri.parse('$config/pendaftaran/$id'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return pendaftaranSingleFromJson(response.body);
    } else {
      return Pendaftaran();
    }
  }

  static Future<Ruangan> updateRuangan(String body, int id) async {
    var response = await client.put(Uri.parse('$config/ruangan/$id'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return ruanganSingleFromJson(response.body);
    } else {
      return Ruangan();
    }
  }

  static Future<Jadwal> updateJadwal(String body, int id) async {
    var response = await client.put(
        Uri.parse('$config/jadwal_pembelajaran/$id'),
        body: body,
        headers: headers);
    if (response.statusCode == 200) {
      return jadwalSingleFromJson(response.body);
    } else {
      return Jadwal();
    }
  }

  static Future<Ujian> updateUjian(String body, int id) async {
    var response = await client.put(Uri.parse('$config/ujian/$id'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return ujianSingleFromJson(response.body);
    } else {
      return Ujian();
    }
  }

  static Future<Kelas> updateKelas(
      String body, KelasKomplit kelasKomplit, RxList<XFile?> file) async {
    try {
      //DELETE ALL THE FOTO FIRST BEFORE UPLOADING NEW ONES
      for (var i = 0; i < kelasKomplit.kelasFoto.length; i++) {
        await deleteKelasFoto(kelasKomplit.kelasFoto[i].idKelasFoto!);
      }

      var response2 = client.MultipartRequest(
          "POST", Uri.parse('$config/kelas_foto/upload'));

      for (var i = 0; i < file.length; i++) {
        List<int> fileBytes = await file[i]!.readAsBytes();
        var multipartFile = client.MultipartFile.fromBytes(
          'photo',
          fileBytes,
          filename: file[i]!.name,
        );
        response2.files.add(multipartFile);
      }
      var streamedResponse = await response2.send();
      var res = await client.Response.fromStream(streamedResponse);
      if (res.statusCode != 200) {
        throw Exception('Failed to upload image');
      }

      var response = await client.put(
          Uri.parse('$config/kelas/${kelasKomplit.idKelas}'),
          body: body,
          headers: headers);

      if (response.statusCode == 200) {
        print('inilah body ${response.body}');
        return kelasSingleFromJson(response.body);
      } else {
        return Kelas();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future<Guru> updateGuru(String body, int id) async {
    var response = await client.put(Uri.parse('$config/guru/$id'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return guruSingleFromJson(response.body);
    } else {
      return Guru();
    }
  }

  static Future<String> deleteGuru(int id) async {
    var response = await client.delete(Uri.parse('$config/guru/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deleteUjian(int id) async {
    var response = await client.delete(Uri.parse('$config/ujian/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deletePendaftaran(int id) async {
    var response = await client.delete(Uri.parse('$config/pendaftaran/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deleteKelas(int id) async {
    var response = await client.delete(Uri.parse('$config/kelas/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deleteKelasFoto(int id) async {
    var response = await client.delete(Uri.parse('$config/kelas_foto/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deleteMurid(int id) async {
    var response = await client.delete(Uri.parse('$config/murid/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deleteJadwal(int id) async {
    var response =
        await client.delete(Uri.parse('$config/jadwal_pembelajaran/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<String> deleteRuangan(int id) async {
    var response = await client.delete(Uri.parse('$config/ruangan/$id'));
    if (response.statusCode == 200) {
      return 'SUCCESS';
    } else {
      return 'FAILED';
    }
  }

  static Future<List<Murid>> getAllMurid() async {
    var response = await client.get(Uri.parse('$config/murid'));
    if (response.statusCode == 200) {
      return muridFromJson(response.body);
    } else {
      return <Murid>[];
    }
  }

  static Future<List<Murid>> getAllMuridByIdGuru(int id) async {
    var response = await client.get(Uri.parse('$config/murid/$id'));
    if (response.statusCode == 200) {
      return muridFromJson(response.body);
    } else {
      return <Murid>[];
    }
  }

  static Future<List<Guru>> getAllGuru() async {
    var response = await client.get(Uri.parse('$config/guru'));

    if (response.statusCode == 200) {
      print(response.body);
      return guruFromJson(response.body);
    } else {
      return <Guru>[];
    }
  }

  static Future<List<Tingkatan>> getAllTingkatan() async {
    var response = await client.get(Uri.parse('$config/tingkatan'));
    if (response.statusCode == 200) {
      return tingkatanFromJson(response.body);
    } else {
      return <Tingkatan>[];
    }
  }

  static Future<List<Ujian>> getAllUjian() async {
    var response = await client.get(Uri.parse('$config/ujian'));
    if (response.statusCode == 200) {
      return ujianFromJson(response.body);
    } else {
      return <Ujian>[];
    }
  }

  static Future<List<Ujian>> getAllUjianByIdGuru(int id) async {
    var response = await client.get(Uri.parse('$config/ujian/guru/$id'));
    if (response.statusCode == 200) {
      return ujianFromJson(response.body);
    } else {
      return <Ujian>[];
    }
  }

  static Future<List<Ujian>> getAllUjianByIdMurid(int id) async {
    var response = await client.get(Uri.parse('$config/ujian/murid/$id'));
    if (response.statusCode == 200) {
      return ujianFromJson(response.body);
    } else {
      return <Ujian>[];
    }
  }

  static Future<List<Ruangan>> getAllRuangan() async {
    var response = await client.get(Uri.parse('$config/ruangan'));
    if (response.statusCode == 200) {
      return ruanganFromJson(response.body);
    } else {
      return <Ruangan>[];
    }
  }

  static Future<List<Jadwal>> getAllJadwalMurid(int id) async {
    var response =
        await client.get(Uri.parse('$config/jadwal_pembelajaran/murid/$id'));
    if (response.statusCode == 200) {
      print(response.body);
      return jadwalFromJson(response.body);
    } else {
      return <Jadwal>[];
    }
  }

  static Future<List<Jadwal>> getAllJadwalGuru(int id) async {
    var response =
        await client.get(Uri.parse('$config/jadwal_pembelajaran/guru/$id'));
    if (response.statusCode == 200) {
      print(response.body);
      return jadwalFromJson(response.body);
    } else {
      return <Jadwal>[];
    }
  }

  static Future<List<Jadwal>> getAllJadwal() async {
    var response = await client.get(Uri.parse('$config/jadwal_pembelajaran'));
    if (response.statusCode == 200) {
      print(response.body);
      return jadwalFromJson(response.body);
    } else {
      return <Jadwal>[];
    }
  }

  static Future<List<Pendaftaran>> getAllPendaftaran() async {
    var response = await client.get(Uri.parse('$config/pendaftaran'));
    if (response.statusCode == 200) {
      return pendaftaranFromJson(response.body);
    } else {
      return <Pendaftaran>[];
    }
  }
}
