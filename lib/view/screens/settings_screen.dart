import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:trade_hall/core/constants/error.dart';
import 'package:trade_hall/core/constants/routes.dart';
import 'package:trade_hall/view/widgets/circular_loading.dart';
import 'package:trade_hall/view/widgets/custom_button.dart';
import 'package:trade_hall/view/widgets/custom_field.dart';
import 'package:trade_hall/view/widgets/custom_icon.dart';
import '../../controllers/settings/settings_controller.dart';
import '../../core/localization/translation_keys.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/app_bar_widget.dart';

class SettingsScreen extends GetView<SettingsController> {
  const SettingsScreen({super.key});
  final double height = 25;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.kWhiteColor,
          appBar: buildAppBar(
              title: TranslationKeys.setConnectivity.tr, context: context),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(22, 30,22,0),
            child: GetBuilder<SettingsController>(builder: (_) {
              return controller.isLoading
                  ? const CircularLoading()
                  : SingleChildScrollView(
                      child: Column(

                        children: [
                             DropdownButtonFormField(
                            decoration: InputDecoration(
                              label: Text(
                                TranslationKeys.connectionType.tr,
                              ),
                              suffixIcon:controller.selectedChoice != 'Wifi'? IconButton(onPressed: controller.openNetworkSettings, icon: const Icon(Icons.settings)): null,
                              labelStyle:
                                  TextStyle(color: AppColors.kmainColor),
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.kTextColor),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Get.size.height * 0.1))),
                              focusedBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: AppColors.kTextColor),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          Get.size.height * 0.1))),
                            ),
                            items: controller.connectionChoices
                                .map((e) => DropdownMenuItem(
                                      value: e,
                                      child: Text(e),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              if (value != null) {
                                controller.changeChoiceValue(value: value);
                                controller.clearFields();
                              }
                            },
                            value: controller.selectedChoice,
                          ),
                          SizedBox(
                            height: height,
                          ),
                          controller.selectedChoice == 'Wifi'
                              ? Form(
                                  key: controller.wifiFormKey,
                                  child: Column(
                                    children: [
                                      CustomField(
                                        controller: controller.ssid,
                                        label: TranslationKeys.ssid.tr,
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return TranslationKeys
                                                  .valueISEmpty.tr;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: height,
                                      ),
                                      CustomField(
                                        controller: controller.password,
                                        label: TranslationKeys.password.tr,
                                        isSecure: true,
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return TranslationKeys
                                                  .passwordisempty.tr;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: height,
                                      ),
                                      CustomField(
                                        controller:
                                            controller.serverIpController,
                                        keyboardType: TextInputType.number,
                                        label: TranslationKeys.serverIp.tr,
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return TranslationKeys
                                                  .valueISEmpty.tr;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                      SizedBox(
                                        height: height,
                                      ),
                                      CustomField(
                                        controller: controller.portController,
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [
                                          FilteringTextInputFormatter.deny(
                                              RegExp(r'[,.-]')),
                                        ],
                                        label: TranslationKeys.port.tr,
                                        validator: (value) {
                                          if (value != null) {
                                            if (value.isEmpty) {
                                              return TranslationKeys
                                                  .valueISEmpty.tr;
                                            }
                                          }
                                          return null;
                                        },
                                      ),
                                      CustomButton(
                                          onTap: () async {
                                            if (controller
                                                .wifiFormKey.currentState!
                                                .validate()) {
                                              controller
                                                  .connectToWifi()
                                                  .then((value) {
                                                if (value) {
                                                  controller
                                                      .checkConnectToServer()
                                                      .then((value) {
                                                    if (value) {
                                                      showSnackBar(
                                                          TranslationKeys
                                                              .connectionSuccess
                                                              .tr,
                                                          isFail: false);
                                                      Get.offAllNamed(AppRoutes
                                                          .authenticateRoute);
                                                    } else {
                                                      // showSnackBar(
                                                      //     "Server Ip or port is wrong");
                                                    }
                                                  });
                                                } else {
                                                  showSnackBar(TranslationKeys
                                                      .ssidOrPasswordIsWrong
                                                      .tr);
                                                }
                                              });
                                            }
                                          },
                                          textButton:
                                              TranslationKeys.connect.tr),
                                    ],
                                  ))
                              : !controller.isApnFound
                                  ? Form(
                                      key: controller.mobileDataFormKey,
                                      child: Column(
                                        children: [
                                          CustomField(
                                            controller:
                                                controller.nameController,
                                            label: TranslationKeys.name.tr,
                                            validator: (value) {
                                              if (value != null) {
                                                if (value.isEmpty) {
                                                  return TranslationKeys
                                                      .valueISEmpty.tr;
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: height,
                                          ),
                                          CustomField(
                                            controller:
                                                controller.apnController,
                                            label: "apn",
                                            validator: (value) {
                                              if (value != null) {
                                                if (value.isEmpty) {
                                                  return TranslationKeys
                                                      .valueISEmpty.tr;
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: height,
                                          ),
                                          CustomField(
                                            controller:
                                                controller.apnIPController,
                                            label: "apnIP",
                                            keyboardType:
                                                TextInputType.number,
                                            validator: (value) {
                                              if (value != null) {
                                                if (value.isEmpty) {
                                                  return TranslationKeys
                                                      .valueISEmpty.tr;
                                                } else if (!value.isIPv4 ||
                                                    !value.isIPv4) {
                                                  return "IP is wrong";
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: height,
                                          ),
                                          CustomField(
                                            controller:
                                                controller.apnPortController,
                                            label: "apnPort",
                                            keyboardType:
                                                TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .deny(RegExp(r'[,.-]')),
                                            ],
                                            validator: (value) {
                                              if (value != null) {
                                                if (value.isEmpty) {
                                                  return TranslationKeys
                                                      .valueISEmpty.tr;
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                          CustomButton(
                                              onTap: () async {
                                                if (controller
                                                    .mobileDataFormKey
                                                    .currentState!
                                                    .validate()) {
                                                  controller
                                                      .enableMobileData()
                                                      .then((value) async {
                                                    if (value) {
                                                      await controller
                                                          .createApn()
                                                          .then(
                                                              (value) async {
                                                        if (value) {
                                                          if (await controller
                                                              .isApnInList()) {
                                                            showDialogue(
                                                                title:
                                                                    "Apn was Created",
                                                                desc:
                                                                    "Please Enter Server credential",
                                                                dialogType:
                                                                    DialogType
                                                                        .info,
                                                                context:
                                                                    context,
                                                                onPressYes:
                                                                    () {},
                                                                dismissOnTouchOutside:
                                                                    false);
                                                          }
                                                        }
                                                      });
                                                    } else {
                                                      showSnackBar(TranslationKeys
                                                          .canNotEnableMobileData
                                                          .tr);
                                                    }
                                                  });
                                                }
                                              },
                                              textButton:
                                                  TranslationKeys.connect.tr),
                                        ],
                                      ))
                                  : // Server Form
                                  Form(
                                      key: controller.serverFormKey,
                                      child: Column(
                                        children: [

                                          CustomField(
                                            controller:
                                                controller.serverIpController,
                                            label:
                                                TranslationKeys.serverIp.tr,
                                            keyboardType:
                                                TextInputType.number,
                                            validator: (value) {
                                              if (value != null) {
                                                if (value.isEmpty) {
                                                  return TranslationKeys
                                                      .valueISEmpty.tr;
                                                } else if (!value.isIPv4 ||
                                                    !value.isIPv4) {
                                                  return "IP is wrong";
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: height,
                                          ),
                                          CustomField(
                                            controller:
                                                controller.portController,
                                            label: TranslationKeys.port.tr,
                                            keyboardType:
                                                TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .deny(RegExp(r'[,.-]')),
                                            ],
                                            validator: (value) {
                                              if (value != null) {
                                                if (value.isEmpty) {
                                                  return TranslationKeys
                                                      .valueISEmpty.tr;
                                                }
                                              }
                                              return null;
                                            },
                                          ),
                                          SizedBox(
                                            height: height,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              CustomButton(
                                                  onTap: () async {
                                                    if (controller
                                                        .serverFormKey
                                                        .currentState!
                                                        .validate()) {
                                                      controller
                                                          .checkConnectToServer()
                                                          .then((value) {
                                                        if (value) {
                                                          Get.offAllNamed(AppRoutes
                                                              .authenticateRoute);
                                                          showSnackBar(
                                                              TranslationKeys
                                                                  .connectionSuccess
                                                                  .tr,
                                                              isFail: false);
                                                        }
                                                      });
                                                    }
                                                  },
                                                  textButton:
                                                      TranslationKeys.connect.tr),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                          //
                          // CustomButton(
                          //     onTap: controller.deleteApn,
                          //     textButton: "delete"),
                        ],
                      ),
                    );
            }),
          ),
        ),
      ),
    );
  }
}
