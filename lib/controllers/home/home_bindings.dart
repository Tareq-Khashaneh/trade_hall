import 'package:trade_hall/controllers/drawer/drawer_controller.dart';
import 'package:trade_hall/controllers/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController(),fenix: true);
  }
}
