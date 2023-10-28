import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:vienna_is/models/admin.dart';
import 'package:vienna_is/models/guru.dart';
import 'package:vienna_is/models/jadwal.dart';
import 'package:vienna_is/models/kelas.dart';
import 'package:vienna_is/models/kelas_complete.dart';
import 'package:vienna_is/models/tingkatan.dart';
import 'package:vienna_is/models/ujian.dart';
import 'package:vienna_is/provider/provider.dart';

import '../models/murid.dart';
import '../models/pendaftaran.dart';

class Controller extends GetxController {
  List<String> loginType = ['Guru', 'Murid', 'Admin'];
  RxList<Kelas> kelasList = <Kelas>[].obs;
  RxList<KelasKomplit> kelasKomplitList = <KelasKomplit>[].obs;
  RxList<Murid> muridList = <Murid>[].obs;
  RxList<Murid> userMurid = <Murid>[].obs;
  RxList<Guru> guruList = <Guru>[].obs;
  RxList<Guru> userGuru = <Guru>[].obs;
  Rx<Admin> userAdmin = Admin().obs;
  RxList<Jadwal> jadwalList = <Jadwal>[].obs;
  RxList<Pendaftaran> pendaftaranList = <Pendaftaran>[].obs;
  RxList<Tingkatan> tingkatanList = <Tingkatan>[].obs;
  RxList<Ujian> ujianList = <Ujian>[].obs;
  RxString role = ''.obs;

  List<SidebarXItem> sidebarMenuItem = [
    SidebarXItem(
      icon: Icons.home,
      label: 'Halaman Utama',
      onTap: () {
        debugPrint('Home');
      },
    ),
    const SidebarXItem(
      icon: Icons.person,
      label: 'Halaman Guru',
    ),
    const SidebarXItem(
      icon: Icons.people,
      label: 'Halaman Murid',
    ),
    const SidebarXItem(
      icon: Icons.piano,
      label: 'Halaman Kelas',
    ),
    const SidebarXItem(
      icon: Icons.meeting_room,
      label: 'Halaman Ruangan',
    ),
    const SidebarXItem(
      icon: Icons.schedule,
      label: 'Halaman Jadwal',
    ),
    const SidebarXItem(
      icon: Icons.app_registration,
      label: 'Halaman Pendaftaran',
    ),
    const SidebarXItem(
      icon: Icons.book,
      label: 'Halaman Ujian',
    ),
  ];

  Future<List<Kelas>> fetchKelas() async {
    var res = await AppProvider.getKelas();
    kelasList.value = res;
    kelasKomplitList.value = <KelasKomplit>[
      for (var row in kelasList)
        KelasKomplit(
          idKelas: row.idKelas,
          namaKelas: row.namaKelas,
          deskripsiKelas: row.deskripsiKelas,
          kelasFoto: await fetchKelasFotoById(row.idKelas),
        )
    ];
    print(kelasKomplitToJson(kelasKomplitList));
    return res;
  }

  Future<List<KelasFoto>> fetchKelasFotoById(int id) async {
    var res = await AppProvider.getKelasFotoById(id);
    return res;
  }

  Future<List<Murid>> loginMurid(String username, String password) async {
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    String jsonRequest = jsonEncode(body);
    var res = await AppProvider.loginMurid(jsonRequest);
    userMurid.value = res;
    return res;
  }

  Future<List<Guru>> loginGuru(String username, String password) async {
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    String jsonRequest = jsonEncode(body);
    var res = await AppProvider.loginGuru(jsonRequest);
    userGuru.value = res;
    return res;
  }

  Future<Admin> loginAdmin(String username, String password) async {
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    String jsonRequest = jsonEncode(body);
    var res = await AppProvider.loginAdmin(jsonRequest);
    userAdmin.value = res;
    return userAdmin.value;
  }

  checkUserRole() {
    if (userGuru.isNotEmpty) {
      role.value = 'Guru';
      return 'Guru';
    } else if (userMurid.isNotEmpty) {
      role.value = 'Murid';
      return 'Murid';
    } else {
      role.value = 'Admin';
      return 'Admin';
    }
  }
}
