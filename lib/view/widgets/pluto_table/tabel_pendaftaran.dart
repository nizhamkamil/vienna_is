// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

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

class TabelPendaftaran extends StatelessWidget {
  TabelPendaftaran({super.key});
  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
        title: 'Id Pendaftaran',
        field: 'idPendaftaran',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
        title: 'Id Murid',
        field: 'idMurid',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
        title: 'Nama Murid',
        field: 'namaMurid',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Id Admin',
        field: 'idAdmin',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
        title: 'Nama Admin',
        field: 'namaAdmin',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
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
      ),
      PlutoColumn(
        title: 'Tanggal Pendaftaran',
        field: 'tanggalPendaftaran',
        type: PlutoColumnType.date(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Status Pendaftaran',
        field: 'statusPendaftaran',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
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
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      controller.openEditPendaftaran(rendererContext);
                      return ModalPopUp(
                        onPressed: () async {
                          if (controller.formKeyGuru.currentState!.validate()) {
                            await controller.updatePendaftaran(rendererContext
                                .row.cells['idPendaftaran']!.value);
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
                                      kelasField(context),
                                      statusField(context),
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
                            await controller.deletePendaftaran(rendererContext
                                .row.cells['idPendaftaran']!.value);
                            plutoController.refreshPlutoTable(
                              controller.pendaftaranStateManager!,
                              plutoController.getPendaftaranRow(
                                  controller.pendaftaranList),
                            );
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
      future: controller.fetchPendaftaran(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PlutoGrid(
            mode: PlutoGridMode.readOnly,
            columns: column,
            rows: plutoController.getPendaftaranRow(controller.pendaftaranList),
            onLoaded: (event) {
              controller.pendaftaranStateManager = event.stateManager;
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

  SizedBox kelasField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Obx(
          () => TypeAheadFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Kelas tidak boleh kosong';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller.kelasPendaftaranController.value,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Kelas',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                suffixIcon: Visibility(
                  visible:
                      controller.kelasPendaftaranController.value.text.isEmpty
                          ? false
                          : true,
                  child: IconButton(
                    onPressed: () {
                      controller.kelasPendaftaranController.value.clear();
                      controller.idKelasPendaftaran = null;
                      controller.kelasPendaftaranController.refresh();
                    },
                    icon: Icon(Icons.clear),
                  ),
                ),
              ),
            ),
            suggestionsBoxDecoration: const SuggestionsBoxDecoration(
              constraints: BoxConstraints(maxHeight: 175, minHeight: 50),
            ),
            onSuggestionSelected: (value) {
              controller.kelasPendaftaranController.value.text =
                  value.namaKelas;
              controller.idKelasPendaftaran = value.idKelas;
              controller.kelasPendaftaranController.refresh();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                title: TextWidget(
                  text: itemData.namaKelas,
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              if (controller.kelasList.isEmpty) {
                await controller.fetchKelas();
              }
              return controller.kelasKomplitList.where((e) =>
                  e.namaKelas.toLowerCase().contains(pattern.toLowerCase()));
            },
          ),
        ),
      ),
    );
  }

  SizedBox statusField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Status tidak boleh kosong';
            } else {
              return null;
            }
          },
          value: controller.statusPendaftaranController.value.text.isEmpty
              ? null
              : controller.statusPendaftaranController.value.text,
          items: controller.dropdownStatusDaftar,
          onChanged: (value) {
            controller.statusPendaftaranController.value.text =
                value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Status',
              size: 16,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(4),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
