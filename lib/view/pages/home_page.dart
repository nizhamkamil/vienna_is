// ignore_for_file: prefer_const_constructors

import 'dart:html';

import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/view/widgets/appbar_home_widget.dart';
import 'package:vienna_is/view/widgets/sidebar_widget.dart';

import '../widgets/text.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final _controller = SidebarXController(selectedIndex: 0, extended: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kWhiteBackground,
        appBar: appBarHomeWidget(),
        body: Row(
          children: [
            SidebarWidget(controller: _controller),
            Expanded(
                child: ScreenNavigation(
              sidebarXController: _controller,
            ))
          ],
        ));
  }
}
