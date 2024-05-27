
import 'package:flutter/services.dart';
import 'package:trade_hall/data/providers/init_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:trade_hall/data/repositories/init_repo.dart';
import 'package:trade_hall/networking/api_service.dart';
import 'package:trade_hall/networking/connectivity%20_controller.dart';
import '../core/constants/api_endpoint.dart';
import '../core/constants/typedef.dart';
import '../data/models/data_model.dart';

class AppService extends GetxService {
  late GetStorage storage;
  late DataModel? dataDetails;
  late String deviceSerialNum;
  late parameters params;
  late bool isConnected;
  late bool isServerConnected;
  late InitProvider initProvider;
  late ApiServiceDio apiService;
  late bool isApnFound;
  final String appVersion = "1.1.1";
  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());

  final MethodChannel platformMain =
      const MethodChannel('samples.flutter.dev/mainInfo');
  final MethodChannel platformRead =
      const MethodChannel('samples.flutter.dev/read');
  final MethodChannel platformPrint =
      const MethodChannel('samples.flutter.dev/print');


  Future<AppService> init() async {
    await GetStorage.init();
    storage = GetStorage();
    await getSerialNumber();
    params = {
      'dev_sn': deviceSerialNum,
      'app_version': appVersion,
    };
    await platformMain.invokeMethod('setMainSettings');
    isConnected = await checkConnectivity();
    if (isConnected) {
      if (storage.read("ip") != null && storage.read("port") != null) {
        isServerConnected = await initializeDataDetails(
            ip: storage.read("ip"), port: storage.read("port"));
      }
    } else {
      isServerConnected = false;
    }
    return this;
  }

  Future<bool> initializeDataDetails(
      {required String ip, required String port}) async {
    Api.setBaseUrl(ip: ip, port: port);
    apiService = ApiServiceDio();
    initProvider =
        InitProvider(initRepository: InitRepository(apiService: apiService));
    dataDetails = await initProvider.getMainData(params);
    return dataDetails != null ? true : false;
  }



  Future<bool> checkConnectivity() async =>
      await connectivityController.checkNetworkConnection();

  Future<bool> isApnInList() async =>
      await platformMain.invokeMethod("isApnInList", {'apnName': "sourcecode"});

  Future<void> getSerialNumber() async {
    try {
      deviceSerialNum = await platformMain.invokeMethod('readDeviceInfo');
    } catch (e) {
      print('Error calling native method: $e');
    }
  }

  Future<void> getMainData() async {
    dataDetails = await initProvider.getMainData(params);
  }

  Future<bool> setDateTime() async {
    bool isSet = false;
    try {
      if (dataDetails != null) {
        DateTime dateTime = DateTime.parse(dataDetails!.svTm!);
        String formattedDate = DateFormat('yyyyMMddHHmmss').format(dateTime);
        isSet = await platformMain.invokeMethod('setDateTime', formattedDate);
      }
    } catch (e) {
      print("error in setDateTime $e");
    }
    return isSet;
  }

  Future<void> initialize() async {
    await Get.putAsync(() => AppService().init());
  }
}
