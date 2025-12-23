// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:vienna_is/models/kelas_complete.dart';

import '../../config/theme.dart';
import '../../controller/controller.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';

class DetailPage extends StatelessWidget {
  DetailPage({super.key, required this.id, required this.kelasKomplit});

  final int id;
  final KelasKomplit? kelasKomplit;
  Controller controller = Get.find();
  CarouselSliderController carouselController = CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.height * 0.7,
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            TextWidget(
              text: kelasKomplit!.namaKelas,
              size: 24,
              weight: FontWeight.bold,
            ),
            SizedBox(
              height: 20, //ya
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: Align(
                alignment: Alignment.centerLeft,
                child: BtnWidget(
                  outlineColor: kBrownGoldColorSecondary,
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: kBrownGoldColorSecondary,
                  ),
                  btnColor: Colors.white,
                  radius: 4,
                  height: 40,
                  width: 125,
                  onPress: () {
                    Get.back();
                  },
                  textWidget: TextWidget(
                    text: 'Kembali',
                    color: kBrownGoldColorSecondary,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 300,
              width: MediaQuery.of(context).size.width * 0.8,
              child: CarouselSlider(
                items: controller.imageXFile
                    .map(
                      (e) => Container(
                        margin: EdgeInsets.all(5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            e!.path,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) =>
                                loadingProgress == null
                                    ? child
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  autoPlay: true,
                  viewportFraction: 0.5,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    controller.imageIndex = index.obs;
                    controller.imageXFile.refresh();
                    controller.imageIndex.refresh();
                  },
                ),
                carouselController: carouselController,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Obx(() => Visibility(
                  visible: controller.imageXFile.length > 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        controller.imageXFile.asMap().entries.map((entry) {
                      return GestureDetector(
                          onTap: () {
                            carouselController.animateToPage(entry.key);
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
                                  controller.imageIndex.value == entry.key
                                      ? 0.9
                                      : 0.3),
                            ),
                          ));
                    }).toList(),
                  ),
                )),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.02),
              child: TextWidget(
                text: kelasKomplit!.deskripsiKelas,
                maxLines: 30,
                size: 16,
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
