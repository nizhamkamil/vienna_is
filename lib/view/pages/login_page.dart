// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:vienna_is/controller/controller.dart';
import 'package:vienna_is/models/admin.dart';
import 'package:vienna_is/models/guru.dart';
import 'package:vienna_is/models/murid.dart';
import '../../config/theme.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/button.dart';
import '../widgets/text.dart';
import '../widgets/text_form_field_widget.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  RxInt? loginValue = 0.obs;
  Controller controller = Get.find<Controller>();
  TextEditingController usernameController =
      TextEditingController(text: 'userMurid');
  TextEditingController passwordController =
      TextEditingController(text: 'passwordMurid');

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
                      text: 'Login',
                      size: 32,
                      weight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.05,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: TextWidget(
                        text: 'Tipe Login ',
                        size: 16,
                        weight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.05,
                          vertical: MediaQuery.of(context).size.height * 0.015),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: chipWidget())),
                  usernameField(context),
                  passwordField(context),
                  loginButton(context),
                ]),
          ),
        ));
  }

  Padding loginButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.015),
      child: Align(
        alignment: Alignment.centerLeft,
        child: BtnWidget(
          height: 50,
          radius: 4,
          btnColor: kBrownColor,
          onPress: () async {
            //LOGIN GURU
            if (loginValue?.value == 0) {
              await controller.loginGuru(
                  usernameController.value.text, passwordController.value.text);
              if (controller.userGuru.isNotEmpty) {
                print(guruToJson(controller.userGuru));
                controller.checkUserRole();
                Get.offAllNamed('/home');
              } else {
                snackbar();
              }
            }
            //LOGIN MURID
            else if (loginValue?.value == 1) {
              await controller.loginMurid(
                  usernameController.value.text, passwordController.value.text);
              if (controller.userMurid.isNotEmpty) {
                print(muridToJson(controller.userMurid));
                controller.checkUserRole();
                Get.offAllNamed('/home');
              } else {
                snackbar();
              }
            }
            //LOGIN ADMIN
            else if (loginValue?.value == 2) {
              print('login as admin');
              await controller.loginAdmin(
                  usernameController.value.text, passwordController.value.text);

              if (controller.userAdmin.value.idAdmin != null) {
                controller.checkUserRole();
                Get.offAllNamed('/home');
              } else {
                snackbar();
              }
              // Get.toNamed('/home');
            }
          },
          textWidget: TextWidget(
            text: 'Login',
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  Padding passwordField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.015),
      child: TextFormFieldWidget(
        obscureText: true,
        prefixIcon: Icon(Icons.lock),
        textCtrl: passwordController,
        type: 'password',
        labelText: 'Password',
        showLabel: true,
        maxLines: 1,
        hintText: 'Password',
      ),
    );
  }

  Padding usernameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.05,
          vertical: MediaQuery.of(context).size.height * 0.015),
      child: TextFormFieldWidget(
        obscureText: false,
        prefixIcon: Icon(Icons.person),
        textCtrl: usernameController,
        labelText: 'Username',
        showLabel: true,
        maxLines: 1,
        hintText: 'Username',
      ),
    );
  }

  SnackbarController snackbar() {
    return Get.snackbar(
      'Login gagal',
      'Username atau password salah',
      backgroundColor: Colors.red,
      snackPosition: SnackPosition.BOTTOM,
      margin: EdgeInsets.all(16),
      duration: Duration(seconds: 2),
      colorText: Colors.white,
    );
  }

  Obx chipWidget() {
    return Obx(() => Wrap(
          children: List<Widget>.generate(
              controller.loginType.length,
              (index) => Padding(
                    padding:
                        const EdgeInsets.only(top: 8, bottom: 8, right: 16),
                    child: FilterChip(
                      checkmarkColor: Colors.white,
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                            color: loginValue?.value == index
                                ? kBrownColor
                                : Colors.grey),
                      ),
                      backgroundColor: Colors.white,
                      selectedColor: kBrownColor,
                      label: TextWidget(
                        text: controller.loginType[index],
                        size: 16,
                        color: loginValue?.value == index
                            ? Colors.white
                            : kBrownColor,
                      ),
                      selected: loginValue?.value == index,
                      onSelected: (bool selected) {
                        loginValue?.value = (selected ? index : null)!;
                      },
                    ),
                  )).toList(),
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
