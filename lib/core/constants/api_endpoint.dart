
class Api {
  static const String mainUrl =
      "http://192.168.0.103:7000/proffer/web/POS/tradeHall/v1.1.0/dev-api";
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
}
