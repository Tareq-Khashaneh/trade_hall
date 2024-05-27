

import 'package:trade_hall/controllers/auth/admin_auth_controller.dart';
import 'package:get/get.dart';

class AuthAdminBindings implements Bindings{
  @override
  void dependencies() {
    Get.put(AdminAuthController());
  }
}