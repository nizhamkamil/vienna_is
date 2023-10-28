import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/button.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../config/theme.dart';

AppBar appBarHomeWidget() {
  return AppBar(
    backgroundColor: kBrownGoldColor,
    title: Padding(
      padding: EdgeInsets.only(left: Get.width * 0.01),
      child: InkWell(
        onTap: () {
          Get.offAllNamed('/home');
        },
        child: const TextWidget(
          text: 'Vienna Music School',
          weight: FontWeight.bold,
          size: 24,
        ),
      ),
    ),
  );
}
