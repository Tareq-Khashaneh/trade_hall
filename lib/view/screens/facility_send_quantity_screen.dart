import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/facility/facility_controller.dart';

import 'package:trade_hall/data/models/product_model.dart';
import 'package:trade_hall/view/widgets/drawer_widget.dart';
import 'package:trade_hall/view/widgets/title_widget.dart';
import 'package:get/get.dart';
import '../../core/constants/routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';

class FacilitySendQuantityScreen extends GetView<FacilityController> {
  const FacilitySendQuantityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(
        title: Text(TranslationKeys.sendQuantity.tr),
      ),
      body: Padding(
          padding: const EdgeInsets.only(top: 1, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TitleWidget(title: TranslationKeys.products.tr),
              SizedBox(
                height: Get.size.height * 0.7,
                child: GridView.builder(
                  itemCount: controller.appService.dataDetails!.products.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // Number of columns
                    mainAxisSpacing: 15.0, // Spacing between rows
                    crossAxisSpacing: 10.0, // Spacing between columns
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    ProductModel product =
                        controller.appService.dataDetails!.products[index];
                    return InkWell(
                      onTap: () => Get.toNamed(
                          AppRoutes.facilityConfirmFormRoute,
                          arguments: product),
                      child: Stack(
                        children: [
                          SizedBox(
                            width: 200,
                            height: 160,
                            child: Card(
                              elevation: 4,
                              color: AppColors.kWhiteColor,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12)),
                              ),
                            ),
                          ),
                          Positioned.fill(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(product.nameAr ?? '',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                              color: AppColors.kBlack,
                                              fontWeight: FontWeight.bold)),
                                  Text(
                                      '${TranslationKeys.amount.tr}: ${product.amount} ${product.unit}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: AppColors.kBlack,
                                              fontWeight: FontWeight.normal)),
                                  Text(
                                      '${TranslationKeys.quota.tr}: ${product.quota} ${product.unit}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .copyWith(
                                              color: AppColors.kBlack,
                                              fontWeight: FontWeight.normal)),
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
            ],
          )),
    ));
  }
}
