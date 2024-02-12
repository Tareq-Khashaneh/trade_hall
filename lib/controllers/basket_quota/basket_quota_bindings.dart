



import 'package:trade_hall/controllers/basket_quota/basket_quota_controller.dart';
import 'package:get/get.dart';

class BasketQuotaBindings implements Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BasketQuotaController());
  }
}