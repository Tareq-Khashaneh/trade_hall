import 'package:trade_hall/data/models/settings_model.dart';

import 'city_model.dart';
import 'product_model.dart';
import 'user_model.dart';

class DataModel {
  final String? facilityName;
  final String? adminPass;
  final String? svTm;
  final String? devSn;
  final int? facilityType;
  final String? sellCenter;
  final List<UserModel> users;
  final List<ProductModel> products;
  final List<CityModel> cities;
  final List<dynamic>  devicesQuota;
  final String? gasId;
  final SettingsModel settings;
  DataModel(
      {required this.facilityName,
      required this.facilityType,
      required this.svTm,
      required this.users,
      required this.products,
      required this.cities,
        required this.devicesQuota,
      required this.gasId,
        required this.sellCenter,
      required this.adminPass,
      required this.devSn,
      required this.settings});
  factory DataModel.fromJson(Map<String, dynamic> data) => DataModel(
        svTm: data['sv_tm'],
        facilityName: data['data']['fac_name'],
        facilityType: data['data']['fac_type'],
        users: [
          for (Map<String, dynamic> userMap in data['data']['users'])
            UserModel.fromJson(userMap)
        ],
        products: [
          for (Map<String, dynamic> productMap in data['data']['products'])
            ProductModel.fromJson(productMap)
        ],
        cities: [
          for (Map<String, dynamic> cityMap in data['data']['cities'])
            CityModel.fromJson(cityMap)
        ],
        sellCenter: data['data']['sell_center'],
        gasId: data['data']['fac_name'],
        adminPass: data['data']['admin_pass'],
        devicesQuota: data['data']['devices_quota'],
        devSn: data['data']['dev_sn'],
        settings: SettingsModel.fromJson(data['data']['settings']),
      );
}
