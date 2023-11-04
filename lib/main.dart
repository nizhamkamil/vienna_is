// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vienna_is/controller/home_binding.dart';
import 'package:vienna_is/view/pages/home_page.dart';
import 'package:vienna_is/view/pages/landing_page.dart';
import 'package:vienna_is/view/pages/login_page.dart';
import 'package:vienna_is/view/pages/register_page.dart';

import 'view/widgets/not_found_page.dart';

void main() {
  HomeBinding().dependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      unknownRoute: GetPage(name: '/notfound', page: () => NotFoundPage()),
      getPages: [
        GetPage(name: '/', page: () => LandingPage()),
        GetPage(name: '/login', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),
      ],
    );
  }
}
