// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/controller/controller.dart';
import 'package:vienna_is/controller/pluto_controller.dart';

import '../alert_dialog_widget.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class TabelKelas extends StatelessWidget {
  TabelKelas({super.key});

  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        title: 'Id Kelas',
        field: 'idKelas',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
          title: 'Nama Kelas',
          field: 'namaKelas',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor,
          width: 100),
      PlutoColumn(
        title: 'Deskripsi Kelas',
        field: 'deskripsiKelas',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Foto Kelas',
        field: 'fotoKelas',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
        renderer: (rendererContext) {
          return Center(
            child: Image.network(
              '$configUrl/assets/${rendererContext.row.cells['fotoKelas']!.value}',
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
        width: 75,
        renderer: (rendererContext) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: Colors.blue,
                ),
                onPressed: () {
                  // controller.clearTextEditingControllerRuangan();
                  // controller.openEditRuangan(rendererContext);
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModalPopUp(
                        onPressed: () async {
                          // if (controller.formKeyGuru.currentState!.validate()) {
                          //   await controller.updateRuangan(
                          //       rendererContext.row.cells['idRuangan']!.value);
                          //   plutoController.refreshPlutoTable(
                          //       controller.ruanganStateManager!,
                          //       plutoController
                          //           .getRuanganRow(controller.ruanganList));
                          // }
                        },
                        popupTitle: 'Edit',
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
                                child: SingleChildScrollView(
                                    child: Form(
                                  key: controller.formKeyGuru,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [],
                                  ),
                                )),
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialogWidget(
                          onPress: () async {
                            // await controller.deleteRuangan(
                            //     rendererContext.row.cells['idRuangan']!.value);
                            // plutoController.refreshPlutoTable(
                            //     controller.ruanganStateManager!,
                            //     plutoController
                            //         .getRuanganRow(controller.ruanganList));
                          },
                        );
                      });
                },
                icon: Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
              )
            ],
          );
        },
      )
    ];

    return FutureBuilder(
      future: controller.fetchKelas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PlutoGrid(
            mode: PlutoGridMode.readOnly,
            columns: column,
            rows: plutoController.getKelasRow(controller.kelasKomplitList),
            onLoaded: (event) {
              controller.kelasStateManager = event.stateManager;
            },
            configuration: PlutoGridConfiguration(
              columnSize: PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale),
              style: PlutoGridStyleConfig(
                defaultCellPadding: EdgeInsets.symmetric(vertical: 4),
                rowHeight: 125,
                borderColor: Colors.transparent,
                oddRowColor: kWhiteBackground,
                gridBorderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
            ),
            createFooter: (stateManager) {
              stateManager.setPageSize(10, notify: false);
              return PlutoPagination(stateManager);
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
