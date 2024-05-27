
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/auth/authenticate_controller.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_field.dart';
import '../widgets/custom_icon.dart';
import '../widgets/image_container.dart';

class AuthenticateScreen extends GetView<AuthenticateController> {
  const AuthenticateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(TranslationKeys.welcomeBack.tr,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .copyWith(
                                            fontSize: 30,
                                            color: AppColors.kmainColor,
                                            fontWeight: FontWeight.bold)),
                              Flexible(child: SizedBox(width: Get.width * 0.5,)),
                              Flexible(child: IconButton(onPressed: () => Get.toNamed(AppRoutes.languageRoute), icon: const Icon(Icons.language_outlined)))
                              ],
                            ),
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
                                Stack(
                                  children: [
                                    SizedBox(
                                      child: DropdownButtonFormField(
                                          decoration: InputDecoration(
                                            label: Text(
                                              TranslationKeys.userName.tr,
                                            ),
                                            labelStyle: TextStyle(
                                                color: AppColors.kmainColor),
                                            contentPadding: const EdgeInsets.only(
                                                left: 40,
                                                top: 5,
                                                bottom: 5,
                                                right: 10),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.kTextColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Get.size.height * 0.1))),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: AppColors.kTextColor),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(
                                                        Get.size.height * 0.1))),
                                          ),
                                          items: [
                                            ...controller.users.map((i) =>
                                                DropdownMenuItem(
                                                    value: i,
                                                    child: Text(i.userName)))
                                          ],
                                          onChanged: (value) {
                                            controller.currentUser = value;
                                          }),
                                    ),
                                    const Positioned(
                                        top: 1,
                                        left: 1,
                                        child: CustomIcon(
                                            icon: Icons.person_rounded))
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  EdgeInsets.only(top: Get.size.height * 0.02),
                              child: Stack(
                                children: [
                                  Form(
                                    key: controller.formKey,
                                    child: CustomField(
                                      controller: controller.password,
                                      contentPadding: const EdgeInsets.only(
                                          left: 40, top: 5, bottom: 5, right: 10),
                                      label: TranslationKeys.password.tr,
                                      isSecure: true,
                                      validator: (value) =>
                                          controller.validate(value),
                                    ),
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
                            CustomButton(
                                onTap: () async {
                                  if (controller.formKey.currentState!
                                      .validate()) {
                                    if (await controller.login()) {
                                      Get.offNamed(
                                        AppRoutes.homeScreenRoute,
                                      );
                                    }
                                  }

                                  controller.password.clear();
                                },
                                textButton: TranslationKeys.login.tr)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )),
    );
  }
}
