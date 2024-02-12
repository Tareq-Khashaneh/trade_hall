import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/facility/facility_controller.dart';
import 'package:trade_hall/core/theme/app_colors.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';
import 'package:trade_hall/view/widgets/drawer_widget.dart';
import 'package:get/get.dart';

class FacilityInfoScreen extends GetView<FacilityController> {
  const FacilityInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          drawer: const DrawerWidget(),
          appBar: AppBar(
            title: Text(
              TranslationKeys.facilityInfo.tr,
              style: const TextStyle(color: Colors.white),
            ),
            bottom: TabBar(
              isScrollable: false,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: Colors.white,
              unselectedLabelColor: Colors.grey,
              // indicatorColor: C,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.chat_bubble,
                    color: AppColors.kWhiteColor,
                  ),
                  text: TranslationKeys.quantities.tr,
                ),
                Tab(
                  icon: Icon(Icons.video_call),
                  text: TranslationKeys.orders.tr,
                ),
                Tab(
                  icon: Icon(Icons.settings),
                  text: TranslationKeys.sales.tr,
                )
              ],
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 1.5),
            child: TabBarView(
                children: [
                  controller.buildDataTable([TranslationKeys.productName.tr,
                    TranslationKeys.activeQuota.tr],
                      controller.facilityInfo!.currentProductsBalance),

             controller.buildDataTable([
             TranslationKeys.productName.tr,
             TranslationKeys.orderNum.tr,
             TranslationKeys.amount.tr,
                          ], controller.facilityInfo!.productLastOrders),
              controller.buildDataTable([
                TranslationKeys.productName.tr,
                TranslationKeys.quantity.tr,
              ], controller.facilityInfo!.sales),
            ]),
          ),
        ));
  }
}
