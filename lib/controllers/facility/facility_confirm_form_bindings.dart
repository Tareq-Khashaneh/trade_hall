
import 'package:get/get.dart';
import 'facility_confirm_form_controller.dart';
class FacilityConfirmFormBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => FacilityConfirmFormController());
  }
}