
import 'package:trade_hall/data/models/basket_quota_product_model.dart';
import 'package:trade_hall/data/repositories/products_repo.dart';

import '../../core/constants/typedef.dart';



class ProductsProvider {
  final ProductsRepository _productRepo ;

  ProductsProvider({required ProductsRepository productRepo}) : _productRepo = productRepo;

  Future<List<BasketQuotaProductModel>?> getBasketQuotaProducts(
      parameters params) async {
    try {
      List<BasketQuotaProductModel>? products;
      List<dynamic>? data = await _productRepo.getBasketQuotaProducts(params);
      List<BasketQuotaProductModel> temp = [];
      if (data != null) {
        for (var p in data) {
          temp.add(BasketQuotaProductModel.fromJson(p));
        }
        products = temp;
      }
      return products;
    } catch (e) {
      print("error in product provider $e");
      return null;
    }
  }
}
