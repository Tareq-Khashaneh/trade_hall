
import 'dart:convert';
import 'package:trade_hall/networking/api_service.dart';

import '../../core/constants/api_endpoint.dart';
import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';


class BasketRepository {
  final ApiService _apiService = ApiServiceDio();

  Future<parameters?> postBasketProducts(parameters params,String body)async{
    try {
      dioRes? response = await _apiService.post(Api.sellBasket,params,body);
      if (response != null) {
        var data = jsonDecode(response.data);
        if (data["err_code"] == '200' && data['err_msg'] == '') {
          return data['data'];
        } else {
          showSnackBar(data["err_msg"]);
          return null;
        }
      }
    } catch (e) {
      print("error in CartRepository  $e");
      return null;
    }
  }
  }