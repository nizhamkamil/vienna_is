// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../../controller/controller.dart';
import '../text.dart';

class HalamanJadwal extends StatelessWidget {
  HalamanJadwal({super.key});

  Controller controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (controller.userMurid.isNotEmpty) {
      if (controller.userMurid[0].nama == null) {
        return Center(
          child: TextWidget(
              size: 18,
              text:
                  'Anda tidak dapat melihat jadwal karena anda belum terdaftar sebagai murid'),
        );
      }
    }

    return Padding(
      padding: EdgeInsets.all(80),
      child: Column(
        children: [
          TextWidget(
            text: 'Halaman Jadwal',
            size: 24,
            weight: FontWeight.bold,
          ),
          SizedBox(
            height: 50,
          ),
          Expanded(
            child: FutureBuilder(
              future: controller.userMurid.isNotEmpty
                  ? controller.fetchJadwalByIdMurid()
                  : controller.fetchJadwalByIdGuru(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Obx(() => SfCalendar(
                        timeSlotViewSettings: TimeSlotViewSettings(
                            timeInterval: Duration(minutes: 30),
                            timeFormat: 'HH:mm'),
                        view: CalendarView.week,
                        dataSource: controller.getCalendarDataSource(),
                      ));
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
