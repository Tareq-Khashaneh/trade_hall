import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/auth/admin_auth_controller.dart';
import 'package:get/get.dart';

import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';
import '../../core/theme/app_theme.dart';
import '../widgets/custom_field.dart';
import '../widgets/custom_icon.dart';
import '../widgets/image_container.dart';

class AuthAdminScreen extends GetView<AuthAdminController> {
  const AuthAdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.kmainColor,
        body: SafeArea(
          child: Stack(
            children: [
              // Image Container
               ImageContainer(
                img: "assets/images/login_img.jpg",
              ),
              ListView(
                children: [
                  SizedBox(
                    height: Get.size.height * 0.4,
                  ),
                  // Login Fields Container
                  Container(
                    padding:
                        const EdgeInsets.only(top: 10, left: 20, right: 20),
                    height: Get.size.height * 0.58,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.white),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Text(TranslationKeys.welcomeBack.tr,
                              textAlign: TextAlign.start,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 30,
                                      color: AppColors.kmainColor,
                                      fontWeight: FontWeight.bold)),
                          SizedBox(
                            height: Get.size.height * 0.03,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                TranslationKeys.pleaseSignIn.tr,
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(
                                        color: AppColors.kTextColor,
                                        fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: Get.size.height * 0.03,
                              ),
                            ],
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(top: Get.size.height * 0.02),
                            child: Stack(
                              children: [
                                CustomField(
                                  controller: controller.password,
                                  contentPadding: const EdgeInsets.only(
                                      left: 40, top: 5, bottom: 5, right: 10),
                                  label: TranslationKeys.password.tr,
                                  isSecure: true,
                                ),
                                const Positioned(
                                    top: 1,
                                    left: 1,
                                    child: CustomIcon(icon: Icons.lock_rounded))
                              ],
                            ),
                          ),
                          SizedBox(
                            height: Get.size.height * 0.03,
                          ),
                          // Login Button
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: InkWell(
                                onTap: () {
                                  if (controller.isAdmin()) {
                                    Get.offNamed(
                                      AppRoutes.authenticateRoute,
                                    );
                                  }
                                  controller.password.clear();
                                },
                                child: Container(
                                  alignment: Alignment.center,

                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 12, left: 8, right: 10),
                                  width: Get.size.width * 0.4,
                                  decoration: BoxDecoration(
                                      color: AppColors.kmainColorHex,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(40)),
                                      boxShadow: [
                                        BoxShadow(
                                            offset: Offset(0, 2),
                                            blurRadius: 4,
                                            color: AppColors.kmainColor),
                                        BoxShadow(
                                            offset: Offset(2, 2),
                                            color: AppColors.kSecondColor),
                                        BoxShadow(
                                            offset: Offset(-2, 2),
                                            color: AppColors.kSecondColor)
                                      ]),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Obx(() =>  Text(
                                        TranslationKeys.login.tr,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall!
                                            .copyWith(
                                            fontSize: AppTheme().fontSize,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontStyle: FontStyle.italic),
                                      ),),

                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Column(
                                        children: [
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Icon(
                                            Icons.arrow_forward,
                                            color: Colors.white,
                                            size: Get.size.height * 0.03,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
