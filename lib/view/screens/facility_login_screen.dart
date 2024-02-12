import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/facility/facility_controller.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';

import 'package:trade_hall/view/widgets/custom_button.dart';
import 'package:trade_hall/view/widgets/custom_field.dart';
import 'package:get/get.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_icon.dart';
import '../widgets/image_container.dart';

class FacilityLoginScreen extends GetView<FacilityController> {
  const FacilityLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body: GetBuilder<FacilityController>(builder: (controller) {
        return Stack(
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
                  padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
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
                        Text(TranslationKeys.facilityInfo.tr,
                            textAlign: TextAlign.start,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                    fontSize: 26,
                                    color: AppColors.kmainColor,
                                    fontWeight: FontWeight.bold)),
                        SizedBox(
                          height: Get.size.height * 0.03,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              TranslationKeys.facilityPassword.tr,
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 24,
                                      color: AppColors.kTextColor,
                                      fontWeight: FontWeight.w400),
                            ),
                            SizedBox(
                              height: Get.size.height * 0.03,
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: Get.size.height * 0.02),
                          child: Stack(
                            children: [
                              Form(
                                key: controller.formKey,
                                child: CustomField(
                                    controller: controller.password,
                                    label: TranslationKeys.password.tr,
                                    isSecure: true,
                                    contentPadding: const EdgeInsets.only(
                                        left: 40, top: 5, bottom: 5, right: 10),
                                    validator: (value) =>
                                        controller.validate(value)),
                              ),
                              const Positioned(
                                  top: 1,
                                  left: 1,
                                  child: CustomIcon(icon: Icons.lock_rounded))
                            ],
                          ),
                        ),

                        // Login Button
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: CustomButton(
                                onTap: () async {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    controller.login().then((value) {
                                      if (value == true) {
                                        controller
                                            .getFacilityInfo()
                                            .then((value) {
                                          if (controller.facilityInfo != null) {
                                            Get.offNamed(
                                                AppRoutes.facilityRoute);
                                          }
                                          controller.password.clear();
                                        });
                                      }
                                    });
                                  }
                                },
                                textButton: TranslationKeys.login.tr))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    ));
  }
}
