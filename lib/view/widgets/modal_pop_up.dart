// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../config/theme.dart';
import 'button.dart';

class ModalPopUp extends StatelessWidget {
  ModalPopUp(
      {super.key,
      required this.popupTitle,
      required this.child,
      this.onPressed});

  String popupTitle = '';
  Widget child = const Placeholder();
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          TextWidget(
            text: popupTitle,
            size: 24,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
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
            height: 20,
          ),
          Expanded(child: child),
          SizedBox(
            height: 20,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.05),
              child: BtnWidget(
                width: 125,
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
                onPress: onPressed ?? () {},
                textWidget: TextWidget(
                  text: 'Save',
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
