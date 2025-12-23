// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/pluto_table/tabel_kelas.dart';

import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';
import '../floating_modal.dart';
import '../modal_pop_up.dart';
import '../text.dart';
import '../text_form_field_widget.dart';

class HalamanKelas extends StatelessWidget {
  HalamanKelas({super.key});

  Controller controller = Get.find();
  CarouselSliderController carouselSliderController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;

    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(children: [
        const TextWidget(
          text: 'Halaman Kelas',
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
                text: 'Tabel Kelas',
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
                controller.kelasStateManager
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
                    controller.clearTextEditingControllerKelas();
                    return ModalPopUp(
                      onPressed: () async {
                        if (controller.formKeyGuru.currentState!.validate()) {
                          await controller.addKelas();
                        }
                      },
                      popupTitle: 'Add New',
                      child: Column(
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.05),
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
                                            imageList(context,
                                                carouselSliderController),
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
          child: TabelKelas(),
        )
      ]),
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
      BuildContext context, CarouselSliderController CarouselSliderController) {
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
                          carouselController: CarouselSliderController,
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
                                      CarouselSliderController.animateToPage(
                                          entry.key);
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
