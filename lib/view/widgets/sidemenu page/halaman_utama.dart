// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../../config/theme.dart';
import '../../../controller/controller.dart';
import '../button.dart';

class HalamanUtama extends StatelessWidget {
  HalamanUtama({super.key});
  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: Colors.grey), // Add a border to the bottom only
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TextWidget(
              text: controller.role.value == 'Guru'
                  ? 'Selamat Datang Kembali,  ${controller.userGuru[0].nama}'
                  : controller.role.value == 'Murid'
                      ? 'Selamat Datang Kembali,  ${controller.userMurid[0].nama}'
                      : 'Selamat Datang Kembali,  ${controller.userAdmin.value.nama!}',
              size: 24,
              weight: FontWeight.bold,
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: TextWidget(
              text: 'Halaman Utama',
              size: 24,
              weight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: FutureBuilder(
              future: controller.fetchKelas(),
              builder: (context, snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {
                  return Wrap(
                    spacing: 8,
                    runSpacing: 12,
                    direction: Axis.horizontal,
                    children: controller.kelasKomplitList.map((element) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.25,
                        child: GFCard(
                          padding: EdgeInsets.all(0),
                          elevation: 5,
                          showImage: true,
                          boxFit: BoxFit.fill,
                          image: Image.network(
                            '$configUrl/assets/${element.kelasFoto[0].pathFoto}',
                            loadingBuilder: (context, child, loadingProgress) {
                              return loadingProgress == null
                                  ? child
                                  : const Center(
                                      child: CircularProgressIndicator(),
                                    );
                            },
                          ),
                          title: GFListTile(
                            title: TextWidget(
                              text: element.namaKelas,
                              size: 24,
                              weight: FontWeight.bold,
                            ),
                            subTitle: SingleChildScrollView(
                              child: TextWidget(
                                text: element.deskripsiKelas,
                                maxLines: 20,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                          buttonBar: GFButtonBar(
                            alignment: WrapAlignment.start,
                            runAlignment: WrapAlignment.start,
                            crossAxisAlignment: WrapCrossAlignment.start,
                            children: <Widget>[
                              GFListTile(
                                  subTitle: BtnWidget(
                                height: 40,
                                radius: 4,
                                btnColor: kBrownColor,
                                onPress: () {},
                                textWidget: TextWidget(text: 'Lihat Kelas'),
                              )),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  );
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
