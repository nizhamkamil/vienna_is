import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vienna_is/controller/controller.dart';

import '../models/guru.dart';
import '../models/jadwal.dart';
import '../models/kelas_complete.dart';
import '../models/murid.dart';
import '../models/pendaftaran.dart';
import '../models/ruangan.dart';
import '../models/ujian.dart';

class PlutoController extends GetxController {
  Controller controller = Get.find();

  List<PlutoRow> getGuruRow(List<Guru> guru) {
    return List.generate(controller.guruList.length, (index) {
      return PlutoRow(
        cells: {
          'id_guru': PlutoCell(value: controller.guruList[index].idGuru),
          'nama': PlutoCell(value: controller.guruList[index].nama),
          'alamat': PlutoCell(value: controller.guruList[index].alamat),
          'email': PlutoCell(value: controller.guruList[index].email),
          'username': PlutoCell(value: controller.guruList[index].username),
          'password': PlutoCell(value: controller.guruList[index].password),
          'no_telepon': PlutoCell(value: controller.guruList[index].noTelepon),
          'agama': PlutoCell(value: controller.guruList[index].agama),
          'kewarganegaraan':
              PlutoCell(value: controller.guruList[index].kewarganegaraan),
          'jenis_kelamin':
              PlutoCell(value: controller.guruList[index].jenisKelamin),
          'status_nikah':
              PlutoCell(value: controller.guruList[index].statusNikah),
          'action': PlutoCell(value: ''),
        },
      );
    });
  }

  List<PlutoRow> getRuanganRow(List<Ruangan> ruangan) {
    return List.generate(controller.ruanganList.length, (index) {
      return PlutoRow(cells: {
        'idRuangan': PlutoCell(value: controller.ruanganList[index].idRuangan),
        'namaRuangan':
            PlutoCell(value: controller.ruanganList[index].namaRuangan),
        'deskripsiRuangan':
            PlutoCell(value: controller.ruanganList[index].deskripsiRuangan),
        'action': PlutoCell(value: ''),
      });
    });
  }

  List<PlutoRow> getJadwalRow(List<Jadwal> jadwal) {
    return List.generate(controller.jadwalList.length, (index) {
      return PlutoRow(cells: {
        'idJadwal': PlutoCell(value: controller.jadwalList[index].idJadwal),
        'jamMulai': PlutoCell(
            value: controller
                .formatDateTimeToHHmm(controller.jadwalList[index].jamMulai!)),
        'jamSelesai': PlutoCell(
            value: controller.formatDateTimeToHHmm(
                controller.jadwalList[index].jamSelesai!)),
        'hari': PlutoCell(value: controller.jadwalList[index].hari),
        'idGuru': PlutoCell(value: controller.jadwalList[index].idGuru),
        'namaGuru': PlutoCell(value: controller.jadwalList[index].namaGuru),
        'idMurid': PlutoCell(value: controller.jadwalList[index].idMurid),
        'namaMurid': PlutoCell(value: controller.jadwalList[index].namaMurid),
        'idKelas': PlutoCell(value: controller.jadwalList[index].idKelas),
        'namaKelas': PlutoCell(value: controller.jadwalList[index].namaKelas),
        'idTingkatan':
            PlutoCell(value: controller.jadwalList[index].idTingkatan),
        'namaTingkatan':
            PlutoCell(value: controller.jadwalList[index].namaTingkatan),
        'idRuangan': PlutoCell(value: controller.jadwalList[index].idRuangan),
        'namaRuangan':
            PlutoCell(value: controller.jadwalList[index].namaRuangan),
        'action': PlutoCell(value: ''),
      });
    });
  }

  List<PlutoRow> getKelasRow(List<KelasKomplit> kelas) {
    return List.generate(controller.kelasKomplitList.length, (index) {
      return PlutoRow(cells: {
        'idKelas': PlutoCell(value: controller.kelasKomplitList[index].idKelas),
        'namaKelas':
            PlutoCell(value: controller.kelasKomplitList[index].namaKelas),
        'deskripsiKelas':
            PlutoCell(value: controller.kelasKomplitList[index].deskripsiKelas),
        'fotoKelas': PlutoCell(
            value: controller.kelasKomplitList[index].kelasFoto[0].pathFoto),
        'action': PlutoCell(value: ''),
      });
    });
  }

  List<PlutoRow> getPendaftaranRow(List<Pendaftaran> pendaftaran) {
    return List.generate(controller.pendaftaranList.length, (index) {
      return PlutoRow(cells: {
        'idPendaftaran':
            PlutoCell(value: controller.pendaftaranList[index].idPendaftaran),
        'idMurid': PlutoCell(value: controller.pendaftaranList[index].idMurid),
        'namaMurid':
            PlutoCell(value: controller.pendaftaranList[index].namaMurid),
        'idAdmin': PlutoCell(value: controller.pendaftaranList[index].idAdmin),
        'namaAdmin':
            PlutoCell(value: controller.pendaftaranList[index].namaAdmin),
        'idKelas': PlutoCell(value: controller.pendaftaranList[index].idKelas),
        'namaKelas':
            PlutoCell(value: controller.pendaftaranList[index].namaKelas),
        'tanggalPendaftaran': PlutoCell(
            value: controller.pendaftaranList[index].tanggalPendaftaran),
        'statusPendaftaran': PlutoCell(
            value: controller.pendaftaranList[index].statusPendaftaran),
        'action': PlutoCell(value: ''),
      });
    });
  }

  List<PlutoRow> getUjianRow(List<Ujian> ujian) {
    return List.generate(controller.ujianList.length, (index) {
      return PlutoRow(cells: {
        'idUjian': PlutoCell(value: controller.ujianList[index].idUjian),
        'idGuru': PlutoCell(value: controller.ujianList[index].idGuru),
        'namaGuru': PlutoCell(value: controller.ujianList[index].namaGuru),
        'idMurid': PlutoCell(value: controller.ujianList[index].idMurid),
        'namaMurid': PlutoCell(value: controller.ujianList[index].namaMurid),
        'statusUjian':
            PlutoCell(value: controller.ujianList[index].statusUjian),
        'hasilUjian': PlutoCell(value: controller.ujianList[index].hasilUjian),
        'action': PlutoCell(value: ''),
      });
    });
  }

  List<PlutoRow> getMuridRow(List<Murid> murid) {
    return List.generate(
      controller.muridList.length,
      (index) {
        return PlutoRow(
          cells: {
            'idMurid': PlutoCell(value: controller.muridList[index].idMurid),
            'nama': PlutoCell(value: controller.muridList[index].nama),
            'username': PlutoCell(value: controller.muridList[index].username),
            'password': PlutoCell(value: controller.muridList[index].password),
            'alamat': PlutoCell(value: controller.muridList[index].alamat),
            'email': PlutoCell(value: controller.muridList[index].email),
            'noTelepon':
                PlutoCell(value: controller.muridList[index].noTelepon),
            'jenisKelamin':
                PlutoCell(value: controller.muridList[index].jenisKelamin),
            'tanggalMasuk':
                PlutoCell(value: controller.muridList[index].tanggalMasuk),
            'agama': PlutoCell(value: controller.muridList[index].agama),
            'kewarganegaraan':
                PlutoCell(value: controller.muridList[index].kewarganegaraan),
            'statusDaftar':
                PlutoCell(value: controller.muridList[index].statusDaftar),
            'namaWali': PlutoCell(value: controller.muridList[index].namaWali),
            'tanggalLahir':
                PlutoCell(value: controller.muridList[index].tanggalLahir),
            'tempatLahir':
                PlutoCell(value: controller.muridList[index].tempatLahir),
            'tipePembelajaran':
                PlutoCell(value: controller.muridList[index].tipePembelajaran),
            'action': PlutoCell(value: ''),
          },
        );
      },
    );
  }

  refreshPlutoTable(PlutoGridStateManager manager, List<PlutoRow> row) {
    manager.removeAllRows();
    manager.appendRows(row);
  }
}
