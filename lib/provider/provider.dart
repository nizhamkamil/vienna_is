import 'package:get/get.dart';
import 'package:http/http.dart' as client;
import 'package:vienna_is/models/admin.dart';
import 'package:vienna_is/models/guru.dart';
import 'package:vienna_is/models/kelas.dart';
import 'package:vienna_is/models/murid.dart';

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
}
