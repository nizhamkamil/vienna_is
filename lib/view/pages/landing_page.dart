// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/view/widgets/button.dart';
import 'package:vienna_is/view/widgets/text.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kBrownGoldColor,
          title: Padding(
            padding: EdgeInsets.only(left: Get.width * 0.05),
            child: const TextWidget(
              text: 'Vienna Music School',
              weight: FontWeight.bold,
              size: 24,
            ),
          ),
          actions: [
            Padding(
                padding: const EdgeInsets.all(8),
                child: BtnWidget(
                  radius: 4,
                  btnColor: Colors.white,
                  textWidget: const TextWidget(
                    text: 'Register',
                    color: kBrownColor,
                  ),
                  onPress: () {
                    Get.toNamed('/register');
                  },
                )),
            Padding(
                padding: EdgeInsets.only(
                    left: 8, top: 8, bottom: 8, right: Get.width * 0.05),
                child: BtnWidget(
                  radius: 4,
                  btnColor: kBrownColor,
                  textWidget: const TextWidget(
                    text: 'Login',
                    color: Colors.white,
                  ),
                  onPress: () {
                    Get.toNamed('/login');
                  },
                )),
          ],
        ),
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
                      placeHolderUrl,
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
                          onPress: () {},
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
            Row(
              children: [
                //CARD
                Expanded(
                  child: GFCard(
                    padding: EdgeInsets.all(0),
                    elevation: 5,
                    showImage: true,
                    boxFit: BoxFit.fill,
                    image: Image.network(placeHolderUrl),
                    title: GFListTile(
                      title: const TextWidget(
                        text: 'Kelas Piano',
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                      subTitle: TextWidget(
                        text: landingPageCardSubtitle,
                        maxLines: 20,
                        textAlign: TextAlign.justify,
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
                  ),
                ),
                Expanded(
                  child: GFCard(
                    padding: EdgeInsets.all(0),
                    elevation: 5,
                    showImage: true,
                    boxFit: BoxFit.fill,
                    image: Image.network(placeHolderUrl),
                    title: GFListTile(
                      title: const TextWidget(
                        text: 'Kelas Piano',
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                      subTitle: TextWidget(
                        text: landingPageCardSubtitle,
                        maxLines: 20,
                        textAlign: TextAlign.justify,
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
                  ),
                ),
                Expanded(
                  child: GFCard(
                    padding: EdgeInsets.all(0),
                    elevation: 5,
                    showImage: true,
                    boxFit: BoxFit.fill,
                    image: Image.network(placeHolderUrl),
                    title: GFListTile(
                      title: const TextWidget(
                        text: 'Kelas Piano',
                        size: 24,
                        weight: FontWeight.bold,
                      ),
                      subTitle: TextWidget(
                        text: landingPageCardSubtitle,
                        maxLines: 20,
                        textAlign: TextAlign.justify,
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
                  ),
                ),
              ],
            )
          ]),
        ));
  }
}
