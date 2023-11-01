import 'package:get/get.dart';
import 'package:http/http.dart' as client;
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

  static Future<Guru> addGuru(String body) async {
    var response = await client.post(Uri.parse('$config/guru'),
        body: body, headers: headers);
    if (response.statusCode == 200) {
      return guruSingleFromJson(response.body);
    } else {
      return Guru();
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

  static Future<List<Murid>> getAllMurid() async {
    var response = await client.get(Uri.parse('$config/murid'));
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

  static Future<List<Ruangan>> getAllRuangan() async {
    var response = await client.get(Uri.parse('$config/ruangan'));
    if (response.statusCode == 200) {
      return ruanganFromJson(response.body);
    } else {
      return <Ruangan>[];
    }
  }

  static Future<List<Jadwal>> getAllJadwal() async {
    var response = await client.get(Uri.parse('$config/jadwal_pembelajaran'));
    if (response.statusCode == 200) {
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
