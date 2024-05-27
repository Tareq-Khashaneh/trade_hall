import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hall/controllers/auth/authenticate_controller.dart';
import 'package:trade_hall/controllers/home/home_controller.dart';
import 'package:trade_hall/data/models/cart_data.dart';
import 'package:trade_hall/data/providers/basket_pro.dart';
import 'package:trade_hall/data/repositories/basket_repo.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:trade_hall/networking/api_service.dart';
import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';
import '../../core/theme/app_colors.dart';
import '../../core/localization/translation_keys.dart';
import '../../data/models/basket_quota_product_model.dart';
import '../../data/repositories/init_repo.dart';
import '../../view/widgets/bottom_nav_bar_container.dart';

class CartController extends GetxController {
  @override
  void onInit() {
    cartProducts = [];
    quantityValue = '';
    printData = '';
    totalPrice = 0.0;
    isEnglish = appService.storage.read("lang") == 'en' ? true : false;
    _basketProvider = BasketProvider(basketRepo: BasketRepository(apiService: appService.apiService));
    _initRepo = InitRepository(apiService: appService.apiService);
    super.onInit();
  }

  @override
  void dispose() {
    for (BasketQuotaProductModel p in cartProducts) {
      p.quantityController.dispose();
    }
    super.dispose();
  }

  void calculateTotalPrice() {
    totalPrice = 0.0;
    for (BasketQuotaProductModel p in cartProducts) {
      totalPrice += p.price! * double.parse(p.quantityController.text);
    }
    print("total $totalPrice");
    update();
  }

  void removeProduct(BuildContext context, int index, String item) {
    cartProducts.removeAt(index);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Deleted $item'),
      ),
    );
    update();
  }

  void showBottomSheet(
    BuildContext context,
    BasketQuotaProductModel product,
  ) =>
      Get.bottomSheet(
        Container(
          width: double.infinity,
          height: Get.size.height * 0.5,
          padding: const EdgeInsets.only(left: 5, right: 25, bottom: 25),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              color: AppColors.kWhiteColor),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                      child: TextFormField(
                        controller: product.quantityController..text,
                        keyboardType: TextInputType.number,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r'[,.-]')),
                        ],
                        decoration: InputDecoration(
                          label: Text(TranslationKeys.quantity.tr),
                          labelStyle: TextStyle(color: AppColors.kmainColor),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.kTextColor),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Get.size.height * 0.015))),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: AppColors.kTextColor),
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Get.size.height * 0.015))),
                        ),
                        onChanged: (value) {
                          if (_formKey.currentState!.validate()) {
                            quantityValue = value;
                          }
                        },
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
                      ),
                    ),
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
                      fontSize: 14,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          product.quantityController.text = quantityValue;
                          quantityValue = '';
                          calculateTotalPrice();
                          update();
                          Get.back();
                        }
                      },
                      width: Get.size.width * 0.4,
                      height: Get.size.height * 0.1,
                    ),
                    BottomNavBarContainer(
                      text: TranslationKeys.cancel.tr,
                      fontSize: 18,
                      onTap: () {
                        Get.back();
                        quantityValue = '';
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
        isScrollControlled: true,
      ).whenComplete(() => quantityValue = '');
  void payment() async {
    try {
      List ids = [];
      List quantities = [];

      String date = DateFormat('yyyy/MM/DD').format(DateTime.now());
      for (BasketQuotaProductModel b in cartProducts) {
        ids.add("${b.productId},");
        quantities.add("${b.quantityController.text},");
      }
      String body =
          "dev_sn=${appService.deviceSerialNum}&app_version=1.1.1&session_id=${authController.authModel!.sessionId}&card_sn=${homeController.cardId}"
          "&product_id=$ids&quantity=$quantities&counter=1&local_serial=$date";
      cartData =
          await _basketProvider.postBasketProducts(appService.params, body);
      if (cartData != null) {
        print("payment was applied $cartData");
      } else {
        print("cart data model is  $cartData");
      }
    } catch (e) {
      print("error in payment $e");
    }
  }

  Future<void> printInvoice() async {
    try {
      String sellerName = authController.currentUser!.userName;
      String date = DateFormat('yyyy/MM/DD').format(DateTime.now());
      String productsLine = _generateInvoiceItemsList();
      String invoiceTemplate = '''
=========================
${appService.dataDetails!.facilityName}${"".padRight(20)}
=========================
${TranslationKeys.date.tr}: $date
${TranslationKeys.seller.tr}: $sellerName
-------------------------
${TranslationKeys.products.tr.padRight(13)}${TranslationKeys.qty.tr.padRight(10)}${TranslationKeys.price.tr.padRight(10)}${TranslationKeys.total.tr}
$productsLine
-------------------------
${TranslationKeys.totalPrice.tr}: ${totalPrice.toStringAsFixed(0)}
=========================
${"".padRight(20)}${TranslationKeys.thanks.tr}
=========================
\n
\n
''';
      final int status = await appService.platformPrint.invokeMethod(
        'print',
        {
          'invoiceTemplate': invoiceTemplate,
          'isEnglish': isEnglish,
        },
      );
      parameters params = {
        'user_id': authController.currentUser!.id,
        'card_sn': homeController.cardId,
        'print' : status == 0 ? 1 : 0,
        'transid': authController.authModel!.sessionId
      };
      params.addAll(appService.params);
    parameters? data = await _initRepo.printData(params);
    if(data == null)
      {
        throw("error in get print to server");
      }
       } catch (e) {
      showSnackBar(TranslationKeys.errorInPrint.tr);
      print('Error calling native method: $e');
    }
  }

  String _generateInvoiceItemsList() {
    String itemList = '';
    double priceProduct = 0;
    for (BasketQuotaProductModel b in cartProducts) {
      priceProduct = double.parse(b.quantityController.text) * b.price!;
      isEnglish
          ?
      itemList +=
              "${b.name!.padRight(16)}${b.quantityController.text.padRight(14)}${b.price!.toStringAsFixed(0).padRight(14)}${priceProduct.toStringAsFixed(0)}\n${"".padRight(7)}"
          :
    itemList +=
              "${b.nameAr!.padRight(17)}${b.quantityController.text.padRight(10)}${b.price!.toStringAsFixed(0).padRight(10)}${priceProduct.toStringAsFixed(0).padRight(15)}\n";
    }
    return itemList;
  }
  late InitRepository _initRepo;
  late bool isEnglish;
  CartDataModel? cartData;
  late String printData;
  final AuthenticateController authController = Get.find();
  late BasketProvider _basketProvider ;
  final _formKey = GlobalKey<FormState>();
  final AppService appService = Get.find();
  final HomeController homeController = Get.find();
  late String quantityValue;
  late double totalPrice;
  late List<BasketQuotaProductModel> cartProducts;
}
