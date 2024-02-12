import 'package:flutter/material.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';

class LocaleController extends GetxController {
  AppService appService = Get.find();
  Locale? language;
  final RxDouble fontSize = 0.0.obs;
  late String fontFamily ;

  void changeLang(String codeLang) {
    Locale locale = Locale(codeLang);
    appService.storage.write('lang', codeLang);
    Get.updateLocale(locale);
    changeFontSize(locale);
    changeFontFamily(locale);
  }

  // Change font size based on language
  void changeFontFamily(Locale locale) {
    fontFamily = locale.languageCode == 'ar' ? 'Cairo' : 'Segoe UI';
  }
  void changeFontSize(Locale locale) {
    if (locale.languageCode == 'ar') {
      fontSize.value = 14;
    } else {
      fontSize.value = 20;
    }
  }

  @override
  void onInit() {
    String? langPrefs = appService.storage.read('lang');
    if (langPrefs == 'ar') {
      language = const Locale('ar');
      fontSize.value = 14;
      fontFamily = 'Cairo';
    } else if (langPrefs == 'en') {
      language = const Locale('en');
      fontSize.value = 20;
      fontFamily = 'Segoe UI';
    } else {
      language = const Locale('ar');
      fontSize.value = 14;
      fontFamily = 'Cairo';
    }
    super.onInit();
  }
}
