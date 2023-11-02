import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vienna_is/controller/controller.dart';

import '../models/guru.dart';
import '../models/murid.dart';

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
