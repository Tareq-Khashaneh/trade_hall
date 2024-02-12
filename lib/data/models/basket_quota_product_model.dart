

import 'package:flutter/material.dart';

import '../../core/constants/typedef.dart';

class BasketQuotaProductModel {
  final String? name;
  final String? nameAr;
  final int? viewOrder;
  final int productId;
  final double? quota;
  final double? price;
  final double? maxQuantity;
  final String? unit;
  final int? amountPrecision;
  final List<dynamic> slices;
  late TextEditingController quantityController;
  late String quantity;
  BasketQuotaProductModel({required this.name, required this.nameAr, required this.viewOrder, required this.productId, required this.quota, required this.price, required this.maxQuantity, required this.unit, required this.amountPrecision, required this.slices})
  {
    quantityController = TextEditingController();
    quantity = quantityController.text;
  }

  factory BasketQuotaProductModel.fromJson(parameters json)
  => BasketQuotaProductModel(name: json['name'],
      nameAr: json['name_ar'],
      viewOrder: json['view_order'],
      productId: json['product_id'],
      quota: json['quota'],
      price: json['price'],
      maxQuantity: json['max_quantity'],
      unit: json['unit'], amountPrecision: json['amount_precision'], slices: json['slices']);
}