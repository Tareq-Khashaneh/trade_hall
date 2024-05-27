

import 'package:get/get.dart';
import 'package:trade_hall/controllers/settings/settings_controller.dart';

class SettingsBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SettingsController());
  }
}