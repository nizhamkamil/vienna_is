import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class NotFoundPage extends StatelessWidget {
  const NotFoundPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Lottie.asset(
          'assets/images/notfound.json',
          width: Get.width * 0.7,
          height: Get.height * 0.6,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
