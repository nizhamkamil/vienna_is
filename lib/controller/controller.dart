import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  //TextEditingController Guru
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

  //TextEditingController Murid
  TextEditingController namaMuridController = TextEditingController();
  TextEditingController usernameMuridController = TextEditingController();
  TextEditingController passwordMuridController = TextEditingController();
  TextEditingController alamatMuridController = TextEditingController();
  TextEditingController emailMuridController = TextEditingController();
  TextEditingController noTeleponMuridController = TextEditingController();
  TextEditingController jenisKelaminMuridController = TextEditingController();
  TextEditingController tanggalMasukMuridController = TextEditingController();
  TextEditingController agamaMuridController = TextEditingController();
  TextEditingController kewarganegaraanMuridController =
      TextEditingController();
  TextEditingController statusDaftarMuridController = TextEditingController();
  TextEditingController namaWaliMuridController = TextEditingController();
  TextEditingController tanggalLahirMuridController = TextEditingController();
  TextEditingController tempatLahirMuridController = TextEditingController();
  TextEditingController tipePembelajaranMuridController =
      TextEditingController();

  //TextEditingController Ruangan
  TextEditingController namaRuanganController = TextEditingController();
  TextEditingController deskripsiRuanganController = TextEditingController();

  //TextEditingController Jadwal
  Rx<TextEditingController> jamMulaiJadwalController =
      TextEditingController().obs;
  Rx<TextEditingController> jamSelesaiJadwalController =
      TextEditingController().obs;
  Rx<TextEditingController> hariJadwalController = TextEditingController().obs;
  Rx<TextEditingController> idGuruJadwalController =
      TextEditingController().obs;
  Rx<TextEditingController> idMuridJadwalController =
      TextEditingController().obs;
  Rx<TextEditingController> idKelasJadwalController =
      TextEditingController().obs;
  Rx<TextEditingController> idTingkatanJadwalController =
      TextEditingController().obs;
  Rx<TextEditingController> idRuanganJadwalController =
      TextEditingController().obs;

  //Jadwal ID Foreign Key
  int? idGuruJadwal;
  int? idMuridJadwal;
  int? idKelasJadwal;
  int? idTingkatanJadwal;
  int? idRuanganJadwal;

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

  List<DropdownMenuItem> dropdownHari = [
    const DropdownMenuItem(
      value: 'Senin',
      child: Text('Senin'),
    ),
    const DropdownMenuItem(
      value: 'Selasa',
      child: Text('Selasa'),
    ),
    const DropdownMenuItem(
      value: 'Rabu',
      child: Text('Rabu'),
    ),
    const DropdownMenuItem(
      value: 'Kamis',
      child: Text('Kamis'),
    ),
    const DropdownMenuItem(
      value: 'Jumat',
      child: Text('Jumat'),
    ),
    const DropdownMenuItem(
      value: 'Sabtu',
      child: Text('Sabtu'),
    ),
    const DropdownMenuItem(
      value: 'Minggu',
      child: Text('Minggu'),
    ),
  ];

  List<DropdownMenuItem> dropdownTipePembelajaran = [
    const DropdownMenuItem(
      value: 'Ujian',
      child: Text('Ujian'),
    ),
    const DropdownMenuItem(
      value: 'Non-ujian',
      child: Text('Non-ujian'),
    ),
  ];

  List<DropdownMenuItem> dropdownStatusDaftar = [
    const DropdownMenuItem(
      value: 'Aktif',
      child: Text('Aktif'),
    ),
    const DropdownMenuItem(
      value: 'Tidak aktif',
      child: Text('Tidak aktif'),
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

  clearTextEditingControllerRuangan() {
    namaRuanganController.clear();
    deskripsiRuanganController.clear();
  }

  clearTextEditingControllerMurid() {
    namaMuridController.clear();
    usernameMuridController.clear();
    passwordMuridController.clear();
    alamatMuridController.clear();
    emailMuridController.clear();
    noTeleponMuridController.clear();
    jenisKelaminMuridController.clear();
    tanggalMasukMuridController.clear();
    agamaMuridController.clear();
    kewarganegaraanMuridController.clear();
    statusDaftarMuridController.clear();
    namaWaliMuridController.clear();
    tanggalLahirMuridController.clear();
    tempatLahirMuridController.clear();
    tipePembelajaranMuridController.clear();
  }

  clearTextEditingControllerJadwal() {
    jamMulaiJadwalController.value.clear();
    jamSelesaiJadwalController.value.clear();
    hariJadwalController.value.clear();
    idGuruJadwalController.value.clear();
    idMuridJadwalController.value.clear();
    idKelasJadwalController.value.clear();
    idTingkatanJadwalController.value.clear();
    idRuanganJadwalController.value.clear();

    idGuruJadwal = null;
    idMuridJadwal = null;
    idKelasJadwal = null;
    idTingkatanJadwal = null;
    idRuanganJadwal = null;
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

  //!START MURID
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

  Future<Murid> addMurid() async {
    PlutoController plutoController = Get.find();
    Murid request = Murid(
      idMurid: null,
      nama: namaMuridController.text,
      username: usernameMuridController.text,
      password: passwordMuridController.text,
      alamat: alamatMuridController.text,
      email: emailMuridController.text,
      noTelepon: noTeleponMuridController.text,
      agama: agamaMuridController.text,
      kewarganegaraan: kewarganegaraanMuridController.text,
      jenisKelamin: jenisKelaminMuridController.text,
      tanggalMasuk: convertYearMonthDayToDateTime(
          tanggalMasukMuridController.text.toString()),
      statusDaftar: statusDaftarMuridController.text,
      namaWali: namaWaliMuridController.text,
      tanggalLahir: convertYearMonthDayToDateTime(
          tanggalLahirMuridController.text.toString()),
      tempatLahir: tempatLahirMuridController.text,
      tipePembelajaran: tipePembelajaranMuridController.text,
    );
    String jsonRequest = muridSingleToJson(request);
    print(jsonRequest);

    var res = await AppProvider.addMurid(jsonRequest);
    if (res.username != null) {
      await fetchMurid();
      plutoController.refreshPlutoTable(
        muridStateManager!,
        plutoController.getMuridRow(muridList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Murid berhasil ditambahkan',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Murid gagal ditambahkan',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    }
    return res;
  }

  Future<List<Murid>> fetchMurid() async {
    var res = await AppProvider.getAllMurid();
    muridList.value = res;
    return res;
  }

  Future<Murid> updateMurid(int id) async {
    PlutoController plutoController = Get.find();
    Murid request = Murid(
      idMurid: null,
      nama: namaMuridController.text,
      username: usernameMuridController.text,
      password: passwordMuridController.text,
      alamat: alamatMuridController.text,
      email: emailMuridController.text,
      noTelepon: noTeleponMuridController.text,
      agama: agamaMuridController.text,
      kewarganegaraan: kewarganegaraanMuridController.text,
      jenisKelamin: jenisKelaminMuridController.text,
      tanggalMasuk: convertYearMonthDayToDateTime(
          tanggalMasukMuridController.text.toString()),
      statusDaftar: statusDaftarMuridController.text,
      namaWali: namaWaliMuridController.text,
      tanggalLahir: convertYearMonthDayToDateTime(
          tanggalLahirMuridController.text.toString()),
      tempatLahir: tempatLahirMuridController.text,
      tipePembelajaran: tipePembelajaranMuridController.text,
    );
    String jsonRequest = muridSingleToJson(request);
    print(jsonRequest);
    var res = await AppProvider.updateMurid(jsonRequest, id);
    if (res.username != null) {
      await fetchMurid();
      plutoController.refreshPlutoTable(
        muridStateManager!,
        plutoController.getMuridRow(muridList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Murid berhasil diupdate',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Murid gagal diupdate',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    }
    return res;
  }

  openEditMurid(PlutoColumnRendererContext rendererContext) {
    namaMuridController.text =
        rendererContext.row.cells['nama']!.value.toString();
    alamatMuridController.text =
        rendererContext.row.cells['alamat']!.value.toString();
    emailMuridController.text =
        rendererContext.row.cells['email']!.value.toString();
    usernameMuridController.text =
        rendererContext.row.cells['username']!.value.toString();
    passwordMuridController.text = rendererContext.row.cells['password']!.value;
    noTeleponMuridController.text =
        rendererContext.row.cells['noTelepon']!.value.toString();
    agamaMuridController.text =
        rendererContext.row.cells['agama']!.value.toString();
    kewarganegaraanMuridController.text =
        rendererContext.row.cells['kewarganegaraan']!.value.toString();
    jenisKelaminMuridController.text =
        rendererContext.row.cells['jenisKelamin']!.value.toString();
    statusDaftarMuridController.text =
        rendererContext.row.cells['statusDaftar']!.value.toString();
    namaWaliMuridController.text =
        rendererContext.row.cells['namaWali']!.value.toString();
    tipePembelajaranMuridController.text =
        rendererContext.row.cells['tipePembelajaran']!.value.toString();
    tanggalMasukMuridController.text = dateFormator(
        convertYearMonthDayToDateTime(
            rendererContext.row.cells['tanggalMasuk']!.value.toString()));
    tempatLahirMuridController.text =
        rendererContext.row.cells['tempatLahir']!.value.toString();
    tanggalLahirMuridController.text = dateFormator(
        convertYearMonthDayToDateTime(
            rendererContext.row.cells['tanggalLahir']!.value.toString()));
    namaWaliMuridController.text =
        rendererContext.row.cells['namaWali']!.value.toString();
  }

  Future<String> deleteMurid(int id) async {
    PlutoController plutoController = Get.find();
    var res = await AppProvider.deleteMurid(id);
    if (res == 'SUCCESS') {
      await fetchMurid();
      plutoController.refreshPlutoTable(
        muridStateManager!,
        plutoController.getMuridRow(muridList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Murid berhasil dihapus',
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
        'Murid gagal dihapus',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
      return 'FAILED';
    }
  }

  //!END MURID

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

  //!START RUANGAN
  Future<Ruangan> addRuangan() async {
    PlutoController plutoController = Get.find();
    Ruangan request = Ruangan(
      idRuangan: null,
      namaRuangan: namaRuanganController.text,
      deskripsiRuangan: deskripsiRuanganController.text,
    );
    String jsonRequest = ruanganSingleToJson(request);
    print(jsonRequest);

    var res = await AppProvider.addRuangan(jsonRequest);
    if (res.namaRuangan != null) {
      await fetchRuangan();
      plutoController.refreshPlutoTable(
        ruanganStateManager!,
        plutoController.getRuanganRow(ruanganList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Ruangan berhasil ditambahkan',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Ruangan gagal ditambahkan',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    }
    return res;
  }

  //Open Edit Ruangan
  openEditRuangan(PlutoColumnRendererContext rendererContext) {
    namaRuanganController.text =
        rendererContext.row.cells['namaRuangan']!.value.toString();
    deskripsiRuanganController.text =
        rendererContext.row.cells['deskripsiRuangan']!.value.toString();
  }

  //Update Ruangan
  Future<Ruangan> updateRuangan(int id) async {
    PlutoController plutoController = Get.find();
    Ruangan request = Ruangan(
      idRuangan: id,
      namaRuangan: namaRuanganController.text,
      deskripsiRuangan: deskripsiRuanganController.text,
    );
    String jsonRequest = ruanganSingleToJson(request);
    print(jsonRequest);
    var res = await AppProvider.updateRuangan(jsonRequest, id);
    if (res.namaRuangan != null) {
      await fetchRuangan();
      plutoController.refreshPlutoTable(
        ruanganStateManager!,
        plutoController.getRuanganRow(ruanganList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Ruangan berhasil diupdate',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Ruangan gagal diupdate',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
    }
    return res;
  }

  //Delete Ruangan
  Future<String> deleteRuangan(int id) async {
    PlutoController plutoController = Get.find();
    var res = await AppProvider.deleteRuangan(id);
    if (res == 'SUCCESS') {
      await fetchRuangan();
      plutoController.refreshPlutoTable(
        ruanganStateManager!,
        plutoController.getRuanganRow(ruanganList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Ruangan berhasil dihapus',
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
        'Ruangan gagal dihapus',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
        colorText: Colors.white,
      );
      return 'FAILED';
    }
  }
  //!END RUANGAN

  //!START JADWAL

  //Add Jadwal
  Future<Jadwal> addJadwal() async {
    PlutoController plutoController = Get.find();
    Jadwal request = Jadwal(
      idJadwal: null,
      jamMulai:
          convertTimeToDateTime(jamMulaiJadwalController.value.text.toString()),
      jamSelesai: convertTimeToDateTime(
          jamSelesaiJadwalController.value.text.toString()),
      hari: hariJadwalController.value.text,
      idGuru: idGuruJadwal,
      idMurid: idMuridJadwal,
      idKelas: idKelasJadwal,
      idTingkatan: idTingkatanJadwal,
      idRuangan: idRuanganJadwal,
    );
    String jsonRequest = jadwalSingleToJson(request);
    print(jsonRequest);

    var res = await AppProvider.addJadwal(jsonRequest);
    if (res.hari != null) {
      await fetchJadwal();
      plutoController.refreshPlutoTable(
        jadwalStateManager!,
        plutoController.getJadwalRow(jadwalList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Jadwal berhasil ditambahkan',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Jadwal gagal ditambahkan',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
    }
    return res;
  }

  openEditJadwal(PlutoColumnRendererContext rendererContext) {
    jamMulaiJadwalController.value.text =
        rendererContext.row.cells['jamMulai']!.value.toString();
    jamSelesaiJadwalController.value.text =
        rendererContext.row.cells['jamSelesai']!.value.toString();
    hariJadwalController.value.text =
        rendererContext.row.cells['hari']!.value.toString();
    idGuruJadwalController.value.text =
        rendererContext.row.cells['namaGuru']!.value.toString();
    idMuridJadwalController.value.text =
        rendererContext.row.cells['namaMurid']!.value.toString();
    idKelasJadwalController.value.text =
        rendererContext.row.cells['namaKelas']!.value.toString();
    idTingkatanJadwalController.value.text =
        rendererContext.row.cells['namaTingkatan']!.value.toString();
    idRuanganJadwalController.value.text =
        rendererContext.row.cells['namaRuangan']!.value.toString();
    hariJadwalController.value.text =
        rendererContext.row.cells['hari']!.value.toString();

    idGuruJadwal = rendererContext.row.cells['idGuru']!.value;
    idMuridJadwal = rendererContext.row.cells['idMurid']!.value;
    idKelasJadwal = rendererContext.row.cells['idKelas']!.value;
    idTingkatanJadwal = rendererContext.row.cells['idTingkatan']!.value;
    idRuanganJadwal = rendererContext.row.cells['idRuangan']!.value;
  }

  //DELETE JADWAL
  Future<String> deleteJadwal(int id) async {
    PlutoController plutoController = Get.find();
    var res = await AppProvider.deleteJadwal(id);
    if (res == 'SUCCESS') {
      await fetchJadwal();
      plutoController.refreshPlutoTable(
        jadwalStateManager!,
        plutoController.getJadwalRow(jadwalList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Jadwal berhasil dihapus',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      return 'SUCCESS';
    } else {
      Get.snackbar(
        'Gagal',
        'Jadwal gagal dihapus',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
      return 'FAILED';
    }
  }

  //UPDATE JADWAL
  Future<Jadwal> updateJadwal(int id) async {
    PlutoController plutoController = Get.find();
    Jadwal request = Jadwal(
      idJadwal: null,
      jamMulai:
          convertTimeToDateTime(jamMulaiJadwalController.value.text.toString()),
      jamSelesai: convertTimeToDateTime(
          jamSelesaiJadwalController.value.text.toString()),
      hari: hariJadwalController.value.text,
      idGuru: idGuruJadwal,
      idMurid: idMuridJadwal,
      idKelas: idKelasJadwal,
      idTingkatan: idTingkatanJadwal,
      idRuangan: idRuanganJadwal,
    );
    String jsonRequest = jadwalSingleToJson(request);
    print(jsonRequest);
    var res = await AppProvider.updateJadwal(jsonRequest, id);
    if (res.hari != null) {
      await fetchJadwal();
      plutoController.refreshPlutoTable(
        jadwalStateManager!,
        plutoController.getJadwalRow(jadwalList),
      );
      Get.back();
      Get.snackbar(
        'Berhasil',
        'Jadwal berhasil diupdate',
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
    } else {
      Get.snackbar(
        'Gagal',
        'Jadwal gagal diupdate',
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
        colorText: Colors.white,
      );
    }
    return res;
  }

  //!END JADWAL

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

  static dateFormator(DateTime? date) {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').format(date).toString();
    } else {
      return DateFormat('yyyy-MM-dd')
          .format(DateTime.utc(0001, 1, 1))
          .toString();
    }
  }

  static DateTime convertYearMonthDayToDateTime(String inputString) {
    DateFormat inputFormat = DateFormat('yyyy-MM-dd');
    DateTime dateTime = inputFormat.parse(inputString);
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS");
    String formattedDateTime = outputFormat.format(dateTime);

    return DateTime.parse(formattedDateTime);
  }

  //EXAMPLE
  //INPUT(2000-01-01 07:30:00.000Z)
  //OUTPUT(07:30)
  String formatDateTimeToHHmm(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  //EXAMPLE
  //INPUT(07:30)
  //OUTPUT(2000-01-01 07:30:00.000Z)
  DateTime convertTimeToDateTime(String timeString) {
    final fixedDate = DateTime(2000, 1, 1);
    final timeParts = timeString.split(':');
    if (timeParts.length == 2) {
      final hour = int.tryParse(timeParts[0]) ?? 0;
      final minute = int.tryParse(timeParts[1]) ?? 0;
      return fixedDate.add(Duration(hours: hour, minutes: minute));
    }
    return fixedDate; // Return a default date if the input is invalid
  }
}
