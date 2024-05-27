

import 'package:get/get.dart';
import 'package:trade_hall/networking/connectivity%20_controller.dart';

class ConnectivityBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(ConnectivityController());
  }
}