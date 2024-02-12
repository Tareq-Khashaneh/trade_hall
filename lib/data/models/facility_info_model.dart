
import 'package:trade_hall/data/models/product_last_order_model.dart';
import 'package:trade_hall/data/models/sale_facility_model.dart';

import '../../core/constants/typedef.dart';
import 'current_product_balance_model.dart';

class FacilityInfoModel {
  final List<CurrentProductBalance> currentProductsBalance;
  final List<ProductLastOrderModel> productLastOrders;
  final List<SaleFacilityModel> sales;

  FacilityInfoModel(
      {required this.currentProductsBalance,
      required this.productLastOrders,
      required this.sales});
  factory FacilityInfoModel.fromJson(parameters json) =>
      FacilityInfoModel(currentProductsBalance: [
        for (var c in json['current_product_balance'])
          CurrentProductBalance.fromJson(c)
      ], productLastOrders: [
        for (var c in json['product_last_orders'])
          ProductLastOrderModel.fromJson(c)
      ], sales: [
        for (var c in json['sales']) SaleFacilityModel.fromJson(c)
      ]);
}
