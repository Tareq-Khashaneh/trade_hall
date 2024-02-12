
import '../../core/constants/typedef.dart';

class CartProductModel {
  final String? shortcut;
  final String? shortcutAr;
  final String? remaining;
  final String? sellInfo;
  final String? invoiceNumber;

  CartProductModel(
      {required this.shortcut,
      required this.shortcutAr,
      required this.remaining,
      required this.sellInfo,
      required this.invoiceNumber});

  factory CartProductModel.fromJson(parameters json) => CartProductModel(
      shortcut: json['shortcut'],
      shortcutAr: json['shortcut_ar'],
      remaining: json['remaining'],
      sellInfo: json['sell_info'],
      invoiceNumber: json['invoice_number']);
}
