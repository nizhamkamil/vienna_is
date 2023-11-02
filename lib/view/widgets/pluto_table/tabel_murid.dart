// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
import '../text.dart';
import '../text_form_field_widget.dart';

class TabelMurid extends StatelessWidget {
  TabelMurid({super.key});

  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
          textAlign: PlutoColumnTextAlign.center,
          title: 'Id Murid',
          field: 'idMurid',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
      PlutoColumn(
        title: 'Nama',
        field: 'nama',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Username',
        field: 'username',
        hide: true,
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Password',
        field: 'password',
        hide: true,
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Alamat',
        field: 'alamat',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Email',
        field: 'email',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'No Telepon',
        field: 'noTelepon',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Jenis Kelamin',
        field: 'jenisKelamin',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Tanggal Masuk',
        field: 'tanggalMasuk',
        type: PlutoColumnType.date(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Agama',
        field: 'agama',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Kewarganegaraan',
        field: 'kewarganegaraan',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Status Daftar',
        field: 'statusDaftar',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Nama Wali',
        field: 'namaWali',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Tanggal Lahir',
        field: 'tanggalLahir',
        type: PlutoColumnType.date(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Tempat Lahir',
        field: 'tempatLahir',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Tipe Pembelajaran',
        field: 'tipePembelajaran',
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
                      controller.clearTextEditingControllerMurid();
                      controller.openEditMurid(rendererContext);
                      return editModal(context, rendererContext);
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
                            await controller.deleteMurid(
                                rendererContext.row.cells['idMurid']!.value);
                            plutoController.refreshPlutoTable(
                              controller.muridStateManager!,
                              plutoController.getMuridRow(controller.muridList),
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
        future: controller.fetchMurid(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return PlutoGrid(
              mode: PlutoGridMode.readOnly,
              columns: column,
              rows: plutoController.getMuridRow(controller.muridList),
              onLoaded: (event) {
                controller.muridStateManager = event.stateManager;
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

  Widget editModal(
      BuildContext context, PlutoColumnRendererContext rendererContext) {
    return ModalPopUp(
      onPressed: () async {
        if (controller.formKeyGuru.currentState!.validate()) {
          await controller
              .updateMurid(rendererContext.row.cells['idMurid']!.value);
          plutoController.refreshPlutoTable(controller.muridStateManager!,
              plutoController.getMuridRow(controller.muridList));
        }
      },
      popupTitle: 'Edit',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          kewarganegaraanField(context),
                          statusDaftarField(context),
                          namaWaliField(context),
                          tanggalLahirField(context),
                          tempatLahirField(context),
                          tipePembelajaranField(context),
                        ],
                      ),
                    ),
                  ],
                ),
              )),
            ),
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
          value: controller.jenisKelaminMuridController.text,
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
          value: controller.agamaMuridController.text,
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
          value: controller.statusDaftarMuridController.text,
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
          value: controller.tipePembelajaranMuridController.text,
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
