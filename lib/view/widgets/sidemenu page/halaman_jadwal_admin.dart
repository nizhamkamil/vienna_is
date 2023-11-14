// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';
import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../pluto_table/tabel_jadwal.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class HalamanJadwalAdmin extends StatelessWidget {
  HalamanJadwalAdmin({super.key});
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          TextWidget(
            text: 'Halaman Jadwal',
            size: 24,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: TextWidget(
                  text: 'Tabel Jadwal',
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ),
              Spacer(
                flex: 6,
              ),
              BtnWidget(
                radius: 4,
                height: 40,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ],
                btnColor: Colors.white,
                outlineColor: kBrownGoldColorSecondary,
                icon: Icon(
                  Icons.filter_alt,
                  color: kBrownGoldColorSecondary,
                ),
                onPress: () {
                  showFilter.value = !showFilter.value;
                  controller.jadwalStateManager
                      ?.setShowColumnFilter(showFilter.value);
                },
                textWidget: TextWidget(
                  text: 'Show Filter',
                  color: kBrownGoldColorSecondary,
                ),
              ),
              SizedBox(
                width: 30,
              ),
              BtnWidget(
                radius: 4,
                height: 40,
                btnColor: kBrownGoldColorSecondary,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ],
                icon: Icon(Icons.add),
                onPress: () {
                  showFloatingModalBottomSheet(
                      context: context,
                      builder: (context) {
                        controller.clearTextEditingControllerJadwal();
                        return ModalPopUp(
                          onPressed: () async {
                            if (controller.formKeyGuru.currentState!
                                .validate()) {
                              await controller.addJadwal();
                            }
                          },
                          popupTitle: 'Add New',
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
                      });
                },
                textWidget: TextWidget(
                  text: 'Add New',
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: TabelJadwal(),
          )
        ],
      ),
    );
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
