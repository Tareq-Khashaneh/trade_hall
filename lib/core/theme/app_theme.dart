

import 'dart:ui';

import 'package:trade_hall/core/localization/locale_controller.dart';
import 'package:get/get.dart';

class AppTheme {
  final LocaleController locale = Get.find();
   late double fontSize =    locale.fontSize.value;
  static const preferredSize = Size.fromHeight(70.0);
 }
