import 'package:trade_hall/data/models/cart_data.dart';


import '../../core/constants/typedef.dart';
import '../repositories/basket_repo.dart';

class BasketProvider {
  final BasketRepository _basketRepo = BasketRepository();

  Future<CartDataModel?> postBasketProducts(
      parameters params, String body) async {
    try {
      Map<String, dynamic>? data =
          await _basketRepo.postBasketProducts(params, body);
      if (data != null) {
        return CartDataModel.fromJson(data);
      } else {
        return null;
      }
    } catch (e) {
      print("error in BasketProvider  $e");
      return null;
    }
  }
}
