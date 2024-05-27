import 'dart:async';
import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:trade_hall/core/constants/error.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';
import 'package:trade_hall/networking/connectivity%20_controller.dart';

import '../../core/constants/routes.dart';

class AdminAuthController extends GetxController {
  bool isAdmin() {
    if (password.text.isNotEmpty) {
      String hashPassword =
          md5.convert(utf8.encode(password.text)).toString().toUpperCase();
      if (password.text != adminPassword) {
        showSnackBar(TranslationKeys.passwordisWrong.tr);
        return false;
      }
      _appService.storage.write('admin', true);
      return true;
    }
    showSnackBar(TranslationKeys.passwordisempty.tr);
    return false;
  }

  @override
  void onInit() async {
    connectivityController.subscription = Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) async {
      await Future.delayed(const Duration(seconds: 15));
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        if (_appService.storage.read("ip") != null && _appService.storage.read("port") != null) {
          bool isServerConnected = await _appService.initializeDataDetails(
              ip: _appService.storage.read("ip"),
              port: _appService.storage.read("port"));
          if (isServerConnected) {
            print("here"); 
            Get.offAllNamed(AppRoutes.splash);
          }
        }
      }
    });
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    connectivityController.subscription.cancel();
    super.dispose();
  }

  final ConnectivityController connectivityController = Get.find();
  late TextEditingController password;
  final adminPassword = "1111";
  final AppService _appService = Get.find();
}
