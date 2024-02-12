import 'package:flutter/services.dart';
import 'package:trade_hall/data/providers/init_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import '../core/constants/typedef.dart';
import '../data/models/data_model.dart';

class AppService extends GetxService {
  late GetStorage storage;
  late DataModel? dataDetails;
  late String deviceSerialNum;
  late parameters params;
  final String appVersion = "1.1.1";
  final InitProvider initProvider = InitProvider();
  final MethodChannel mainChannel =
      const MethodChannel('samples.flutter.dev/mainInfo');
  final MethodChannel platformRead =
  const MethodChannel('samples.flutter.dev/read');
  final MethodChannel platformPrint =
  const MethodChannel('samples.flutter.dev/print');

  Future<AppService> init() async {
    await GetStorage.init();
    storage =  GetStorage();
    try {
      deviceSerialNum = await mainChannel.invokeMethod('readDeviceInfo');
      params = {
        'dev_sn': deviceSerialNum,
        'app_version': appVersion,
      };
     await setDeviceInfo();
    } catch (e) {
      print('Error calling native method: $e');
    }
    return this;
  }

  Future<bool> setDeviceInfo() async {
    dataDetails = await initProvider.getMainData(params);
    bool isSet = false;
    if (dataDetails != null) {
      DateTime dateTime = DateTime.parse(dataDetails!.svTm!);
      String formattedDate = DateFormat('yyyyMMddHHmmss').format(dateTime);
      isSet = await mainChannel.invokeMethod('setMainData', formattedDate);
    }
    return isSet;
  }

  Future<void> initialize() async {
    await Get.putAsync(() => AppService().init());
  }
}
