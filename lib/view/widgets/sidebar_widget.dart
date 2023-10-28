// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_literals_to_create_immutables, must_be_immutable, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:vienna_is/config/theme.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_guru.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_jadwal.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_kelas.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_murid.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_pendaftaran.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_ruangan.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_ujian.dart';
import 'package:vienna_is/view/widgets/sidemenu%20page/halaman_utama.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../controller/controller.dart';

class SidebarWidget extends StatelessWidget {
  SidebarWidget({
    Key? key,
    required SidebarXController controller,
  })  : _controller = controller,
        super(key: key);
  final SidebarXController _controller;
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return SidebarX(
        controller: _controller,
        theme: SidebarXTheme(
          hoverTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          padding: const EdgeInsets.only(top: 20),
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: kBrownGoldColor,
            borderRadius: BorderRadius.circular(4),
          ),
          itemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
          ),
          hoverColor: Colors.white.withOpacity(0.5),
          selectedItemPadding: const EdgeInsets.all(15),
          itemTextPadding: const EdgeInsets.only(left: 20),
          selectedItemTextPadding: const EdgeInsets.only(left: 30),
          selectedTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          selectedIconTheme: const IconThemeData(
            color: Colors.white,
            size: 20,
          ),
          selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: const Color.fromARGB(123, 255, 255, 255),
              width: 1,
            ),
            gradient: const LinearGradient(
              colors: [Color.fromARGB(131, 255, 255, 255), kBrownGoldColor],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.28),
                blurRadius: 30,
              )
            ],
          ),
        ),
        footerBuilder: (context, extended) {
          return Material(
            type: MaterialType.transparency,
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              padding: const EdgeInsets.all(4),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
                hoverColor: Colors.white.withOpacity(0.5),
                contentPadding: !_controller.extended
                    ? const EdgeInsets.only(left: 20)
                    : null,
                leading: const Icon(Icons.logout),
                title: Visibility(
                  visible: _controller.extended,
                  child: const TextWidget(text: 'Logout'),
                ),
                onTap: () {
                  Get.offAllNamed('/login');
                },
              ),
            ),
          );
        },
        footerDivider: const Divider(),
        headerBuilder: (context, extended) {
          return Container(
            color: kBrownGoldColorSecondary,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    const Expanded(
                      child: CircleAvatar(),
                    ),
                    Visibility(
                      visible: _controller.extended,
                      child: const Expanded(
                        child: TextWidget(
                          text: "John Doe",
                          maxLines: 4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        extendedTheme: const SidebarXTheme(
          width: 250,
          decoration: BoxDecoration(
            color: kBrownGoldColor,
          ),
        ),
        items: controller.sidebarMenuItem);
  }
}

class ScreenNavigation extends StatelessWidget {
  const ScreenNavigation({Key? key, required this.sidebarXController})
      : super(key: key);
  final SidebarXController sidebarXController;
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: sidebarXController,
      builder: (context, child) {
        switch (sidebarXController.selectedIndex) {
          case 0:
            return HalamanUtama();
          case 1:
            return HalamanGuru();
          case 2:
            return HalamanMurid();
          case 3:
            return HalamanKelas();
          case 4:
            return HalamanRuangan();
          case 5:
            return HalamanJadwal();
          case 6:
            return HalamanPendaftaran();
          case 7:
            return HalamanUjian();
          default:
            return Center(child: TextWidget(text: 'Home'));
        }
      },
    );
  }
}
