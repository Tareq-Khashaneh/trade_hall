


import '../../core/constants/typedef.dart';

class CurrentProductBalance {
  final String? productName;
  final String? activeQuota;

  CurrentProductBalance({required this.productName, required this.activeQuota});
  factory CurrentProductBalance.fromJson(parameters json)
  => CurrentProductBalance(
      productName: json['product_name'],
      activeQuota: json['active_quota']);
}