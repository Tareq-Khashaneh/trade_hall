import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/basket_quota/basket_quota_controller.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';
import 'package:trade_hall/data/models/basket_quota_product_model.dart';
import 'package:trade_hall/view/widgets/bottom_nav_bar_container.dart';
import 'package:trade_hall/view/widgets/circular_loading.dart';
import 'package:get/get.dart';
import '../../core/constants/error.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';

class BasketQuotaScreen extends GetView<BasketQuotaController> {
  const BasketQuotaScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: AppColors.kColorGrey,
        floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavBarContainer(
                    text: TranslationKeys.goToBasket.tr,
                    width: Get.size.width * 0.4,
                    height: Get.size.height * 0.1,
                    fontSize: Get.size.height * 0.03,
                    onTap: () => {
                          if (controller.addProductsToCart())
                            {Get.toNamed(AppRoutes.cartRoute)}
                          else
                            {showSnackBar(TranslationKeys.noItemsInCart.tr)}
                        }),
                BottomNavBarContainer(
                  text: TranslationKeys.cancel.tr,
                  fontSize: Get.size.height * 0.03,
                  fontColor:AppColors.kBlack,
                  width: Get.size.width * 0.4,
                  onTap: () {
                    showDialogue(
                        title: TranslationKeys.cancel.tr,
                        desc: TranslationKeys.doYouWantToCancelProcess.tr,
                        dialogType: DialogType.infoReverse,
                        context: context,
                        onPressYes: () {
                          Get.back();
                        });
                  },
                  color: AppColors.kColorGreyDark,
                ),
              ],
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Text(
              controller.appService.dataDetails!.facilityName ?? '',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    color: AppColors.kWhiteColor,
                  ),
            )),
        body: SafeArea(
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 25),
                child:
                    // GetBuilder<BasketQuotaController>(
                    //   builder: (controller) {
                    //   return  controller.isLoading
                    //         ? const CircularLoading()
                    //         :
                    //   controller.products == [] ? Text("products is empty"):
                    //   GridView.builder(
                    //       itemCount: controller.products.length,
                    //       gridDelegate:
                    //       const SliverGridDelegateWithFixedCrossAxisCount(
                    //         crossAxisCount: 2, // Number of columns
                    //         mainAxisSpacing: 20.0, // Spacing between rows
                    //         crossAxisSpacing: 15.0, // Spacing between columns
                    //       ),
                    //       itemBuilder: (BuildContext context, int index) {
                    //         BasketQuotaProductModel product =
                    //         controller.products[index];
                    //         return InkWell(
                    //           onTap: () =>
                    //               controller.showBottomSheet(context, product),
                    //           child: Stack(
                    //             children: [
                    //               Container(
                    //                 decoration: BoxDecoration(
                    //                   color: AppColors.kWhiteColor,
                    //                   borderRadius: const BorderRadius.all(
                    //                       Radius.circular(12)),
                    //                 ),
                    //               ),
                    //               Positioned.fill(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.symmetric(
                    //                       horizontal: 8),
                    //                   child: Column(
                    //                     mainAxisAlignment:
                    //                     MainAxisAlignment.spaceEvenly,
                    //                     crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                     mainAxisSize: MainAxisSize.min,
                    //                     children: [
                    //                       Text(product.nameAr ?? '',
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodyMedium!
                    //                               .copyWith(
                    //                               color: AppColors.kBlack,
                    //                               fontWeight:
                    //                               FontWeight.bold)),
                    //                       Text(
                    //                           '${TranslationKeys.price.tr}: ${product.price}',
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodySmall!
                    //                               .copyWith(
                    //                               color: AppColors.kBlack,
                    //                               fontWeight:
                    //                               FontWeight.normal)),
                    //                       // Text(
                    //                       //     'quota: ${product.quota} ${product.unit}',
                    //                       //     style: Theme.of(context)
                    //                       //         .textTheme
                    //                       //         .bodySmall!
                    //                       //         .copyWith(
                    //                       //             color: AppColors.kBlack,
                    //                       //             fontWeight:
                    //                       //                 FontWeight.normal)),
                    //                       Text(
                    //                           '${TranslationKeys.quota.tr}: ${product.maxQuantity} ${product.unit}',
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .bodySmall!
                    //                               .copyWith(
                    //                               color: AppColors.kBlack,
                    //                               fontWeight:
                    //                               FontWeight.normal)),
                    //                       Row(
                    //                         children: [
                    //                           Text(
                    //                               '${TranslationKeys.quantity.tr}: '),
                    //                           product.quantityController.text
                    //                               .isNotEmpty
                    //                               ? Text(
                    //                               '${product.quantityController.text} ${product.unit}',
                    //                               style: Theme.of(context)
                    //                                   .textTheme
                    //                                   .bodySmall!
                    //                                   .copyWith(
                    //                                   color: AppColors
                    //                                       .kBlack,
                    //                                   fontWeight:
                    //                                   FontWeight
                    //                                       .normal))
                    //                               : SizedBox()
                    //                         ],
                    //                       ),
                    //                     ],
                    //                   ),
                    //                 ),
                    //               ),
                    //               // Positioned(
                    //               //     bottom: 0,
                    //               //     right: 0,
                    //               //     child: Container(
                    //               //       width: Get.size.width * 0.14,
                    //               //       height: Get.size.height * 0.05,
                    //               //       decoration: BoxDecoration(
                    //               //           color: AppColors.kmainColor,
                    //               //           borderRadius: const BorderRadius.only(
                    //               //               topLeft: Radius.circular(12),
                    //               //               bottomRight: Radius.circular(12))),
                    //               //     )),
                    //               // Positioned(
                    //               //     bottom: -9,
                    //               //     right: 0,
                    //               //     child: IconButton(
                    //               //         onPressed: () => showBottomSheet(context),
                    //               //         icon: const Icon(
                    //               //           Icons.add_rounded,
                    //                         color: Colors.white,
                    //                       )))
                    //             ],
                    //           ),
                    //         );
                    //       },
                    //     );
                    //   },
                    // ),
                    Obx(
                  () => controller.isLoading && controller.products != []
                      ? const CircularLoading()
                      : SizedBox(
                          height: Get.size.height * 0.7,
                          child: GridView.builder(
                            itemCount: controller.products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // Number of columns
                              mainAxisSpacing: 15.0, // Spacing between rows
                              crossAxisSpacing: 15.0, // Spacing between columns
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              BasketQuotaProductModel product =
                                  controller.products[index];
                              return InkWell(
                                onTap: () =>
                                    product.quantityController.text.isEmpty
                                        ? controller.showBottomSheet(
                                            context, product)
                                        : null,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: product
                                                .quantityController.text.isEmpty
                                            ? AppColors.kWhiteColor
                                            : AppColors.kColorGreyDark,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(12)),
                                      ),
                                    ),
                                    Positioned.fill(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(product.nameAr ?? '',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: AppColors.kBlack,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                            Text(
                                                '${TranslationKeys.price.tr}: ${product.price}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: AppColors.kBlack,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                            Text(
                                                '${TranslationKeys.quota.tr}: ${product.maxQuantity} ${product.unit}',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall!
                                                    .copyWith(
                                                        color: AppColors.kBlack,
                                                        fontWeight:
                                                            FontWeight.normal)),
                                            Row(
                                              children: [
                                                Text(
                                                    '${TranslationKeys.quantity.tr}: '),
                                                product.quantityController.text
                                                        .isNotEmpty
                                                    ? Text(
                                                        '${product.quantityController.text} ${product.unit}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .kBlack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                                    : Text('0 ${product.unit}',
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodySmall!
                                                            .copyWith(
                                                                color: AppColors
                                                                    .kBlack,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .normal))
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ))),
      ),
    );
  }
}
