import 'package:get/get.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:vienna_is/controller/controller.dart';

class DataSource extends CalendarDataSource {
  Controller controller = Get.find();

  DataSource(List<Appointment> source) {
    appointments = source;
  }
}
