import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:vienna_is/controller/pluto_controller.dart';
import 'package:vienna_is/models/admin.dart';
import 'package:vienna_is/models/guru.dart';
import 'package:vienna_is/models/jadwal.dart';
import 'package:vienna_is/models/kelas.dart';
import 'package:vienna_is/models/kelas_complete.dart';
import 'package:vienna_is/models/ruangan.dart';
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
  RxList<Ruangan> ruanganList = <Ruangan>[].obs;
  RxString role = ''.obs;
  String username = '';
  String password = '';

  //State Manager
  PlutoGridStateManager? guruStateManager;
  PlutoGridStateManager? jadwalStateManager;
  PlutoGridStateManager? kelasStateManager;
  PlutoGridStateManager? muridStateManager;
  PlutoGridStateManager? pendaftaranStateManager;
  PlutoGridStateManager? ruanganStateManager;
  PlutoGridStateManager? ujianStateManager;

  //Key Form
  GlobalKey<FormState> formKeyGuru = GlobalKey<FormState>();

  //TextEditingController
  TextEditingController namaController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
  TextEditingController agamaController = TextEditingController();
  TextEditingController kewarganegaraanController = TextEditingController();
  TextEditingController jenisKelaminController = TextEditingController();
  TextEditingController statusNikahController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //Constant
  List<DropdownMenuItem> dropdownJenisKelamin = [
    const DropdownMenuItem(
      value: 'Laki-laki',
      child: Text('Laki-laki'),
    ),
    const DropdownMenuItem(
      value: 'Perempuan',
      child: Text('Perempuan'),
    ),
  ];

  List<DropdownMenuItem> dropdownAgama = [
    const DropdownMenuItem(
      value: 'Islam',
      child: Text('Islam'),
    ),
    const DropdownMenuItem(
      value: 'Kristen',
      child: Text('Kristen'),
    ),
    const DropdownMenuItem(
      value: 'Buddha',
      child: Text('Buddha'),
    ),
    const DropdownMenuItem(
      value: 'Hindu',
      child: Text('Hindu'),
    ),
  ];

  List<DropdownMenuItem> dropdownStatusNikah = [
    const DropdownMenuItem(
        value: 'Belum menikah', child: Text('Belum menikah')),
    const DropdownMenuItem(
        value: 'Sudah menikah', child: Text('Sudah menikah')),
  ];

  List<SidebarXItem> sidebarMenuItemGuru = [
    SidebarXItem(
      icon: Icons.home,
      label: 'Halaman Utama',
      onTap: () {
        debugPrint('Home');
      },
    ),
    const SidebarXItem(
      icon: Icons.people,
      label: 'Halaman Murid',
    ),
    const SidebarXItem(
      icon: Icons.schedule,
      label: 'Halaman Jadwal',
    ),
    const SidebarXItem(
      icon: Icons.book,
      label: 'Halaman Ujian',
    ),
  ];

  List<SidebarXItem> sidebarMenuItemMurid = [
    SidebarXItem(
      icon: Icons.home,
      label: 'Halaman Utama',
      onTap: () {
        debugPrint('Home');
      },
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

  List<SidebarXItem> sidebarMenuItemAdmin = [
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

  clearTextEditingController() {
    namaController.clear();
    alamatController.clear();
    usernameController.clear();
    passwordController.clear();
    emailController.clear();
    noTeleponController.clear();
    agamaController.clear();
    kewarganegaraanController.clear();
    jenisKelaminController.clear();
    statusNikahController.clear();
  }

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
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    SharedPreferences prefs = await preferences;
    prefs.setString('username', username);
    prefs.setString('password', password);
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    String jsonRequest = jsonEncode(body);
    var res = await AppProvider.loginMurid(jsonRequest);
    userMurid.value = res;
    return res;
  }

  Future<Admin> loginAdmin(String username, String password) async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    SharedPreferences prefs = await preferences;
    prefs.setString('username', username);
    prefs.setString('password', password);
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    String jsonRequest = jsonEncode(body);
    var res = await AppProvider.loginAdmin(jsonRequest);
    userAdmin.value = res;
    return userAdmin.value;
  }

  //!START GURU
  Future<List<Guru>> loginGuru(String username, String password) async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    SharedPreferences prefs = await preferences;
    prefs.setString('username', username);
    prefs.setString('password', password);
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };
    String jsonRequest = jsonEncode(body);
    var res = await AppProvider.loginGuru(jsonRequest);
    userGuru.value = res;
    return res;
  }

  Future<Guru> addGuru() async {
    PlutoController plutoController = Get.find();
    Guru request = Guru(
      idGuru: null,
      nama: namaController.text,
      username: usernameController.text,
      password: passwordController.text,
      alamat: alamatController.text,
      email: emailController.text,
      noTelepon: noTeleponController.text,
      agama: agamaController.text,
      kewarganegaraan: kewarganegaraanController.text,
      jenisKelamin: jenisKelaminController.text,
      statusNikah: statusNikahController.text,
    );
    String jsonRequest = guruSingleToJson(request);

    var res = await AppProvider.addGuru(jsonRequest);
    if (res.username != null) {
      await fetchGuru();
      plutoController.refreshPlutoTable(
        guruStateManager!,
        plutoController.getGuruRow(guruList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Guru berhasil ditambahkan',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Guru gagal ditambahkan',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    }
    return res;
  }

  Future<Guru> updateGuru(int id) async {
    PlutoController plutoController = Get.find();
    Guru request = Guru(
      idGuru: null,
      nama: namaController.text,
      username: usernameController.text,
      password: passwordController.text,
      alamat: alamatController.text,
      email: emailController.text,
      noTelepon: noTeleponController.text,
      agama: agamaController.text,
      kewarganegaraan: kewarganegaraanController.text,
      jenisKelamin: jenisKelaminController.text,
      statusNikah: statusNikahController.text,
    );
    String jsonRequest = guruSingleToJson(request);
    var res = await AppProvider.updateGuru(jsonRequest, id);
    if (res.username != null) {
      await fetchGuru();
      plutoController.refreshPlutoTable(
        guruStateManager!,
        plutoController.getGuruRow(guruList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Guru berhasil diupdate',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Guru gagal diupdate',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    }
    return res;
  }

  Future<String> deleteGuru(int id) async {
    PlutoController plutoController = Get.find();
    var res = await AppProvider.deleteGuru(id);
    if (res == 'SUCCESS') {
      await fetchGuru();
      plutoController.refreshPlutoTable(
        guruStateManager!,
        plutoController.getGuruRow(guruList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Guru berhasil dihapus',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
      return 'SUCCESS';
    } else {
      Get.snackbar(
        'Gagal',
        'Guru gagal dihapus',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
      return 'FAILED';
    }
  }

  openEditGuru(PlutoColumnRendererContext rendererContext) {
    namaController.text = rendererContext.row.cells['nama']!.value.toString();
    alamatController.text =
        rendererContext.row.cells['alamat']!.value.toString();
    emailController.text = rendererContext.row.cells['email']!.value.toString();
    usernameController.text =
        rendererContext.row.cells['username']!.value.toString();
    passwordController.text = rendererContext.row.cells['password']!.value;
    noTeleponController.text =
        rendererContext.row.cells['no_telepon']!.value.toString();
    agamaController.text = rendererContext.row.cells['agama']!.value.toString();
    kewarganegaraanController.text =
        rendererContext.row.cells['kewarganegaraan']!.value.toString();
    jenisKelaminController.text =
        rendererContext.row.cells['jenis_kelamin']!.value.toString();
    statusNikahController.text =
        rendererContext.row.cells['status_nikah']!.value.toString();
  }

  Future<List<Guru>> fetchGuru() async {
    var res = await AppProvider.getAllGuru();
    guruList.value = res;
    return res;
  }

  //!END GURU

  checkUserRole() async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    SharedPreferences prefs = await preferences;
    if (userGuru.isNotEmpty) {
      role.value = 'Guru';
      prefs.setString('role', 'Guru');
      return 'Guru';
    } else if (userMurid.isNotEmpty) {
      role.value = 'Murid';
      prefs.setString('role', 'Murid');
      return 'Murid';
    } else {
      role.value = 'Admin';
      prefs.setString('role', 'Admin');
      return 'Admin';
    }
  }

  logout() async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    SharedPreferences prefs = await preferences;

    prefs.remove('username');
    prefs.remove('password');
    prefs.remove('role');
    userAdmin.value = Admin();
    userGuru.clear();
    userMurid.clear();

    Get.offAllNamed('/login');
  }

  saveUserPassword() async {
    Future<SharedPreferences> preferences = SharedPreferences.getInstance();
    SharedPreferences prefs = await preferences;
    role.value = prefs.getString('role') ?? '';
    username = prefs.getString('username') ?? '';
    password = prefs.getString('password') ?? '';

    if (role.value == 'Murid' && userMurid.isEmpty) {
      await loginMurid(username, password);
      print(username);
      print(password);
      print(role);
      return 'murid';
    } else if (role.value == 'Guru' && userGuru.isEmpty) {
      await loginGuru(username, password);
      return 'guru';
    } else if (role.value == 'Admin' && userAdmin.value.idAdmin == null) {
      await loginAdmin(username, password);
      return 'admin';
    } else {
      return 'NO USER';
    }
    // String userRole = prefs.getString('role') ?? '';
    // if (userRole == 'Guru') {
    //   prefs.setString('username', userGuru[0].username);
    //   prefs.setString('password', userGuru[0].password);
    //   await loginGuru(username, password);
    //   prefs.setString('role', 'Guru');
    //   username = prefs.getString('username') ?? '';
    //   password = prefs.getString('password') ?? '';
    //   return 'guru';
    // } else if (userRole == 'Murid') {
    //   prefs.setString('username', userMurid[0].username);
    //   prefs.setString('password', userMurid[0].password);
    //   await loginMurid(username, password);
    //   prefs.setString('role', 'Murid');
    //   username = prefs.getString('username') ?? '';
    //   password = prefs.getString('password') ?? '';
    //   return 'murid';
    // } else {}
  }

  Future<List<Murid>> fetchMurid() async {
    var res = await AppProvider.getAllMurid();
    muridList.value = res;
    return res;
  }

  Future<List<Jadwal>> fetchJadwal() async {
    var res = await AppProvider.getAllJadwal();
    print('get jadwal');
    jadwalList.value = res;
    return res;
  }

  Future<List<Pendaftaran>> fetchPendaftaran() async {
    var res = await AppProvider.getAllPendaftaran();
    print('get pendaftaran');
    pendaftaranList.value = res;
    return res;
  }

  Future<List<Tingkatan>> fetchTingkatan() async {
    var res = await AppProvider.getAllTingkatan();
    tingkatanList.value = res;
    return res;
  }

  Future<List<Ujian>> fetchUjian() async {
    var res = await AppProvider.getAllUjian();
    ujianList.value = res;
    return res;
  }

  Future<List<Ruangan>> fetchRuangan() async {
    var res = await AppProvider.getAllRuangan();
    ruanganList.value = res;
    return res;
  }
}
