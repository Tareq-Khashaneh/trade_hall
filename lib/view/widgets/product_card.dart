import 'package:flutter/material.dart';
import 'package:trade_hall/data/models/basket_quota_product_model.dart';
import 'package:get/get.dart';
import 'package:get/get.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {super.key,
      required this.product,});
  final BasketQuotaProductModel product;

  @override
  Widget build(BuildContext context) {
    late double allPrice;
    allPrice = int.parse(product.quantityController.text) * product.price!;
    return Container(
      width: Get.size.width * 0.9,
      height: Get.size.height * 0.15,
      padding: const EdgeInsets.only(top: 8, bottom: 8, right: 5, left: 15),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
          color: AppColors.kWhiteColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
            blurRadius: 1,
          offset: const Offset(0,4)
        ),
        const BoxShadow(
            color: Colors.white,

            offset: Offset(1,1)
        ),
        const BoxShadow(
            color: Colors.white,

            offset: Offset(-1,1)
        )
      ]
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.shopping_bag_rounded,
            size: 40,
            color: AppColors.kmainColorLowOpacity,
          ),
          SizedBox(
            width: Get.size.width * 0.03,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(product.nameAr ?? '',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: AppColors.kBlack, fontWeight: FontWeight.bold)),
              Text('${TranslationKeys.price.tr}: ${product.price!.toStringAsFixed(0)}',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kBlack, fontWeight: FontWeight.normal)),
            ],
          ),
          const Spacer(),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
              '${product.quantityController.text} ${product.unit}',
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.kBlack, fontWeight: FontWeight.normal)),
              Text("${allPrice.toStringAsFixed(0)} ${TranslationKeys.syp.tr}",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: AppColors.kBlack, fontWeight: FontWeight.normal)),
            ],
          )
        ],
      ),
    );
  }
}
