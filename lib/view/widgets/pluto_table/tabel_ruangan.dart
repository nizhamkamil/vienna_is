// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

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
import '../text_form_field_widget.dart';

class TabelRuangan extends StatelessWidget {
  TabelRuangan({super.key});

  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
        title: 'Id Ruangan',
        field: 'idRuangan',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
          title: 'Nama Ruangan',
          field: 'namaRuangan',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor,
          width: 100),
      PlutoColumn(
        title: 'Deskripsi Ruangan',
        field: 'deskripsiRuangan',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
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
                  controller.clearTextEditingControllerRuangan();
                  controller.openEditRuangan(rendererContext);
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModalPopUp(
                        onPressed: () async {
                          if (controller.formKeyGuru.currentState!.validate()) {
                            await controller.updateRuangan(
                                rendererContext.row.cells['idRuangan']!.value);
                            plutoController.refreshPlutoTable(
                                controller.ruanganStateManager!,
                                plutoController
                                    .getRuanganRow(controller.ruanganList));
                          }
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
                                    children: [
                                      namaRuanganField(context),
                                      deskripsiRuanganField(context),
                                    ],
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
                            await controller.deleteRuangan(
                                rendererContext.row.cells['idRuangan']!.value);
                            plutoController.refreshPlutoTable(
                                controller.ruanganStateManager!,
                                plutoController
                                    .getRuanganRow(controller.ruanganList));
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
      future: controller.fetchRuangan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PlutoGrid(
            mode: PlutoGridMode.readOnly,
            columns: column,
            rows: plutoController.getRuanganRow(controller.ruanganList),
            onLoaded: (event) {
              controller.ruanganStateManager = event.stateManager;
            },
            configuration: PlutoGridConfiguration(
              columnSize: PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale),
              style: PlutoGridStyleConfig(
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

  SizedBox namaRuanganField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.namaRuanganController,
          hintText: '',
          labelText: 'Nama Ruangan',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox deskripsiRuanganField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          textInputType: TextInputType.multiline,
          minLines: 7,
          maxLines: 10,
          validator: true,
          textCtrl: controller.deskripsiRuanganController,
          hintText: '',
          labelText: 'Deskripsi Ruangan',
          obscureText: false,
        ),
      ),
    );
  }
}
