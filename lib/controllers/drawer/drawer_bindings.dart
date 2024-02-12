

import 'package:trade_hall/controllers/drawer/drawer_controller.dart';
import 'package:get/get.dart';

class DrawerBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(DrawerGetxController(),permanent: true);
  }
}