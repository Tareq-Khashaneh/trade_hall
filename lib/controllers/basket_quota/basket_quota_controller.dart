import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hall/controllers/home/home_controller.dart';
import 'package:trade_hall/data/models/basket_quota_product_model.dart';
import 'package:trade_hall/data/providers/products_pro.dart';
import 'package:trade_hall/data/repositories/products_repo.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';
import '../../core/constants/typedef.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';
import '../../view/widgets/bottom_nav_bar_container.dart';
import '../../view/widgets/custom_field.dart';
import '../cart/cart_controller.dart';

class BasketQuotaController extends GetxController {
  @override
  void onInit() {
    cardId = _homeController.cardId;
    userId = _homeController.currentUser!.id;
    isAdded = false;
    _productsProvider = ProductsProvider(productRepo: ProductsRepository(apiService: appService.apiService));
    fetchProducts();
    super.onInit();
  }

  fetchProducts() {
    isLoading = true;
    _fetchProducts();
  }

  void _fetchProducts() async {
    try {
      if (cardId != null && userId != null) {
        parameters params = {
          'user_id': userId!,
          'card_sn': cardId,
        };
        params.addAll(appService.params);
        List<BasketQuotaProductModel>? temp;
        temp = await _productsProvider.getBasketQuotaProducts(params);
        temp != null ? products = temp : products = [];
      }
    } catch (e) {
      print("error is $e");
    }
    isLoading = false;
    update();
  }

  void addProduct(BasketQuotaProductModel product) {
    isAdded = false;
    isLoading = true;
    cartController.cartProducts.add(product);
    isAdded = true;
    isLoading = false;
  }

  void isCartListChanged(BasketQuotaProductModel product) {
    isLoading = true;
    products
        .firstWhere((element) => element == product)
        .quantityController
        .clear();
    isLoading = false;

  }

  bool addProductsToCart() =>
      cartController.cartProducts.isNotEmpty ? true : false;

  void showBottomSheet(
    BuildContext context,
    BasketQuotaProductModel product,
  ) =>
      Get.bottomSheet(
        Container(
          width: double.infinity,
          height: Get.size.height * 0.5,
          padding: const EdgeInsets.only(left: 5, right: 25, bottom: 25),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 1,
                ),
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: Get.size.width * 0.1,
                    height: 8,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE0E0E0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${product.nameAr} | ",
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: AppColors.kBlack),
                    ),
                    Text("${product.price} ${TranslationKeys.syp.tr}",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              color: AppColors.kBlack,
                            )),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                        flex: 2,
                        child: CustomField(
                          controller: product.quantityController,
                          label: TranslationKeys.quantity.tr,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(
                              RegExp(r'[,.-]'),
                            ),
                          ],
                          validator: (value) {
                            if (value != null) {
                              if (value.isNotEmpty) {
                                int val = int.parse(value);
                                if (val == 0) {
                                  return "value is zero";
                                } else if (val > product.maxQuantity!) {
                                  return 'The value is bigger than quota';
                                }
                                return null;
                              } else if (value.isEmpty) {
                                return "Translation.valueISEmpty.tr";
                              }
                            }
                          },
                        )),
                    Expanded(
                      child: Text(' | ${product.maxQuantity} ${product.unit}',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(
                                  color: AppColors.kBlack,
                                  fontWeight: FontWeight.normal)),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BottomNavBarContainer(
                      text: TranslationKeys.addToCart.tr,
                      fontSize: Get.size.height * 0.03,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          addProduct(product);
                          cartController.calculateTotalPrice();
                          Get.back();
                        }
                      },
                      width: Get.size.width * 0.4,
                      height: Get.size.height * 0.1,
                    ),
                    BottomNavBarContainer(
                      text: TranslationKeys.cancel.tr,
                      fontSize: Get.size.height * 0.03,
                      onTap: () {
                        product.quantityController.clear();
                        Get.back();
                      },
                      width: Get.size.width * 0.4,
                      height: Get.size.height * 0.1,
                      color: AppColors.kColorGrey,
                      fontColor: AppColors.kBlack,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        backgroundColor: AppColors.kWhiteColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        ),
        isScrollControlled: true,
      ).whenComplete(() {
        isLoading = true;
        print("added $isAdded");
        !isAdded ? product.quantityController.clear() : null;
        isLoading = false;
        isAdded = false;
      });
  void dispose() {
    for (BasketQuotaProductModel p in products) {
      p.quantityController.dispose();
    }
    super.dispose();
  }

  //variables

  final _formKey = GlobalKey<FormState>();
  final AppService appService = Get.find();
  final HomeController _homeController = Get.find();
  late bool isAdded;
  final CartController cartController = Get.find();
  final RxList<BasketQuotaProductModel> _products = RxList([]);
  final RxBool _isLoading = RxBool(true);
  late ProductsProvider _productsProvider ;
  final MethodChannel platform =
      const MethodChannel('samples.flutter.dev/read');
  Rx<String>? _cardId;
  RxInt? _userId;
  //setters
  set isLoading(bool isLoading) => _isLoading.value = isLoading;
  set products(List<BasketQuotaProductModel> products) =>
      _products.value = products.obs;
  set cardId(String? cardId) => _cardId = cardId?.obs;
  set userId(int? userId) => _userId = userId?.obs;
  //getters
  bool get isLoading => _isLoading.value;
  String? get cardId => _cardId?.value;
  int? get userId => _userId?.value;
  List<BasketQuotaProductModel> get products => _products;
}
