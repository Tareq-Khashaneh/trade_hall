import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/facility/facility_controller.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';

import 'package:trade_hall/view/widgets/drawer_widget.dart';
import 'package:get/get.dart';

import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';

class FacilityScreen extends GetView<FacilityController> {
  const FacilityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
              drawer: const DrawerWidget(),
              appBar: AppBar(
        title: Text(TranslationKeys.facilityInfo.tr),
              ),
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
                    onPressed: () => Get.toNamed(AppRoutes.facilityInfoRoute),
                    child: Text(TranslationKeys.getInfo.tr),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () =>
                        Get.toNamed(AppRoutes.facilitySendQuantityRoute),
                    child: Text(TranslationKeys.sendQuantity.tr),
                  ),
                ),
              ],
            ),
          ),
        ),
              ),
            ));
  }
}
