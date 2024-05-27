import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/basket_quota/basket_quota_controller.dart';
import 'package:trade_hall/controllers/cart/cart_controller.dart';
import 'package:trade_hall/core/theme/app_colors.dart';

import 'package:trade_hall/data/models/basket_quota_product_model.dart';
import 'package:trade_hall/view/widgets/product_card.dart';
import 'package:trade_hall/view/widgets/title_widget.dart';
import 'package:get/get.dart';
import '../../core/constants/error.dart';
import '../../core/constants/routes.dart';
import '../../core/localization/translation_keys.dart';
import '../widgets/bottom_nav_bar_container.dart';
import '../widgets/image_container.dart';

class CartScreen extends GetView<CartController> {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: AppColors.kmainColor,
          floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
          floatingActionButton: FloatingActionButton(
            onPressed: () => Get.back(),
            backgroundColor: AppColors.kmainColor,
            child: Icon(
              Icons.add,
              color: AppColors.kWhiteColor,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: AppColors.kWhiteColor,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BottomNavBarContainer(
                    fontSize: Get.size.height * 0.035,
                    width: Get.size.width * 0.4,
                    text: TranslationKeys.checkout.tr,
                    onTap: () {
                      showDialogue(
                        context: context,
                        dialogType: DialogType.infoReverse,
                        title: TranslationKeys.checkout.tr,
                        desc: TranslationKeys.areYouSure.tr,
                        onPressYes: () {
                          controller.payment();
                          showDialogue(
                            dialogType: DialogType.infoReverse,
                            context: context,
                            title: TranslationKeys.print.tr,
                            desc: TranslationKeys.doYouWantToPrint.tr,
                            onPressYes: () async {
                              await controller.printInvoice();
                              Get.offAllNamed(AppRoutes.homeScreenRoute);
                            },
                            onPressNo: () =>
                                Get.offAllNamed(AppRoutes.homeScreenRoute),
                          );
                        },
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 25.0, right: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(" ${TranslationKeys.totalPrice.tr}",
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold)),
                      GetBuilder<CartController>(builder: (_) {
                        return Text(
                          '${controller.totalPrice.toStringAsFixed(0)} ${TranslationKeys.syp.tr}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                        );
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
          body: Stack(
            children: [
              ImageContainer(
                img: "assets/images/background.png",
                isCurve: false,
                opacity: 0.37,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 22.0),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(
                    TranslationKeys.cart.tr,
                    style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                        color: AppColors.kWhiteColor,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: Get.size.height * 0.13,
                  ),
                  Stack(
                    children: [
                      Container(
                        height: Get.size.height * 0.8,
                        decoration: BoxDecoration(
                            color: AppColors.kColorGreyDark,
                            border: Border.all(color: Colors.white),
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40)),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 2,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ]),
                      ),
                      Positioned(
                        top: 5,
                        right: 0,
                        left: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 5, left: 15, right: 15),
                          child: SizedBox(
                              height: Get.size.height * 0.7,
                              child: GetBuilder<CartController>(
                                  builder: (controller) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 1,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          right: 15, left: 15),
                                      child: Column(
                                        children: [
                                          TitleWidget(
                                            title: TranslationKeys.items.tr,
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Expanded(
                                      child: ListView.builder(
                                          itemCount:
                                              controller.cartProducts.length,
                                          itemBuilder: (context, index) {
                                            BasketQuotaProductModel product =
                                                controller.cartProducts[index];
                                            String item = product.nameAr!;
                                            return Dismissible(
                                              key: Key(item),
                                              direction: controller.isEnglish
                                                  ? DismissDirection
                                                      .endToStart // Left-to-right language
                                                  : DismissDirection.startToEnd,
                                              onDismissed: (direction) {
                                                basketc
                                                    .isCartListChanged(product);
                                                controller.removeProduct(
                                                  context,
                                                  index,
                                                  item,
                                                );
                                                controller.cartProducts.isEmpty
                                                    ? Get.back()
                                                    : controller
                                                        .calculateTotalPrice();
                                              },
                                              background: Container(
                                                color: Colors.red,
                                                child: const Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Icon(Icons.delete,
                                                        color: Colors.white),
                                                  ],
                                                ),
                                              ),
                                              child: InkWell(
                                                onTap: () {
                                                  controller.showBottomSheet(
                                                      context, product);
                                                },
                                                child: ProductCard(
                                                  product: product,
                                                ),
                                              ),
                                            );
                                          }),
                                    ),
                                  ],
                                );
                              })),
                        ),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

final BasketQuotaController basketc = Get.find();
