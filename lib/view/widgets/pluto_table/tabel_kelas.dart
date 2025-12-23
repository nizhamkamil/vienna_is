// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pluto_grid/pluto_grid.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/controller/controller.dart';
import 'package:vienna_is/controller/pluto_controller.dart';
import 'package:vienna_is/view/widgets/button.dart';

import '../alert_dialog_widget.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class TabelKelas extends StatelessWidget {
  TabelKelas({super.key});

  Controller controller = Get.find();
  PlutoController plutoController = Get.find();
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    List<PlutoColumn> column = [
      PlutoColumn(
        textAlign: PlutoColumnTextAlign.center,
        title: 'Id Kelas',
        field: 'idKelas',
        type: PlutoColumnType.number(),
        backgroundColor: kAccentBrownGoldColor,
        width: 50,
      ),
      PlutoColumn(
          title: 'Nama Kelas',
          field: 'namaKelas',
          type: PlutoColumnType.text(),
          backgroundColor: kAccentBrownGoldColor,
          width: 100),
      PlutoColumn(
        title: 'Deskripsi Kelas',
        field: 'deskripsiKelas',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
      ),
      PlutoColumn(
        title: 'Foto Kelas',
        field: 'fotoKelas',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
        renderer: (rendererContext) {
          return Center(
            child: Image.network(
              '$configUrl/assets/${rendererContext.row.cells['fotoKelas']!.value}',
              loadingBuilder: (context, child, loadingProgress) {
                return loadingProgress == null
                    ? child
                    : const Center(
                        child: CircularProgressIndicator(),
                      );
              },
            ),
          );
        },
      ),
      PlutoColumn(
        title: 'Action',
        field: 'action',
        type: PlutoColumnType.text(),
        backgroundColor: kAccentBrownGoldColor,
        width: 75,
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
                  controller.clearTextEditingControllerKelas();
                  controller.openEditKelas(rendererContext);
                  showFloatingModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ModalPopUp(
                        onPressed: () async {
                          if (controller.formKeyGuru.currentState!.validate()) {
                            await controller.updateKelas(
                                rendererContext.row.cells['idKelas']!.value);
                            plutoController.refreshPlutoTable(
                                controller.kelasStateManager!,
                                plutoController
                                    .getKelasRow(controller.kelasKomplitList));
                          }
                        },
                        popupTitle: 'Edit',
                        child: Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05,
                                ),
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
                                            namaKelasField(context),
                                            deskripsiKelasField(context),
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
                                            imageList(
                                                context, carouselController),
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
                            await controller.deleteKelas(
                                rendererContext.row.cells['idKelas']!.value);
                            plutoController.refreshPlutoTable(
                                controller.kelasStateManager!,
                                plutoController
                                    .getKelasRow(controller.kelasKomplitList));
                            controller.kelasKomplitList.refresh();
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
      future: controller.fetchKelas(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return PlutoGrid(
            mode: PlutoGridMode.readOnly,
            columns: column,
            rows: plutoController.getKelasRow(controller.kelasKomplitList),
            onLoaded: (event) {
              controller.kelasStateManager = event.stateManager;
            },
            configuration: PlutoGridConfiguration(
              columnSize: PlutoGridColumnSizeConfig(
                  autoSizeMode: PlutoAutoSizeMode.scale),
              style: PlutoGridStyleConfig(
                defaultCellPadding: EdgeInsets.symmetric(vertical: 4),
                rowHeight: 125,
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

  SizedBox namaKelasField(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        child: TextFormFieldWidget(
          validator: true,
          textCtrl: controller.namaKelasController,
          hintText: '',
          labelText: 'Nama Kelas',
          obscureText: false,
        ),
      ),
    );
  }

  Widget imageList(
      BuildContext context, CarouselSliderController carouselController) {
    return Obx(() => Column(
          children: [
            controller.imageXFile.isEmpty
                ? Container(
                    height: 200,
                    width: 200,
                    color: Colors.grey.withOpacity(0.2),
                    child: const Center(
                      child: TextWidget(
                        text: 'No Image',
                        color: Colors.grey,
                      ),
                    ),
                  )
                : Obx(() => Column(
                      children: [
                        CarouselSlider(
                          items: controller.imageXFile
                              .map(
                                (e) => Container(
                                  height: 200,
                                  margin: EdgeInsets.all(5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      e!.path,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) =>
                                              loadingProgress == null
                                                  ? child
                                                  : const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            enableInfiniteScroll: false,
                            enlargeCenterPage: true,
                            height: 200,
                            onPageChanged: (index, reason) {
                              controller.imageIndex = index.obs;
                              controller.imageXFile.refresh();
                              controller.imageIndex.refresh();
                            },
                          ),
                          carouselController: carouselController,
                        ),
                        Obx(() {
                          return Visibility(
                            visible: controller.imageXFile.length > 1,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: controller.imageXFile
                                  .asMap()
                                  .entries
                                  .map((entry) {
                                return GestureDetector(
                                    onTap: () {
                                      carouselController
                                          .animateToPage(entry.key);
                                      controller.imageIndex.refresh();
                                    },
                                    child: Container(
                                      width: 12.0,
                                      height: 12.0,
                                      margin: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 4.0),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.black.withOpacity(
                                            controller.imageIndex.value ==
                                                    entry.key
                                                ? 0.9
                                                : 0.3),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          );
                        }),
                      ],
                    )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                  onPress: () async {
                    await controller.addImages();
                  },
                  textWidget: const TextWidget(
                    text: 'Add Image',
                  ),
                ),
                Visibility(
                  visible: controller.imageXFile.isNotEmpty,
                  child: BtnWidget(
                    radius: 4,
                    height: 40,
                    btnColor: Colors.red,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 2,
                        blurRadius: 2,
                      )
                    ],
                    icon: const Icon(Icons.delete),
                    onPress: () {
                      controller.deleteImages(controller.imageIndex.value);
                      controller.imageXFile.refresh();
                      controller.imageIndex.refresh();
                    },
                    textWidget: const TextWidget(
                      text: 'Delete Current Image',
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }

  SizedBox deskripsiKelasField(BuildContext context) {
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
          textCtrl: controller.deskripsiKelasController,
          hintText: '',
          labelText: 'Deskripsi Kelas',
          obscureText: false,
        ),
      ),
    );
  }
}
