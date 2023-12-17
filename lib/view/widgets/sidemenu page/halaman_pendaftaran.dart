// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class HalamanPendaftaran extends StatefulWidget {
  HalamanPendaftaran({super.key});

  @override
  State<HalamanPendaftaran> createState() => _HalamanPendaftaranState();
}

class _HalamanPendaftaranState extends State<HalamanPendaftaran> {
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (controller.userMurid.isNotEmpty) {
      if (controller.userMurid[0].nama != null) {
        return Center(
          child: TextWidget(
              size: 18,
              text:
                  'Anda sudah melakukan pendaftaran, silahkan hubungi admin untuk mengubah data anda'),
        );
      }
    }
    return Padding(
      padding: const EdgeInsets.all(50),
      child: Column(
        children: [
          const TextWidget(
            text: 'Halaman Pendaftaran',
            size: 24,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 2),
                    blurRadius: 4,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05),
                      child: SingleChildScrollView(
                        child: Form(
                          key: controller.formKeyGuru,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    namaField(context),
                                    alamat(context),
                                    emailField(context),
                                    teleponField(context),
                                    kelaminField(context),
                                    agamaField(context),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    kewarganegaraanField(context),
                                    namaWaliField(context),
                                    tanggalLahirField(context),
                                    tempatLahirField(context),
                                    tipePembelajaranField(context),
                                    kelasField(context)
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                      vertical: 20,
                    ),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: BtnWidget(
                        radius: 4,
                        height: 40,
                        width: 100,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                          )
                        ],
                        btnColor: Colors.white,
                        outlineColor: kBrownGoldColorSecondary,
                        onPress: () async {
                          await controller.daftarMurid(
                            controller.userMurid[0].idMurid!,
                          );
                          setState(() {});
                        },
                        textWidget: TextWidget(
                          text: 'Daftar',
                          color: kBrownGoldColorSecondary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
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
}
