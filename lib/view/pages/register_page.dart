// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:vienna_is/view/widgets/appbar_widget.dart';

import '../../config/theme.dart';
import '../../controller/controller.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';
import '../widgets/text_form_field_widget.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackground,
      appBar: appBarWidget(),
      body: Center(
          child: Container(
        clipBehavior: Clip.antiAlias,
        width: MediaQuery.of(context).size.width * 0.7,
        height: MediaQuery.of(context).size.height * 0.5,
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
            imageWidget(),
            formWidget(context),
          ],
        ),
      )),
    );
  }

  Expanded formWidget(BuildContext context) {
    return Expanded(
        flex: 5,
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: TextWidget(
                      text: 'Register',
                      size: 32,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.015),
                    child: TextFormFieldWidget(
                      obscureText: false,
                      labelText: 'Username',
                      textCtrl: controller.usernameRegisterController,
                      showLabel: true,
                      maxLines: 1,
                      hintText: 'Username',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.015),
                    child: TextFormFieldWidget(
                      obscureText: true,
                      labelText: 'Password',
                      type: 'password',
                      textCtrl: controller.passwordRegisterController,
                      showLabel: true,
                      maxLines: 1,
                      hintText: 'Password',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.015),
                    child: TextFormFieldWidget(
                      obscureText: true,
                      type: 'password',
                      labelText: 'Confirm password',
                      showLabel: true,
                      textCtrl: controller.confirmPasswordRegisterController,
                      maxLines: 1,
                      hintText: 'Confirm password',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.015),
                    child: TextFormFieldWidget(
                      obscureText: false,
                      labelText: 'Email',
                      showLabel: true,
                      maxLines: 1,
                      hintText: 'Email',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.05,
                        vertical: MediaQuery.of(context).size.height * 0.015),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: BtnWidget(
                        height: 40,
                        radius: 4,
                        btnColor: kBrownColor,
                        onPress: () async {
                          await controller.createMurid();
                        },
                        textWidget: TextWidget(
                          text: 'Register',
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                ]),
          ),
        ));
  }

  Expanded imageWidget() {
    return Expanded(
      flex: 5,
      child: SvgPicture.asset(
        'assets/images/musiclesson.svg',
        fit: BoxFit.cover,
      ),
    );
  }
}
