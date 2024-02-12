import 'package:trade_hall/controllers/auth/authenticate_controller.dart';
import 'package:get/get.dart';

class AuthBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AuthenticateController(),permanent: true);
  }
}
