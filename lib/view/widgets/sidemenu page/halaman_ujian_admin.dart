// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:get/get.dart';

import 'package:vienna_is/view/widgets/pluto_table/tabel_ujian.dart';
import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../text.dart';

class HalamanUjianAdmin extends StatelessWidget {
  HalamanUjianAdmin({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          TextWidget(
            text: 'Halaman Ujian',
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
                  text: 'Tabel Ujian',
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
                  controller.ujianStateManager
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
              Visibility(
                visible: controller.userAdmin.value.idAdmin != null,
                child: BtnWidget(
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
                          controller.clearTextEditingControllerUjian();
                          return ModalPopUp(
                            onPressed: () async {
                              if (controller.formKeyGuru.currentState!
                                  .validate()) {
                                await controller.addUjian();
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
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: TabelUjian(),
          )
        ],
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
