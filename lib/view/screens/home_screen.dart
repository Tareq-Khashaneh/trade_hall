import 'dart:async';

import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/home/home_controller.dart';
import 'package:trade_hall/core/constants/error.dart';

import 'package:trade_hall/view/widgets/bottom_nav_bar_container.dart';
import 'package:trade_hall/view/widgets/drawer_widget.dart';
import 'package:trade_hall/view/widgets/image_container.dart';
import 'package:trade_hall/view/widgets/session_card.dart';
import 'package:trade_hall/view/widgets/title_widget.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      BottomNavBarContainer(
                          fontSize: Get.size.height * 0.03,
                          width: Get.size.width * 0.4,
                          color: controller.isLoading
                              ? AppColors.kColorGreyDark
                              : null,
                          text: TranslationKeys.scanCard.tr,
                          onTap: !controller.isLoading
                              ? () async {
                                  if (await controller.readCard()) {
                                    Get.toNamed(
                                      AppRoutes.basketQuotaRoute,
                                    );
                                  }
                                }
                              : null),
                      BottomNavBarContainer(
                          fontColor: !controller.isLoading
                              ? AppColors.kBlack
                              : AppColors.kWhiteColor,
                          fontSize: Get.size.height * 0.03,
                          width: Get.size.width * 0.4,
                          color: !controller.isLoading
                              ? AppColors.kColorGreyDark
                              : null,
                          text: TranslationKeys.cancelScan.tr,
                          onTap: controller.isLoading
                              ? () async {
                                  controller.stopRead();
                                }
                              : null)
                    ],
                  ))),
          appBar: AppBar(
            title: Text(
              controller.appService.dataDetails?.facilityName ?? '',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppColors.kWhiteColor),
            ),
            backgroundColor: AppColors.kmainColor,
          ),
          drawer: const DrawerWidget(),
          body: SafeArea(
              child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  color: AppColors.kmainColor.withOpacity(0.9),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      leading: ImageContainer(
                        img: "assets/images/profile.jpg",
                        width: Get.size.height * 0.1,
                        height: Get.size.height * 0.1,
                        isAllCornerCurve: true,
                        boxFit: BoxFit.contain,
                        borderRadius: 12,
                      ),
                      title: Text(controller.currentUser?.userName ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: AppColors.kWhiteColor,
                                  fontWeight: FontWeight.bold)),
                      trailing: const Icon(
                        Icons.check_circle,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.size.height * 0.03,
                ),
                Obx(() => controller.isLoading
                    ? Padding(
                        padding: const EdgeInsets.only(top: 50.0),
                        child: Center(
                          child: Lottie.asset(
                              'assets/animations/card_scan.json',
                              width: 500,
                              fit: BoxFit.cover),
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TitleWidget(
                            title: TranslationKeys.sessions.tr,
                            fontSize: 30,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          SizedBox(
                            height: 275,
                            child: ListView.builder(
                                itemCount: controller.sessions.length,
                                itemBuilder: (context, index) {
                                  return SessionCard(
                                      sessionInfo: controller
                                          .sessions[index].sessionInfo,
                                      onTap: () {
                                        controller.sessionController.getSession(
                                            int.parse(controller
                                                .sessions[index].sessionId));
                                        Get.toNamed(AppRoutes.sessionRoute);
                                      });
                                }),
                          ),
                        ],
                      ))
              ],
            ),
          ))),
    );
  }
}
