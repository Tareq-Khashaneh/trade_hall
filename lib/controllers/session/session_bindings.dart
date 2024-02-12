

import 'package:trade_hall/controllers/session/session_controller.dart';
import 'package:get/get.dart';

class SessionBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(SessionController(),permanent: true);
  }
}