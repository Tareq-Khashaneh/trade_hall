import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:trade_hall/networking/connectivity%20_controller.dart';

class SettingsController extends GetxController {
  @override
  void onInit() async {
    selectedChoice = connectionChoices.elementAt(0);
 await isApnInList();
    super.onInit();
  }

  @override
  void dispose() {
    ssid.dispose();
    password.dispose();
    serverIpController.dispose();
    apnIPController.dispose();
    apnPortController.dispose();
    portController.dispose();
    nameController.dispose();
    apnController.dispose();
    super.dispose();
  }

  void changeChoiceValue({required String value}) async {
    selectedChoice = value;
    await isApnInList();
    update();
  }

  void clearFields() {
    ssid.clear();
    password.clear();
    serverIpController.clear();
    portController.clear();
    apnIPController.clear();
    apnPortController.clear();
    nameController.clear();
    apnController.clear();
  }

  bool isTypeConnectionWIFI() => selectedChoice == 'Wifi' ? true : false;

  void openNetworkSettings()async{
    await appService.platformMain.invokeMethod('openNetworkSettings');
  }
  Future<bool> connectToWifi() async {
    isLoading = true;
    update();
    final Completer<bool> completer = Completer<bool>();
    try {
      appService.platformMain.invokeMethod('setWifiInfo',
          {'ssid': ssid.text, 'password': password.text}).then((value) async {
        Future.delayed(const Duration(seconds: 2)).then((value) async {
          bool isConnected = await appService.checkConnectivity();
          if (!isConnected) {
            isLoading = false;
            update();
          }
          completer.complete(isConnected);
        });
      });
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }



  Future<bool> isApnInList() async {
    isApnFound = await appService.platformMain
        .invokeMethod("isApnInList", {'apnName': "sourcecode"});
    update();
    if (isApnFound) {
      isLoading = false;
      update();
      return true;
    }
    return false;
  }
  Future<bool> createApn() async {
    isLoading = true;
    update();
    Map<String, String> parameters = {
      'ip': apnIPController.text,
      'port': apnPortController.text,
      'name': nameController.text,
      'apnName': apnController.text,
    };
    bool isCreated =
        await appService.platformMain.invokeMethod("create apn", parameters);
    return isCreated;
  }

  void deleteApn() async {
    await appService.platformMain
        .invokeMethod("deleteApn", {'apnName': 'sourcecode'});
  }

  Future<bool> enableMobileData() async {
    bool isEnabled = false;
    try {
      isEnabled =
          await appService.platformMain.invokeMethod("enableMobileData");
    } catch (e) {
      print("error in connect to mobile data $e");
    }
    return isEnabled;
  }

  Future<bool> checkConnectToServer() async {
    final Completer<bool> completer = Completer<bool>();
    try {
      appService
          .initializeDataDetails(
              ip: serverIpController.text, port: portController.text)
          .then((value) {
        if (appService.dataDetails != null) {
          print("data details is not null in setting controller");
          appService.storage.write("ip", serverIpController.text);
          appService.storage.write("port", portController.text);
          completer.complete(true);
        } else {
          print("data details is  null in setting controller");
          completer.complete(false);
        }
        isLoading = false;
        update();
      });
    } catch (e) {
      completer.completeError(e);
    }
    return completer.future;
  }
  final TextEditingController  ssid = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController
  serverIpController = TextEditingController();
  final TextEditingController apnIPController = TextEditingController();
  final TextEditingController apnPortController = TextEditingController();
  final TextEditingController portController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController apnController = TextEditingController();
  late String selectedChoice;
  final List<String> connectionChoices = ['Wifi', 'Sim card'];
  final wifiFormKey = GlobalKey<FormState>();
  final mobileDataFormKey = GlobalKey<FormState>();
  final serverFormKey = GlobalKey<FormState>();
  bool isLoading = false;
  late bool isApnFound;
  final AppService appService = Get.find();

  final ConnectivityController connectivityController =
      Get.put(ConnectivityController());
}
