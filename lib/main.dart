import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vienna_is/view/pages/home_page.dart';
import 'package:vienna_is/view/pages/landing_page.dart';
import 'package:vienna_is/view/pages/login_page.dart';
import 'package:vienna_is/view/pages/register_page.dart';

import 'view/widgets/not_found_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      unknownRoute:
          GetPage(name: '/notfound', page: () => const NotFoundPage()),
      getPages: [
        GetPage(name: '/', page: () => const LandingPage()),
        GetPage(name: '/login', page: () => const LoginPage()),
        GetPage(name: '/register', page: () => const RegisterPage()),
        GetPage(name: '/home', page: () => const HomePage()),
      ],
    );
  }
}
