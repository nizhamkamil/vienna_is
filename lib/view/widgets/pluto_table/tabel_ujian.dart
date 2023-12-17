// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
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

class TabelUjian extends StatelessWidget {
  TabelUjian({super.key});
  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
        title: 'Id Ujian',
        field: 'idUjian',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
        title: 'Id Guru',
        field: 'idGuru',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
        title: 'Nama Guru',
        field: 'namaGuru',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
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
        title: 'Status Ujian',
        field: 'statusUjian',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Hasil Ujian',
        field: 'hasilUjian',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        hide: controller.userAdmin.value.idAdmin == null ? true : false,
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
        renderer: (rendererContext) {
          return Visibility(
            visible: controller.userAdmin.value.idAdmin == null ? false : true,
            child: Row(
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
                        controller.openEditUjian(rendererContext);
                        return ModalPopUp(
                          onPressed: () async {
                            if (controller.formKeyGuru.currentState!
                                .validate()) {
                              await controller.updateUjian(
                                  rendererContext.row.cells['idUjian']!.value);
                              plutoController.refreshPlutoTable(
                                controller.ujianStateManager!,
                                plutoController
                                    .getUjianRow(controller.ujianList),
                              );
                            }
                          },
                          popupTitle: 'Edit',
                          child: Column(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                  ),
                                  child: SingleChildScrollView(
                                      child: Form(
                                    key: controller.formKeyGuru,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        guruField(context),
                                        muridField(context),
                                        statusField(context),
                                        hasilField(context),
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
                              await controller.deleteUjian(
                                  rendererContext.row.cells['idUjian']!.value);
                              plutoController.refreshPlutoTable(
                                controller.ujianStateManager!,
                                plutoController
                                    .getUjianRow(controller.ujianList),
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
            ),
          );
        },
      ),
    ];
    return FutureBuilder(
      future: controller.userMurid.isNotEmpty
          ? controller.fetchUjianByIdMurid(controller.userMurid[0].idMurid!)
          : controller.userGuru.isNotEmpty
              ? controller.fetchUjianByIdGuru(controller.userGuru[0].idGuru!)
              : controller.fetchUjian(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PlutoGrid(
            noRowsWidget: Center(
              child: TextWidget(
                text: 'Anda tidak memiliki data ujian',
              ),
            ),
            mode: PlutoGridMode.readOnly,
            columns: column,
            rows: plutoController.getUjianRow(controller.ujianList),
            onLoaded: (event) {
              controller.ujianStateManager = event.stateManager;
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

  SizedBox guruField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Obx(
          () => TypeAheadFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Guru tidak boleh kosong';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller.idGuruUjianController.value,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Guru',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                suffixIcon: Visibility(
                  visible: controller.idGuruUjianController.value.text.isEmpty
                      ? false
                      : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idGuruUjianController.value.clear();
                      controller.idGuruUjian = null;
                      controller.idGuruUjianController.refresh();
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
              controller.idGuruUjianController.value.text = value.nama!;
              controller.idGuruUjian = value.idGuru!;
              controller.idGuruUjianController.refresh();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                title: TextWidget(
                  text: itemData.nama!,
                ),
              );
            },
            suggestionsCallback: (pattern) {
              return controller.guruList.where(
                  (e) => e.nama!.toLowerCase().contains(pattern.toLowerCase()));
            },
          ),
        ),
      ),
    );
  }

  SizedBox muridField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Obx(
          () => TypeAheadFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Murid tidak boleh kosong';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller.idMuridUjianController.value,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Murid',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                suffixIcon: Visibility(
                  visible: controller.idMuridUjianController.value.text.isEmpty
                      ? false
                      : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idMuridUjianController.value.clear();
                      controller.idMuridUjian = null;
                      controller.idMuridUjianController.refresh();
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
              controller.idMuridUjianController.value.text = value.nama!;
              controller.idMuridUjian = value.idMurid!;
              controller.idMuridUjianController.refresh();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                title: TextWidget(
                  text: itemData.nama!,
                ),
              );
            },
            suggestionsCallback: (pattern) {
              return controller.muridList.where(
                  (e) => e.nama!.toLowerCase().contains(pattern.toLowerCase()));
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
              return 'status tidak boleh kosong';
            } else {
              return null;
            }
          },
          value: controller.statusUjianController.value.text.isEmpty
              ? null
              : controller.statusUjianController.value.text,
          items: controller.dropdownStatusUjian,
          onChanged: (value) {
            controller.statusUjianController.value.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Status Ujian',
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

  SizedBox hasilField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Hasil Ujian tidak boleh kosong';
            } else {
              return null;
            }
          },
          value: controller.hasilUjianController.value.text.isEmpty
              ? null
              : controller.hasilUjianController.value.text,
          items: controller.dropdownHasilUjian,
          onChanged: (value) {
            controller.hasilUjianController.value.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Hasil Ujian',
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
