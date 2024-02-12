import 'package:trade_hall/data/models/cart_product.dart';

import '../../core/constants/typedef.dart';

class CartDataModel {
  final String? cardSellId;
  final String? sellDate;
  final List<CartProductModel> cartProducts;
  final String? cardId;
  final String? plateNumber;
  final String? totalPrice;
  CartDataModel({
    required this.cardSellId,
    required this.sellDate,
    required this.cardId,
    required this.plateNumber,
    required this.totalPrice,
    required this.cartProducts,
  });

  factory CartDataModel.fromJson(parameters json) => CartDataModel(
      cardSellId: json['card_sell_id'],
      sellDate: json['sell_data'],
      cartProducts: [
        for (parameters cartProduct in json['details'])
          CartProductModel.fromJson(cartProduct)
      ],
      cardId: json['card_id'],
      plateNumber: json['plate_number'],
      totalPrice: json['total_price']);
}
