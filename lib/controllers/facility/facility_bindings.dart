

import 'package:trade_hall/controllers/facility/facility_controller.dart';
import 'package:get/get.dart';

class FacilityBindings implements Bindings{
  @override
  void dependencies() {
    Get.put( FacilityController(),permanent: true);
  }

}