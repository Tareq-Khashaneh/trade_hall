import 'package:flutter/material.dart';
import 'package:trade_hall/core/theme/app_colors.dart';
import 'package:trade_hall/core/localization/locale_controller.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';
import 'package:trade_hall/view/widgets/app_bar_widget.dart';
import 'package:get/get.dart';

class LanguageScreen extends StatelessWidget {
  LanguageScreen({super.key});
  final LocaleController localeController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kWhiteColor,
      appBar: buildAppBar(title: TranslationKeys.language.tr, context: context),
      body: SafeArea(
        child: Center(
          child: Container(
            width: Get.size.width * 0.68,
            height: Get.size.height * 0.5,
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(40)),
                color: AppColors.kmainColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        localeController.changeLang('ar');
                        Get.back();
                      },
                      child: Text(TranslationKeys.arabic.tr)),
                ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      localeController.changeLang('en');
                      Get.back();
                    },
                    style: ButtonStyle(

                      backgroundColor: MaterialStateProperty.all<Color?>(AppColors.kWhiteColor)
                    ),
                    child: Text(TranslationKeys.english.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
