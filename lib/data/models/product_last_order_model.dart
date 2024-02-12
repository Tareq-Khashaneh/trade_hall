
import '../../core/constants/typedef.dart';

class ProductLastOrderModel {
  final String? productName;
  final int? order;
  final String? amount;

  ProductLastOrderModel(
      {required this.productName, required this.order, required this.amount});
  factory ProductLastOrderModel.fromJson(parameters json) =>
      ProductLastOrderModel(
          productName: json['product_name'],
          order: json['order'],
          amount: json['amount']);
}
