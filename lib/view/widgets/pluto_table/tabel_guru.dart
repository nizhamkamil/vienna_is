// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/controller/controller.dart';
import 'package:vienna_is/controller/pluto_controller.dart';
import 'package:vienna_is/view/widgets/alert_dialog_widget.dart';
import 'package:vienna_is/view/widgets/button.dart';
import 'package:vienna_is/view/widgets/floating_modal.dart';
import 'package:vienna_is/view/widgets/modal_pop_up.dart';
import 'package:vienna_is/view/widgets/text.dart';
import 'package:vienna_is/view/widgets/text_form_field_widget.dart';

class TabelGuru extends StatelessWidget {
  TabelGuru({super.key});

  Controller controller = Get.find();
  PlutoController plutoController = Get.find();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
          textAlign: PlutoColumnTextAlign.center,
          title: 'Id Guru',
          field: 'id_guru',
          type: PlutoColumnType.number(),
          backgroundColor: kAccentBrownGoldColor,
          width: 75),
      PlutoColumn(
          title: 'Nama',
          field: 'nama',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Alamat',
          field: 'alamat',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Email',
          field: 'email',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Username',
          field: 'username',
          type: PlutoColumnType.text(),
          hide: true,
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Password',
          field: 'password',
          type: PlutoColumnType.text(),
          hide: true,
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'No Telepon',
          field: 'no_telepon',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Agama',
          field: 'agama',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Kewarganegaraan',
          field: 'kewarganegaraan',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Jenis Kelamin',
          field: 'jenis_kelamin',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
      PlutoColumn(
          title: 'Status Nikah',
          field: 'status_nikah',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor),
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
                      controller.clearTextEditingController();
                      controller.openEditGuru(rendererContext);
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
                            await controller.deleteGuru(
                                rendererContext.row.cells['id_guru']!.value);
                            plutoController.refreshPlutoTable(
                                controller.guruStateManager!,
                                plutoController
                                    .getGuruRow(controller.guruList));
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
      future: controller.fetchGuru(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PlutoGrid(
            columns: column,
            rows: plutoController.getGuruRow(controller.guruList),
            onLoaded: (event) {
              controller.guruStateManager = event.stateManager;
            },
            mode: PlutoGridMode.readOnly,
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
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget editModal(
      BuildContext context, PlutoColumnRendererContext rendererContext) {
    return ModalPopUp(
      onPressed: () async {
        if (controller.formKeyGuru.currentState!.validate()) {
          await controller
              .updateGuru(rendererContext.row.cells['id_guru']!.value);
          plutoController.refreshPlutoTable(controller.guruStateManager!,
              plutoController.getGuruRow(controller.guruList));
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                ),
              ),
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
          value: controller.jenisKelaminController.value.text,
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
          value: controller.agamaController.value.text,
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
          value: controller.statusNikahController.value.text,
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
