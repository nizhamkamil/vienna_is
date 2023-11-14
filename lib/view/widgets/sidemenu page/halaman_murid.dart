// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/pluto_table/tabel_murid.dart';
import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class HalamanMurid extends StatelessWidget {
  HalamanMurid({super.key});
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          TextWidget(
            text: 'Halaman Murid',
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
                  text: 'Tabel Murid',
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
                  controller.muridStateManager
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
                visible: !controller.userGuru.isNotEmpty,
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
                          controller.clearTextEditingControllerMurid();
                          return ModalPopUp(
                            onPressed: () async {
                              if (controller.formKeyGuru.currentState!
                                  .validate()) {
                                await controller.addMurid();
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
                                                  namaField(context),
                                                  usernameField(context),
                                                  passwordField(context),
                                                  alamat(context),
                                                  emailField(context),
                                                  teleponField(context),
                                                  kelaminField(context),
                                                  tanggalMasukField(context),
                                                  agamaField(context),
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
                                                  kewarganegaraanField(context),
                                                  statusDaftarField(context),
                                                  namaWaliField(context),
                                                  tanggalLahirField(context),
                                                  tempatLahirField(context),
                                                  tipePembelajaranField(
                                                      context),
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
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
          Expanded(
            child: TabelMurid(),
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
          textCtrl: controller.namaMuridController,
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
          textCtrl: controller.usernameMuridController,
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
          textCtrl: controller.passwordMuridController,
          hintText: '',
          labelText: 'Password',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox alamat(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.alamatMuridController,
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
          textCtrl: controller.emailMuridController,
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
          textCtrl: controller.noTeleponMuridController,
          hintText: '',
          labelText: 'Telepon',
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
            controller.jenisKelaminMuridController.text = value.toString();
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

  SizedBox tanggalMasukField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          type: 'date',
          readOnly: true,
          validator: true,
          textCtrl: controller.tanggalMasukMuridController,
          hintText: '',
          labelText: 'Tanggal Masuk',
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
            controller.agamaMuridController.text = value.toString();
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
          textCtrl: controller.kewarganegaraanMuridController,
          hintText: '',
          labelText: 'Kewarganegaraan',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox statusDaftarField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Status Daftar tidak boleh kosong';
            } else {
              return null;
            }
          },
          items: controller.dropdownStatusDaftar,
          onChanged: (value) {
            controller.statusDaftarMuridController.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Status Daftar',
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

  SizedBox namaWaliField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.namaWaliMuridController,
          hintText: '',
          labelText: 'Nama Wali',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox tanggalLahirField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          type: 'date',
          readOnly: true,
          validator: true,
          textCtrl: controller.tanggalLahirMuridController,
          hintText: '',
          labelText: 'Tanggal Lahir',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox tempatLahirField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.tempatLahirMuridController,
          hintText: '',
          labelText: 'Tempat Lahir',
          obscureText: false,
        ),
      ),
    );
  }

  SizedBox tipePembelajaranField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: DropdownButtonFormField(
          validator: (value) {
            if (value == null) {
              return 'Tipe pembelajaran tidak boleh kosong';
            } else {
              return null;
            }
          },
          items: controller.dropdownTipePembelajaran,
          onChanged: (value) {
            controller.tipePembelajaranMuridController.text = value.toString();
          },
          decoration: InputDecoration(
            label: TextWidget(
              text: 'Tipe Pembelajaran',
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
