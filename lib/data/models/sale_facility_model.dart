


import '../../core/constants/typedef.dart';

class SaleFacilityModel{
  final String? productName;
  final String? quantity;

  SaleFacilityModel({required this.productName, required this.quantity});

factory SaleFacilityModel.fromJson(parameters json)
  => SaleFacilityModel(
      productName: json['product_name'],
      quantity: json['quantity']);
}