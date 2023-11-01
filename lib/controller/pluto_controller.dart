import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vienna_is/controller/controller.dart';

import '../models/guru.dart';

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

  refreshPlutoTable(PlutoGridStateManager manager, List<PlutoRow> row) {
    manager.removeAllRows();
    manager.appendRows(row);
  }
}
