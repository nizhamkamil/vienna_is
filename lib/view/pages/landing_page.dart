// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/models/kelas.dart';
import 'package:vienna_is/models/kelas_complete.dart';
import 'package:vienna_is/view/widgets/appbar_widget.dart';
import 'package:vienna_is/view/widgets/button.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../controller/controller.dart';

class LandingPage extends StatelessWidget {
  LandingPage({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    int crossAxisCount;
    double screenWidth = MediaQuery.of(context).size.width;
    double childAspect = MediaQuery.of(context).size.width;

    if (screenWidth >= 1600) {
      crossAxisCount = 3;
    } else if (screenWidth >= 1400) {
      crossAxisCount = 2;
    } else if (screenWidth >= 800) {
      crossAxisCount = 1;
    } else {
      crossAxisCount = 1;
    }

    if (childAspect >= 1600) {
      childAspect = 8 / 10;
    } else if (childAspect >= 1400) {
      childAspect = 9 / 10;
    } else if (childAspect >= 800) {
      childAspect = 9 / 10;
    } else {
      childAspect = 6 / 10;
    }

    return Scaffold(
        backgroundColor: kWhiteBackground,
        appBar: appBarWidget(),
        body: SingleChildScrollView(
          child: Column(children: [
            //IMAGE BANNER
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Center(
                  child: SizedBox(
                    height: Get.height * 0.7,
                    width: Get.width * 1,
                    child: Image.network(
                      bannerLandingPageUrl,
                      color: const Color.fromARGB(150, 0, 0, 0),
                      fit: BoxFit.cover,
                      colorBlendMode: BlendMode.darken,
                    ),
                  ),
                ),
                Column(
                  children: [
                    const TextWidget(
                      text: 'MUSIC SCHOOL FOR EVERYONE',
                      size: 36,
                      weight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      width: Get.width * 0.5,
                      child: const TextWidget(
                        maxLines: 10,
                        textAlign: TextAlign.center,
                        text: landingPageSubtitle,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: Get.width * 0.1,
                      height: Get.height * 0.05,
                      child: BtnWidget(
                          radius: 4,
                          btnColor: kBrownColor,
                          onPress: () {
                            Get.toNamed('/register');
                          },
                          textWidget: const TextWidget(
                            text: 'Join Now',
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            const TextWidget(
              text: 'KELAS TERSEDIA',
              size: 36,
              weight: FontWeight.bold,
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
                width: Get.width * 0.8,
                child: FutureBuilder(
                  future: controller.fetchKelas(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData &&
                        snapshot.connectionState == ConnectionState.done) {
                      return GridView.builder(
                          shrinkWrap: true,
                          itemCount: controller.kelasKomplitList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: childAspect,
                                  crossAxisCount: crossAxisCount),
                          itemBuilder: (context, index) {
                            return GFCard(
                              padding: EdgeInsets.all(0),
                              elevation: 5,
                              showImage: true,
                              boxFit: BoxFit.fill,
                              image: Image.network(
                                '$configUrl/assets/${controller.kelasKomplitList[index].kelasFoto[0].pathFoto}',
                                loadingBuilder:
                                    (context, child, loadingProgress) {
                                  return loadingProgress == null
                                      ? child
                                      : const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                },
                              ),
                              title: GFListTile(
                                title: TextWidget(
                                  text: controller
                                      .kelasKomplitList[index].namaKelas,
                                  size: 24,
                                  weight: FontWeight.bold,
                                ),
                                subTitle: SingleChildScrollView(
                                  child: TextWidget(
                                    text: controller
                                        .kelasKomplitList[index].deskripsiKelas,
                                    maxLines: 20,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              ),
                              buttonBar: GFButtonBar(
                                alignment: WrapAlignment.start,
                                runAlignment: WrapAlignment.start,
                                crossAxisAlignment: WrapCrossAlignment.start,
                                children: <Widget>[
                                  GFListTile(
                                      subTitle: BtnWidget(
                                    height: 40,
                                    radius: 4,
                                    btnColor: kBrownColor,
                                    onPress: () {},
                                    textWidget: TextWidget(text: 'Lihat Kelas'),
                                  )),
                                ],
                              ),
                            );
                          });
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                )),
          ]),
        ));
  }
}
