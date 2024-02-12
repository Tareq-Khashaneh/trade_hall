import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../controllers/facility/facility_confirm_form_controller.dart';
import '../../core/constants/error.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';
import '../widgets/bottom_nav_bar_container.dart';
import '../widgets/custom_field.dart';

class FacilityConfirmFormScreen extends GetView<FacilityConfirmFormController> {
  const FacilityConfirmFormScreen({super.key});
  final double height = 40;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(TranslationKeys.sendQuantity.tr),
        ),
        bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: GetBuilder<FacilityConfirmFormController>(
              builder: (_) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavBarContainer(
                      text: TranslationKeys.sendQuantity.tr,
                      fontSize: Get.size.height * 0.03,
                      width: Get.size.width * 0.4,
                      color: controller.isLoading
                          ? AppColors.kColorGreyDark
                          : null,
                      onTap: !controller.isLoading
                          ? () async {
                              if (controller.formKey.currentState!.validate()) {
                                if (controller.quantity.text ==
                                    controller.confirmSentQuantity.text) {
                                  // if (controller.isMasterCardEnable()) {
                                  controller.readMasterCard().then((value) {
                                    if (value) {
                                      showDialogue(
                                        title:
                                            TranslationKeys.confirmQuantity.tr,
                                        desc:
                                            "${TranslationKeys.orderNum.tr} ${controller.orderNum.text} \n ${TranslationKeys.sentQuantity.tr} ${controller.quantity.text}",
                                        dialogType: DialogType.info,
                                        context: context,
                                        onPressYes: () {
                                          controller
                                              .sendConfirmQuantityMasterCard()
                                              .then((value) =>
                                                  value ? Get.back() : null);
                                        },
                                      );
                                    }
                                  });
                                  // } else {
                                  //   controller.showDialogue(
                                  //       context: context,
                                  //       onPressYes: () {
                                  //         controller
                                  //             .sendConfirmQuantity()
                                  //             .then((value) => value
                                  //                 ? Get.back()
                                  //                 : null);
                                  //       });
                                  // }
                                }
                              }
                            }
                          : null,
                      height: Get.size.height * 0.1,
                    ),
                    BottomNavBarContainer(
                      text: TranslationKeys.cancel.tr,
                      fontColor: !controller.isLoading
                          ? AppColors.kBlack
                          : AppColors.kWhiteColor,
                      fontSize: Get.size.height * 0.03,
                      width: Get.size.width * 0.4,
                      onTap: () {
                          showDialogue(
                              title: TranslationKeys.cancel.tr,
                              desc: TranslationKeys.doYouWantToCancelProcess.tr,
                              dialogType: DialogType.info,
                              context: context,
                              onPressYes: () {
                                // if(controller.isMasterCardEnable()) {
                                  controller.stopRead();
                                // }
                                Get.back();
                              });
                      },
                      height: Get.size.height * 0.1,
                      color: !controller.isLoading
                          ? AppColors.kColorGreyDark
                          : null,
                    ),
                  ],
                );
              },
            )),
        body: Padding(
          padding: const EdgeInsets.only(top: 60.0, left: 15.0, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                GetBuilder<FacilityConfirmFormController>(builder: (_) {
                  return _.isLoading
                      ? Padding(
                          padding: const EdgeInsets.only(top: 50.0),
                          child: Center(
                              child: Lottie.asset(
                                  'assets/animations/card_scan.json',
                                  width: 500,
                                  fit: BoxFit.cover)),
                        )
                      : Form(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              Text(
                                "${controller.product!.nameAr}",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineSmall!
                                    .copyWith(color: AppColors.kBlack),
                              ),
                              SizedBox(
                                height: height,
                              ),
                              SizedBox(
                                  child: CustomField(
                                      controller: controller.orderNum,
                                      label: "رقم الطلب",
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                          RegExp(r'[,.-]'),
                                        ),
                                      ],
                                      validator: (value) =>
                                          controller.validate(value))),
                              SizedBox(
                                height: height,
                              ),
                              SizedBox(
                                  child: CustomField(
                                      controller: controller.quantity,
                                      label: TranslationKeys.sentQuantity.tr,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'[,.-]')),
                                      ],
                                      validator: (value) =>
                                          controller.validate(value))),
                              SizedBox(
                                height: height,
                              ),
                              SizedBox(
                                  child: CustomField(
                                      controller:
                                          controller.confirmSentQuantity,
                                      label: TranslationKeys.confirmQuantity.tr,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.deny(
                                            RegExp(r'[,.-]')),
                                      ],
                                      validator: (value) {
                                        if (value != null) {
                                          if (value.isNotEmpty) {
                                            int val = int.parse(value);
                                            if (val == 0) {
                                              return "value is zero";
                                            } else if (value !=
                                                controller.quantity.text) {
                                              return "Confirm quantity Not match with quantity";
                                            }
                                          } else if (value.isEmpty) {
                                            return "value is Empty";
                                          }
                                        }
                                        return null;
                                      })),
                              SizedBox(
                                height: height,
                              ),
                            ],
                          ),
                        );
                }),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
