// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:getwidget/components/card/gf_card.dart';
import 'package:getwidget/getwidget.dart';
import 'package:vienna_is/view/widgets/text.dart';

import '../../../config/theme.dart';
import '../button.dart';

class HalamanUtama extends StatelessWidget {
  const HalamanUtama({super.key});

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
              text: 'Selamat Datang, John Doe',
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
            child: Wrap(
                spacing: 8,
                runSpacing: 12,
                direction: Axis.horizontal,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: GFCard(
                      padding: EdgeInsets.all(0),
                      elevation: 5,
                      showImage: true,
                      boxFit: BoxFit.fill,
                      image: Image.network(
                        placeHolderUrl,
                      ),
                      title: GFListTile(
                        title: const TextWidget(
                          text: 'Kelas Piano',
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        subTitle: SingleChildScrollView(
                          child: TextWidget(
                            text: landingPageCardSubtitle,
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: GFCard(
                      padding: EdgeInsets.all(0),
                      elevation: 5,
                      showImage: true,
                      boxFit: BoxFit.fill,
                      image: Image.network(
                        placeHolderUrl,
                      ),
                      title: GFListTile(
                        title: const TextWidget(
                          text: 'Kelas Piano',
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        subTitle: SingleChildScrollView(
                          child: TextWidget(
                            text: landingPageCardSubtitle,
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
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: GFCard(
                      padding: EdgeInsets.all(0),
                      elevation: 5,
                      showImage: true,
                      boxFit: BoxFit.fill,
                      image: Image.network(
                        placeHolderUrl,
                      ),
                      title: GFListTile(
                        title: const TextWidget(
                          text: 'Kelas Piano',
                          size: 24,
                          weight: FontWeight.bold,
                        ),
                        subTitle: SingleChildScrollView(
                          child: TextWidget(
                            text: landingPageCardSubtitle,
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
                  ),
                ]),
          ),
        ),
      ],
    );
  }
}
