import 'package:get/get.dart';

import 'controller.dart';
import 'pluto_controller.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(Controller());
    Get.put(PlutoController());
  }
}
