import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:trade_hall/data/models/auth_model.dart';
import 'package:trade_hall/data/providers/auth_provider.dart';
import 'package:get/get.dart';
import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';
import '../../core/localization/translation_keys.dart';
import '../../data/models/user_model.dart';
import '../../getx_service/app_service.dart';

class AuthenticateController extends GetxController {
  Future<bool> login() async {
    try {
      if (password.text.isNotEmpty && currentUser != null) {
        String hashPassword = generateMd5(password.text).toUpperCase();
        if(currentUser!.pin != hashPassword)
          {
              showSnackBar(TranslationKeys.passwordisWrong.tr);
              return false;
          }
        parameters loginParams = {
          'user_id': currentUser!.id,
          'pass': hashPassword,
        };
        loginParams.addAll(_appService.params);
        authModel = await _authProvider.getAuthData(loginParams);
        if (authModel != null) {
          return true;
        }
        return false;
      }
    } catch (e) {
      showSnackBar('$e');
      return false;
    }
    return false;
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  @override
  void onInit() async {
    password = TextEditingController();
    users = _appService.dataDetails?.users ?? [];
    super.onInit();
  }

  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  String? validate(String? value) {
    if (value!.isEmpty) {
      return TranslationKeys.pleasEnterThePassword.tr;
    }
    return null;
  }

  //variables
  AuthModel? authModel;
  final formKey = GlobalKey<FormState>();
  final AuthProvider _authProvider = AuthProvider();
  final AppService _appService = Get.find();
  Rx<UserModel>? _currentUser;
  late TextEditingController password;
  final RxBool _isLoading = RxBool(false);
  late final RxList<UserModel> _users = RxList([]);
  //setters
  set users(List<UserModel> users) => _users.value = users;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;
  set currentUser(UserModel? currentUser) => _currentUser = currentUser?.obs;
  //getters
  UserModel? get currentUser => _currentUser?.value;
  List<UserModel> get users => _users;
  bool get isLoading => _isLoading.value;
}
