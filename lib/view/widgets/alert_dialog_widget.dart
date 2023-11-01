// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/text.dart';

import 'button.dart';

class AlertDialogWidget extends StatelessWidget {
  const AlertDialogWidget({super.key, required this.onPress});

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Peringatan'),
      content: Text('Apakah anda yakin ingin menghapus data ini?'),
      actions: [
        BtnWidget(
          height: 40,
          width: 80,
          radius: 4,
          outlineColor: Colors.grey,
          btnColor: Colors.white,
          onPress: () {
            Get.back();
          },
          textWidget: TextWidget(
            color: Colors.black,
            text: 'Tidak',
          ),
        ),
        BtnWidget(
          height: 40,
          width: 80,
          radius: 4,
          btnColor: Colors.red,
          onPress: onPress,
          textWidget: TextWidget(
            text: 'Ya',
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
