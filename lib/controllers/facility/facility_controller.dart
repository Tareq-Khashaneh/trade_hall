import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:trade_hall/data/repositories/facility_repo.dart';
import '../../core/constants/error.dart';
import '../../core/localization/translation_keys.dart';
import '../../data/models/current_product_balance_model.dart';
import '../../data/models/facility_info_model.dart';
import '../../data/models/product_last_order_model.dart';
import '../../data/providers/facility_pro.dart';
import '../../getx_service/app_service.dart';

class FacilityController extends GetxController {
  Future getFacilityInfo() async {
    try {
      facilityInfo =
          await _facilityProvider.getFacilityInfo(appService.params);
    } catch (e) {
      print("error $e");
    }
//     isLoading = false;
    // update();
  }

  Future<bool> login() async {
    try {
      // isLoading = true;
      update();
      if (password.text.isNotEmpty) {
        String hashPassword =
            md5.convert(utf8.encode(password.text)).toString();
        var dataLogin = await _facilityProvider.facilityRepository.getLogin(
            {'dev_sn': appService.deviceSerialNum, 'pass': hashPassword});
        if (dataLogin != null) {

          return true;
        }
        showSnackBar(TranslationKeys.passwordisWrong.tr);
      }
    } catch (e) {
      print("error in facility login $e");
      return false;
    }
    showSnackBar(TranslationKeys.passwordisempty.tr);
    return false;
  }

  String? validate(String? value) {
    if (value!.isEmpty) {
      return TranslationKeys.pleasEnterThePassword.tr;
    }
    return null;
  }

  final formKey = GlobalKey<FormState>();
  DataTable buildDataTable(List<String> columns, List rows) => DataTable(
      columnSpacing: 20, columns: _getColumns(columns), rows: _getRows(rows));
  List<DataColumn> _getColumns(List<String> columns) => columns
      .map((c) => DataColumn(
              label: Text(
            c,
          )))
      .toList();
  List<DataRow> _getRows(List<dynamic> rows) {
    switch (rows[0].runtimeType) {
      case CurrentProductBalance:
        return rows
            .map((r) => DataRow(cells: [
                  DataCell(Text(r.productName!)),
                  DataCell(Text(r.activeQuota!))
                ]))
            .toList();
      case ProductLastOrderModel:
        return rows
            .map((r) => DataRow(cells: [
                  DataCell(Text(r.productName!)),
                  DataCell(Text(r.order!.toString())),
                  DataCell(Text(r.amount!)),
                ]))
            .toList();
      default:
        return rows
            .map((r) => DataRow(cells: [
                  DataCell(Text(r.productName!)),
                  DataCell(Text(r.quantity!))
                ]))
            .toList();
    }
  }

  @override
  void onInit() {
    password = TextEditingController();
    isLoading = false;
    _facilityProvider = FacilityProvider(facilityRepository: FacilityRepository(apiService: appService.apiService));
    super.onInit();
  }
  @override
  void dispose() {
    password.dispose();
    super.dispose();
  }

  FacilityInfoModel? facilityInfo;
  final AppService appService = Get.find<AppService>();
  late FacilityProvider _facilityProvider;
  late bool isLoading;
  late TextEditingController password;


}
