import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';

class AuthAdminController extends GetxController {
  bool isAdmin() {
    if (password.text.isNotEmpty) {
      String hashPassword = md5.convert(utf8.encode(password.text)).toString();
      if (hashPassword == _appService.dataDetails!.adminPass) {
        _appService.storage.write('admin', true);
        print("admin");
        return true;
      }
    }
    return false;
  }

  @override
  void onInit() {
    password = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  late TextEditingController password;
  final AppService _appService = Get.find();
}
