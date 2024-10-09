import 'package:flutter/material.dart';
import 'package:trade_hall/core/localization/app_translation.dart';
import 'package:trade_hall/core/localization/locale_controller.dart';
import 'package:get/get.dart';
import 'core/constants/routes.dart';
import 'core/theme/app_colors.dart';
import 'getx_service/app_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppService().initialize();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    LocaleController localeController = Get.put(LocaleController());
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: AppColors.kWhiteColor,
        fontFamily: localeController.fontFamily,
        floatingActionButtonTheme: FloatingActionButtonThemeData(
            backgroundColor: AppColors.kmainColor),
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.kmainColor,
          centerTitle: true,
          foregroundColor: AppColors.kWhiteColor,
          iconTheme: IconThemeData(color: AppColors.kWhiteColor),
        ),
      ),
      debugShowCheckedModeBanner: false,
      translations: AppTranslation(),
      locale: localeController.language,
      initialRoute: AppRoutes.splash,
      getPages: AppRoutes.pages,
    );
  }
}
