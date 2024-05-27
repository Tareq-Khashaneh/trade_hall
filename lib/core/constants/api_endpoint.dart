
import 'package:get/get.dart';

abstract class Api {
  static  String _baseUrl =
      "";
  static const String ping = '/ping-json';
  static const String print = '/print';
  static const String login = '/login';
  static const String loginFacility = '/login-facility';
  static const String logout = '/logout';
  static const String basketQuota = '/get-basket-quota';
  static const String sellBasket = '/sell-basket';
  static const String facilityInfo = '/get-facility-sales';
  static const String confirmQuantity = '/confirm-quantity';
  static const String confirmQuantityMasterCard = '/confirm-quantity-with-rfid';
  static const String sessionList = '/get-session-list';
  static const String sessionSales = '/get-sales-forsession';

  static setBaseUrl({required String ip ,required String port})
  =>    _baseUrl =  "http://$ip:$port/proffer/web/POS/tradeHall/v1.1.0/dev-api";
  static String get baseUrl
  =>  _baseUrl;
}
