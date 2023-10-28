import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/button.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../config/theme.dart';

AppBar appBarWidget() {
  return AppBar(
    backgroundColor: kBrownGoldColor,
    title: Padding(
      padding: EdgeInsets.only(left: Get.width * 0.05),
      child: InkWell(
        onTap: () {
          Get.offAllNamed('/');
        },
        child: const TextWidget(
          text: 'Vienna Music School',
          weight: FontWeight.bold,
          size: 24,
        ),
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
              Get.offAllNamed('/register');
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
              Get.offAllNamed('/login');
            },
          )),
    ],
  );
}
