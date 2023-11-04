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

class TabelJadwal extends StatelessWidget {
  TabelJadwal({super.key});

  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
          title: 'Id Jadwal',
          field: 'idJadwal',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
      PlutoColumn(
        title: 'Jam Mulai',
        field: 'jamMulai',
        type: PlutoColumnType.time(),
        backgroundColor: kAccentBrownGoldColor,
        width: 100,
      ),
      PlutoColumn(
        title: 'Jam Selesai',
        field: 'jamSelesai',
        type: PlutoColumnType.time(),
        backgroundColor: kAccentBrownGoldColor,
        width: 100,
      ),
      PlutoColumn(
        title: 'Hari',
        field: 'hari',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
          title: 'Id Guru',
          field: 'idGuru',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
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
          width: 75),
      PlutoColumn(
        title: 'Nama Murid',
        field: 'namaMurid',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
          title: 'Id Kelas',
          field: 'idKelas',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
      PlutoColumn(
        title: 'Nama Kelas',
        field: 'namaKelas',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
          title: 'Id Tingkatan',
          field: 'idTingkatan',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
      PlutoColumn(
        title: 'Nama Tingkatan',
        field: 'namaTingkatan',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
          title: 'Id Ruangan',
          field: 'idRuangan',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
      PlutoColumn(
        title: 'Nama Ruangan',
        field: 'namaRuangan',
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
                      controller.clearTextEditingControllerJadwal();
                      controller.openEditJadwal(rendererContext);
                      return ModalPopUp(
                        onPressed: () async {
                          if (controller.formKeyGuru.currentState!.validate()) {
                            await controller.updateJadwal(
                                rendererContext.row.cells['idJadwal']!.value);
                            plutoController.refreshPlutoTable(
                                controller.jadwalStateManager!,
                                plutoController
                                    .getJadwalRow(controller.jadwalList));
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
                                            0.05),
                                child: SingleChildScrollView(
                                  child: Form(
                                    key: controller.formKeyGuru,
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              jamMulaiField(context),
                                              hariField(context),
                                              guruField(context),
                                              tingkatanField(context),
                                              ruanganField(context),
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              jamSelesaiField(context),
                                              muridField(context),
                                              kelasField(context),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
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
                            await controller.deleteJadwal(
                                rendererContext.row.cells['idJadwal']!.value);
                            plutoController.refreshPlutoTable(
                              controller.jadwalStateManager!,
                              plutoController
                                  .getJadwalRow(controller.jadwalList),
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
        future: controller.fetchJadwal(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PlutoGrid(
              mode: PlutoGridMode.readOnly,
              columns: column,
              rows: plutoController.getJadwalRow(controller.jadwalList),
              onLoaded: (event) {
                controller.jadwalStateManager = event.stateManager;
              },
              configuration: PlutoGridConfiguration(
                columnSize: PlutoGridColumnSizeConfig(
                    autoSizeMode: PlutoAutoSizeMode.none),
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
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        });
  }

  SizedBox jamMulaiField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          type: 'time',
          validator: true,
          textCtrl: controller.jamMulaiJadwalController.value,
          hintText: '',
          labelText: 'Jam Mulai',
          obscureText: false,
          readOnly: true,
        ),
      ),
    );
  }

  SizedBox jamSelesaiField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          type: 'time',
          validator: true,
          textCtrl: controller.jamSelesaiJadwalController.value,
          hintText: '',
          labelText: 'Jam Selesai',
          obscureText: false,
          readOnly: true,
        ),
      ),
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
              controller: controller.idGuruJadwalController.value,
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
                  visible: controller.idGuruJadwalController.value.text.isEmpty
                      ? false
                      : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idGuruJadwalController.value.clear();
                      controller.idGuruJadwal = null;
                      controller.idGuruJadwalController.refresh();
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
              controller.idGuruJadwalController.value.text = value.nama!;
              controller.idGuruJadwal = value.idGuru!;
              controller.idGuruJadwalController.refresh();
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
              controller: controller.idMuridJadwalController.value,
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
                  visible: controller.idMuridJadwalController.value.text.isEmpty
                      ? false
                      : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idMuridJadwalController.value.clear();
                      controller.idMuridJadwal = null;
                      controller.idMuridJadwalController.refresh();
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
              controller.idMuridJadwalController.value.text = value.nama!;
              controller.idMuridJadwal = value.idMurid!;
              controller.idMuridJadwalController.refresh();
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

  SizedBox tingkatanField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Obx(
          () => TypeAheadFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Tingkatan tidak boleh kosong';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller.idTingkatanJadwalController.value,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Tingkatan',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                suffixIcon: Visibility(
                  visible:
                      controller.idTingkatanJadwalController.value.text.isEmpty
                          ? false
                          : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idTingkatanJadwalController.value.clear();
                      controller.idTingkatanJadwal = null;
                      controller.idTingkatanJadwalController.refresh();
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
              controller.idTingkatanJadwalController.value.text =
                  value.namaTingkatan;
              controller.idTingkatanJadwal = value.idTingkatan;
              controller.idTingkatanJadwalController.refresh();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                title: TextWidget(
                  text: itemData.namaTingkatan,
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              if (controller.tingkatanList.isEmpty) {
                await controller.fetchTingkatan();
              }
              return controller.tingkatanList.where((e) => e.namaTingkatan
                  .toLowerCase()
                  .contains(pattern.toLowerCase()));
            },
          ),
        ),
      ),
    );
  }

  SizedBox ruanganField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: Obx(
          () => TypeAheadFormField(
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ruangan tidak boleh kosong';
              }
              return null;
            },
            textFieldConfiguration: TextFieldConfiguration(
              controller: controller.idRuanganJadwalController.value,
              decoration: InputDecoration(
                labelStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: 20,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                labelText: 'Ruangan',
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(4),
                  ),
                ),
                suffixIcon: Visibility(
                  visible:
                      controller.idRuanganJadwalController.value.text.isEmpty
                          ? false
                          : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idRuanganJadwalController.value.clear();
                      controller.idRuanganJadwal = null;
                      controller.idRuanganJadwalController.refresh();
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
              controller.idRuanganJadwalController.value.text =
                  value.namaRuangan ?? '';
              controller.idRuanganJadwal = value.idRuangan;
              controller.idRuanganJadwalController.refresh();
            },
            itemBuilder: (context, itemData) {
              return ListTile(
                title: TextWidget(
                  text: itemData.namaRuangan ?? '',
                ),
              );
            },
            suggestionsCallback: (pattern) async {
              if (controller.ruanganList.isEmpty) {
                await controller.fetchRuangan();
              }
              return controller.ruanganList.where((e) =>
                  e.namaRuangan!.toLowerCase().contains(pattern.toLowerCase()));
            },
          ),
        ),
      ),
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
              controller: controller.idKelasJadwalController.value,
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
                  visible: controller.idKelasJadwalController.value.text.isEmpty
                      ? false
                      : true,
                  child: IconButton(
                    onPressed: () {
                      controller.idKelasJadwalController.value.clear();
                      controller.idKelasJadwal = null;
                      controller.idKelasJadwalController.refresh();
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
              controller.idKelasJadwalController.value.text = value.namaKelas;
              controller.idKelasJadwal = value.idKelas;
              controller.idKelasJadwalController.refresh();
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

  SizedBox hariField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Hari tidak boleh kosong';
            } else {
              return null;
            }
          },
          value: controller.hariJadwalController.value.text.isEmpty
              ? null
              : controller.hariJadwalController.value.text,
          items: controller.dropdownHari,
          onChanged: (value) {
            controller.hariJadwalController.value.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Hari',
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
