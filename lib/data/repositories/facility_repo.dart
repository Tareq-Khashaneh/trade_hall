

import 'dart:convert';

import 'package:trade_hall/networking/api_service.dart';

import '../../core/constants/api_endpoint.dart';
import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';


class FacilityRepository{
  final ApiService _apiService ;

  FacilityRepository({required ApiService apiService}) : _apiService = apiService;
  Future<parameters?> getInfo(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.facilityInfo, params);
      if (response != null) {
        var data = jsonDecode(response.data);
        if (data["err_code"] == '200' && data['err_msg'] == '') {
          return data['data'];
        } else {
          showSnackBar(data["err_msg"]);
        }
      }
      return null;
    } catch (e) {
      print("error in FacilityRepo  $e");
      return null;
    }
  }
  Future<parameters?> getLogin(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.loginFacility, params);
      if (response != null) {
        var data = jsonDecode(response.data);
        if (data["err_code"] == '200' && data['err_msg'] == '') {
          return data;
        } else {
          showSnackBar(data["err_msg"]);

        }
      }
      return null;
    } catch (e) {
      print("error in FacilityRepo  $e");
      return null;
    }
  }
  Future<parameters?> confirmQuantity({required parameters params})async{
    try {
      dioRes? response = await _apiService.get(Api.confirmQuantity, params);
      if (response != null) {
        var data = jsonDecode(response.data);
        if (data["err_code"] == '200' && data['err_msg'] == '') {
          return data;
        } else {
          showSnackBar(data["err_msg"]);

        }
      }
      return null;
    } catch (e) {
      print("error in FacilityRepo confirmQuantity $e");
      return null;
    }
  }
  Future<parameters?> confirmQuantityMasterCard({required parameters params})async{
    try {
      dioRes? response = await _apiService.get(Api.confirmQuantityMasterCard, params);
      if (response != null) {
        var data = jsonDecode(response.data);
        if (data["err_code"] == '200' && data['err_msg'] == '') {
          return data;
        } else {
          showSnackBar(data["err_msg"]);

        }
      }
      return null;
    } catch (e) {
      print("error in FacilityRepo confirmQuantityMasterCard $e");
      return null;
    }
  }
}