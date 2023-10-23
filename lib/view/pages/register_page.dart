// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

import '../../config/theme.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackground,
      appBar: AppBar(
        backgroundColor: kBrownGoldColor,
        title: Padding(
          padding: EdgeInsets.only(left: Get.width * 0.05),
          child: InkWell(
            onTap: () {
              Get.toNamed('/');
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
      body: Center(
          child: Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 3,
                blurRadius: 10,
              )
            ],
            color: Colors.white),
        child: Row(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  color: kBrownColor,
                )),
            Expanded(
                flex: 5,
                child: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: TextWidget(
                              text: 'Register',
                              size: 32,
                              weight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Username',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Password',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Confirm Password',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.05,
                                vertical:
                                    MediaQuery.of(context).size.height * 0.01),
                            child: TextFormField(
                              decoration: InputDecoration(
                                  hintText: 'Email',
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ),
                        ]),
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
