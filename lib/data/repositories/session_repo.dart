
import 'dart:convert';

import '../../core/constants/api_endpoint.dart';
import '../../core/constants/typedef.dart';
import '../../networking/api_service.dart';

class SessionsRepository {
  final ApiService _apiService ;

  SessionsRepository({required ApiService apiService}) : _apiService = apiService;
  Future<List<dynamic>?> getAllSessions(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.sessionList, params);
      if (response != null) {
        Map<String, dynamic> data = jsonDecode(response.data);
        return data['data']['sessions'];
      } else {
        print("error in get SessionsRepository");
        return null;
      }
    } catch (e) {
      print("error in SessionsRepository  $e");
      return null;
    }
  }
  Future<parameters?> getSessionById(parameters params) async {
    try {
      dioRes? response = await _apiService.get(Api.sessionSales, params);
      if (response != null) {
        Map<String, dynamic> data = jsonDecode(response.data);
        return data['data'];
      } else {
        print("error in get SessionsRepository");
        return null;
      }
    } catch (e) {
      print("error in SessionsRepository  $e");
      return null;
    }
  }
}
