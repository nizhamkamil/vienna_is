// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings, must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:get/get.dart';

import 'package:vienna_is/controller/controller.dart';

import '../text.dart';

class HalamanUtamaAdmin extends StatelessWidget {
  HalamanUtamaAdmin({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        controller.fetchGuru(),
        controller.fetchMurid(),
        controller.fetchJadwal(),
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.done) {
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
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.25),
                    child: Wrap(
                      spacing: 100,
                      runSpacing: 100,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: 250,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.blueAccent.withOpacity(0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextWidget(
                                        text: 'Jumlah Guru',
                                        weight: FontWeight.bold,
                                        size: 18,
                                      ),
                                      TextWidget(
                                          color: Colors.black45,
                                          weight: FontWeight.bold,
                                          text: 'Total : ' +
                                              controller.guruList.length
                                                  .toString()),
                                    ],
                                  ),
                                  Icon(Icons.person,
                                      size: 50,
                                      color: Colors.blue.withOpacity(0.5))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: 250,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.green.withOpacity(0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextWidget(
                                        text: 'Jumlah Murid',
                                        weight: FontWeight.bold,
                                        size: 18,
                                      ),
                                      TextWidget(
                                          color: Colors.black45,
                                          weight: FontWeight.bold,
                                          text: 'Total : ' +
                                              controller.muridList.length
                                                  .toString()),
                                    ],
                                  ),
                                  Icon(Icons.people,
                                      size: 50,
                                      color: Colors.green.withOpacity(0.5))
                                ],
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Container(
                            width: 250,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: Colors.orange.withOpacity(0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 10,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      TextWidget(
                                        text: 'Jumlah Jadwal',
                                        weight: FontWeight.bold,
                                        size: 18,
                                      ),
                                      TextWidget(
                                          color: Colors.black45,
                                          weight: FontWeight.bold,
                                          text: 'Total : ' +
                                              controller.jadwalList.length
                                                  .toString()),
                                    ],
                                  ),
                                  Icon(Icons.schedule,
                                      size: 50,
                                      color: Colors.orange.withOpacity(0.5))
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          );
        } else {
          return Center(child: const CircularProgressIndicator());
        }
      },
    );
  }
}
