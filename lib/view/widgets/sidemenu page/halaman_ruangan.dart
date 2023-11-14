// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/pluto_table/tabel_ruangan.dart';
import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class HalamanRuangan extends StatelessWidget {
  HalamanRuangan({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          const TextWidget(
            text: 'Halaman Ruangan',
            size: 24,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: TextWidget(
                  text: 'Tabel Ruangan',
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ),
              const Spacer(
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
                icon: const Icon(
                  Icons.filter_alt,
                  color: kBrownGoldColorSecondary,
                ),
                onPress: () {
                  showFilter.value = !showFilter.value;
                  controller.ruanganStateManager
                      ?.setShowColumnFilter(showFilter.value);
                },
                textWidget: const TextWidget(
                  text: 'Show Filter',
                  color: kBrownGoldColorSecondary,
                ),
              ),
              const SizedBox(
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
                icon: const Icon(Icons.add),
                onPress: () {
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      controller.clearTextEditingControllerRuangan();
                      return ModalPopUp(
                        onPressed: () async {
                          if (controller.formKeyGuru.currentState!.validate()) {
                            await controller.addRuangan();
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
                                        namaRuanganField(context),
                                        deskripsiRuanganField(context),
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
                textWidget: const TextWidget(
                  text: 'Add New',
                ),
              )
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: TabelRuangan(),
          )
        ],
      ),
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
