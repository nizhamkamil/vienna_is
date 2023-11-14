// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';

import 'package:vienna_is/view/widgets/pluto_table/tabel_pendaftaran.dart';

import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';

import '../text.dart';

class HalamanPendaftaranAdmin extends StatelessWidget {
  HalamanPendaftaranAdmin({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    RxBool showFilter = false.obs;
    return Padding(
      padding: const EdgeInsets.all(80),
      child: Column(
        children: [
          const TextWidget(
            text: 'Halaman Pendaftaran',
            size: 24,
            weight: FontWeight.bold,
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            children: [
              const Expanded(
                flex: 1,
                child: TextWidget(
                  text: 'Tabel Pendaftaran',
                  weight: FontWeight.bold,
                  size: 18,
                ),
              ),
              const Spacer(
                flex: 6,
              ),
              BtnWidget(
                radius: 4,
                height: 40,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ],
                btnColor: Colors.white,
                outlineColor: kBrownGoldColorSecondary,
                icon: const Icon(
                  Icons.filter_alt,
                  color: kBrownGoldColorSecondary,
                ),
                onPress: () {
                  showFilter.value = !showFilter.value;
                  controller.pendaftaranStateManager
                      ?.setShowColumnFilter(showFilter.value);
                },
                textWidget: const TextWidget(
                  text: 'Show Filter',
                  color: kBrownGoldColorSecondary,
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: TabelPendaftaran(),
          )
        ],
      ),
    );
  }
}
