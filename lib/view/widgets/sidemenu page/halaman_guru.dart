// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/view/widgets/button.dart';
import 'package:vienna_is/view/widgets/floating_modal.dart';
import 'package:vienna_is/view/widgets/modal_pop_up.dart';
import 'package:vienna_is/view/widgets/pluto_table/tabel_guru.dart';
import 'package:vienna_is/view/widgets/text.dart';
import 'package:vienna_is/view/widgets/text_form_field_widget.dart';

import '../../../controller/controller.dart';

class HalamanGuru extends StatelessWidget {
  HalamanGuru({super.key});
  Controller controller = Get.find();
  Rx<TextEditingController> textController = TextEditingController().obs;

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          TextWidget(
            text: 'Halaman Guru',
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
                  text: 'Tabel Guru',
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
                  controller.guruStateManager
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
                        controller.clearTextEditingController();
                        return ModalPopUp(
                          onPressed: () async {
                            if (controller.formKeyGuru.currentState!
                                .validate()) {
                              await controller.addGuru();
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
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          namaField(context),
                                          usernameField(context),
                                          passwordField(context),
                                          alamatField(context),
                                          emailField(context),
                                          teleponField(context),
                                          kewarganegaraanField(context),
                                          agamaField(context),
                                          kelaminField(context),
                                          statusNikahField(context),
                                          SizedBox(
                                            height: 20,
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
            child: TabelGuru(),
          )
        ],
      ),
    );
  }

  SizedBox namaField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.namaController,
          hintText: '',
          labelText: 'Nama',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox usernameField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.usernameController,
          hintText: '',
          labelText: 'Username',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox passwordField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          type: 'password',
          textCtrl: controller.passwordController,
          hintText: '',
          maxLines: 1,
          labelText: 'Password',
          obscureText: true,
        ),
      ),
    );
  }

  // SizedBox namaField(BuildContext context) {
  //   return SizedBox(
  //     child: Padding(
  //       padding: EdgeInsets.symmetric(
  //         vertical: 20,
  //       ),
  //       child: Obx(() => TypeAheadFormField(
  //             textFieldConfiguration: TextFieldConfiguration(
  //               controller: textController.value,
  //               decoration: InputDecoration(
  //                 labelStyle: TextStyle(
  //                   color: Colors.grey,
  //                   fontSize: 20,
  //                 ),
  //                 floatingLabelBehavior: FloatingLabelBehavior.always,
  //                 labelText: 'Nama',
  //                 border: const OutlineInputBorder(
  //                   borderRadius: BorderRadius.all(
  //                     Radius.circular(4),
  //                   ),
  //                 ),
  //                 suffixIcon: Visibility(
  //                   visible: textController.value.text.isEmpty ? false : true,
  //                   child: IconButton(
  //                     onPressed: () {
  //                       textController.value.clear();
  //                       textController.refresh();
  //                     },
  //                     icon: Icon(Icons.clear),
  //                   ),
  //                 ),
  //               ),
  //             ),
  //             suggestionsBoxDecoration: const SuggestionsBoxDecoration(
  //               constraints: BoxConstraints(maxHeight: 175, minHeight: 50),
  //             ),
  //             onSuggestionSelected: (value) {
  //               textController.value.text = value.nama!;
  //               textController.refresh();
  //             },
  //             itemBuilder: (context, itemData) {
  //               return ListTile(
  //                 title: TextWidget(
  //                   text: itemData.nama!,
  //                 ),
  //               );
  //             },
  //             suggestionsCallback: (pattern) {
  //               return controller.guruList
  //                   .where((e) => e.nama!.contains(pattern));
  //             },
  //           )),
  //     ),
  //   );
  // }

  SizedBox alamatField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.alamatController,
          hintText: '',
          labelText: 'Alamat',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox emailField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.emailController,
          hintText: '',
          labelText: 'Email',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox teleponField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textInputFormatter: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          textInputType: TextInputType.number,
          textCtrl: controller.noTeleponController,
          hintText: '',
          labelText: 'Telepon',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox agamaField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Agama tidak boleh kosong';
            } else {
              return null;
            }
          },
          items: controller.dropdownAgama,
          onChanged: (value) {
            controller.agamaController.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Agama',
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

  SizedBox kewarganegaraanField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.kewarganegaraanController,
          hintText: '',
          labelText: 'Kewarganegaraan',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox kelaminField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Jenis Kelamin tidak boleh kosong';
            } else {
              return null;
            }
          },
          items: controller.dropdownJenisKelamin,
          onChanged: (value) {
            controller.jenisKelaminController.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Jenis Kelamin',
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

  SizedBox statusNikahField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Status Nikah tidak boleh kosong';
            } else {
              return null;
            }
          },
          items: controller.dropdownStatusNikah,
          onChanged: (value) {
            controller.statusNikahController.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Status Nikah',
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
