import 'dart:convert';


import '../../core/constants/api_endpoint.dart';
import '../../core/constants/typedef.dart';
import '../../networking/api_service.dart';

class UserRepository {
  final ApiService _apiService = ApiServiceDio();

  Future<List<dynamic>?> getUsers(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.ping, params);
      if (response != null) {
        Map<String, dynamic> data = jsonDecode(response.data);
        return data['data']['users'];
      } else {
        print("error in getUsers");
        return null;
      }
    } catch (e) {
      print("error in users repository $e");
      return null;
    }
  }
}
