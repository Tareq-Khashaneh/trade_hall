import 'dart:convert';
import '../../core/constants/api_endpoint.dart';
import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';
import '../../networking/api_service.dart';

class AuthRepo {
  final ApiService _apiService ;

  AuthRepo({required ApiService apiService}) : _apiService = apiService;
  Future<Map<String, dynamic>?> getAuthData(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.login, params);
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
      print("error in AuthRepo  $e");
      return null;
    }
  }

  Future<parameters?> getLogoutData(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.logout, params);
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
      print("error in logout Repo $e");
      return null;
    }
  }
}
