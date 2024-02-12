import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trade_hall/data/models/product_model.dart';
import 'package:trade_hall/data/repositories/facility_repo.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';
import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';

class FacilityConfirmFormController extends GetxController with WidgetsBindingObserver {
  final formKey = GlobalKey<FormState>();
  late TextEditingController orderNum;
  late TextEditingController quantity;
  late TextEditingController confirmSentQuantity;
  late ProductModel? product;
  String mastercardId = '';
  bool isLoading = false;
  final FacilityRepository facilityRep = FacilityRepository();
  final AppService appService = Get.find();
  String? validate(String? value) {
    if (value != null) {
      if (value.isNotEmpty) {
        int val = int.parse(value);
        if (val == 0) {
          return "value is zero";
        }
      } else if (value.isEmpty) {
        return "value is Empty";
      }
    }
    return null;
  }
  Future<void> stopRead()async{
    appService.platformRead.invokeMethod('stopRead').then((value) {
      if(value){
        isLoading = false;
        update();
      }
    });
  }
  Future<bool> sendConfirmQuantity() async {
    try {
      parameters params = {
        'quantity': quantity.text,
        'product_id': product!.id,
        'order_no': orderNum.text,
      };
      params.addAll(appService.params);
      parameters? data = await facilityRep.confirmQuantity(params: params);
      if (data != null) {
        return true;
      }
    } catch (e) {
      print("error in facility confirm controller $e");
      return false;
    }
    return false;
  }

  bool isMasterCardEnable() =>
      appService.dataDetails!.settings.cardMasterRequired == 1 ? true: false;

  Future<bool> readMasterCard() async {
    try {
      isLoading = true;
      update();
      final Map data = await appService.platformRead.invokeMethod('readCard');
      final bool isTimeOut = data['isTimeOut'];
      mastercardId = data['cardId'];
      if (isTimeOut == true || mastercardId.isNotEmpty) {
        isLoading = false;
        update();
      }
      if (mastercardId.isNotEmpty) {
        print("card id $mastercardId");
        return true;
      }
    } catch (e) {
      showSnackBar(
        'خطأ في قراءة البطاقة',
      );
      print('Error calling native method: $e');
      isLoading = false;
      update();
      return false;
    }
    return false;
  }

  Future<bool> sendConfirmQuantityMasterCard() async {
    try {
      if(mastercardId.isNotEmpty)
        {
          parameters params = {
            'quantity': quantity.text,
            'product_id': product!.id,
            'order_no': orderNum.text,
            'rfid': mastercardId,
          };
          params.addAll(appService.params);
          parameters? data =
          await facilityRep.confirmQuantityMasterCard(params: params);
          if (data != null) {
            print("data $data");
            return true;
          }
        }
    } catch (e) {
      print(
          "error in facility confirm controller sendConfirmQuantityMasterCard $e");
      return false;
    }
    return false;
  }
  @override
  void dispose() {
    orderNum.dispose();
    quantity.dispose();
    confirmSentQuantity.dispose();
    super.dispose();
  }

  @override
  void onInit() {
    WidgetsBinding.instance.addObserver(this);
    product = Get.arguments;
    orderNum = TextEditingController();
    quantity = TextEditingController();
    confirmSentQuantity = TextEditingController();
    super.onInit();
  }
  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Perform actions based on the app lifecycle state
    switch (state) {
      case AppLifecycleState.resumed:
      // App is resumed
        break;
      case AppLifecycleState.paused:
        stopRead();
        print("isPAUSED");
        // App is paused
        break;
      case AppLifecycleState.inactive:
        // stopRead();
        // print("inactive");
      // App is inactive
        break;
      case AppLifecycleState.detached:
      // App is detached (iOS specific)
        break;
      case AppLifecycleState.hidden:
      // TODO: Handle this case.
    }
  }

}
