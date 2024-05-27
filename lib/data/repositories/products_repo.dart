import 'dart:convert';
import '../../core/constants/api_endpoint.dart';
import '../../core/constants/typedef.dart';
import '../../networking/api_service.dart';

class ProductsRepository {
  final ApiService _apiService ;

  ProductsRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<dynamic>?> getBasketQuotaProducts(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.basketQuota, params);
      if (response != null) {
        Map<String, dynamic> data = jsonDecode(response.data);
        return data['data']['products'];
      } else {
        print("error in get product repository");
        return null;
      }
    } catch (e) {
      print("error in product repository  $e");
      return null;
    }
  }
}
