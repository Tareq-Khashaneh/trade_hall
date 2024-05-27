import 'package:flutter/material.dart';
import 'package:trade_hall/core/enums/enum_state.dart';
import 'package:trade_hall/view/widgets/circular_loading.dart';
import 'package:get/get.dart';
import '../../controllers/drawer/drawer_controller.dart';
import '../../core/constants/routes.dart';
import '../../core/localization/translation_keys.dart';

class DrawerWidget extends GetView<DrawerGetxController> {
  const DrawerWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      "assets/images/login_img.jpg",
                    ),
                    fit: BoxFit.cover)),
            child: null,
          ),
          _buildListTile(
              icon: Icons.home_rounded,
              text: TranslationKeys.home.tr,
              onTap: () => Get.offNamed(AppRoutes.homeScreenRoute)),
          const Divider(),
          _buildListTile(
              icon: Icons.language_rounded,
              text: TranslationKeys.language.tr,
              onTap: () => Get.toNamed(AppRoutes.languageRoute)),
          const Divider(),
          _buildListTile(
              icon: Icons.location_city,
              text: TranslationKeys.facilityInfo.tr,
              onTap: () async {
                Get.toNamed(AppRoutes.facilityAuthRoute);
              }),
          const Divider(),
          _buildListTile(
              icon: Icons.info_outline_rounded,
              text: TranslationKeys.getLastSession.tr,
              onTap: () {
                controller.sessionController.getSession(int.parse(
                    controller.authenticateController.authModel!.sessionId!));
                Get.toNamed(AppRoutes.sessionRoute);
              }),
          const Divider(),
          _buildListTile(
              icon: Icons.date_range_rounded,
              text: TranslationKeys.setDate.tr,
              trailing: GetBuilder<DrawerGetxController>(builder: (controller) {
                return controller.isLoadingSetTime
                    ? const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: SizedBox(
                            width: 33, height: 30, child: CircularLoading()),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          controller.setDeviceTime();
                        },
                        child: Text(TranslationKeys.setTime.tr));
              })),
          const Divider(),
          _buildListTile(
              icon: Icons.wifi_rounded,
              text: TranslationKeys.setConnectivity.tr,
              onTap: () {
                Get.toNamed(AppRoutes.authAdminRoute);
              }),

          const Divider(),
          _buildListTile(
            icon: Icons.logout_rounded,
            text: TranslationKeys.logout.tr,
            onTap: () async {
              if (await controller.logout()) {
                Get.offAllNamed(AppRoutes.authenticateRoute);
              } else {
                print("not logged out");
              }
            },
          ),
        ],
      ),
    );
  }

  _buildListTile(
          {required IconData icon,
          required String text,
          Function()? onTap,
          Widget? trailing}) =>
      Container(
          margin: const EdgeInsets.only(bottom: 0.5),
          child: GetBuilder<DrawerGetxController>(builder: (controller) {
            return ListTile(
                leading: Icon(
                  icon,
                ),
                title: Text(
                  text,
                ),
                trailing: trailing,
                onTap: () {
                  print(
                      "cardreader state ${controller.homeController.cardReadStatus}");
                  if (controller.homeController.cardReadStatus !=
                      EnumStatus.loading) {
                    onTap!();
                  }
                });
          }));
}
