import 'package:trade_hall/controllers/auth/authenticate_controller.dart';

import 'package:trade_hall/data/models/session_details_model.dart';
import 'package:trade_hall/data/providers/session_pro.dart';
import 'package:trade_hall/data/repositories/init_repo.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';

import '../../core/constants/error.dart';
import '../../core/constants/typedef.dart';
import '../../core/localization/translation_keys.dart';
import '../../data/models/sale_model.dart';
import '../../data/models/session_model.dart';

class SessionController extends GetxController {
  @override
  void onInit() {
    isEnglish = _appService.storage.read("lang") == 'en' ? true : false;
    super.onInit();
  }

  void getSession(int sessionId) async {
    isLoading = true;
    update();
    parameters params = {
      'user_id': _authenticateController.currentUser!.id,
      'session_id': sessionId,
    };
    params.addAll(_appService.params);
    sessionDetails = await _sessionProvider.getSessionById(params);
    if (sessionDetails != null) {
      String line = _generateInvoiceItemsList();
      sessionTemplate = '''
=========================
${_appService.dataDetails!.facilityName}${"".padRight(20)}
=========================
${TranslationKeys.sessionID.tr}: ${sessionDetails!.sessionId}
${TranslationKeys.startTime.tr}: ${sessionDetails!.startTime}
${TranslationKeys.endTime.tr}: ${sessionDetails!.endTime}
-------------------------
${TranslationKeys.saleName.tr.padRight(13)}${TranslationKeys.qty.tr.padRight(10)}${TranslationKeys.price.tr.padRight(10)}${TranslationKeys.total.tr}
$line
-------------------------
${TranslationKeys.totalPrice.tr}: ${sessionDetails!.total!.toStringAsFixed(0)}
=========================
\n
\n''';
    }
    isLoading = false;
    update();
  }

  String _generateInvoiceItemsList() {
    String itemList = '';
    for (SaleModel s in sessionDetails!.sales) {
      isEnglish
          ? itemList +=
              '${s.name!.padRight(16)}${s.quantity.toString().padRight(14)}${s.unitPrice!.toStringAsFixed(0).padRight(14)}${s.totalPrice!.toStringAsFixed(0)}\n'
          : itemList +=
              '${s.nameAr!.padRight(12)}${s.quantity.toString().padRight(12)}${s.unitPrice!.toStringAsFixed(0).padRight(12)}${s.totalPrice!.toStringAsFixed(0)}\n';
    }
    return itemList;
  }
  Future<List<SessionModel>?> fetchSessions() async {
    try {
      parameters params = {'user_id': _authenticateController.currentUser!.id};
      params.addAll(_appService.params);
      List<SessionModel>? temp = await _sessionProvider.getAllSessions(params);
      return temp;
    } catch (e) {
      print("error in fetchSessions $e");
    }
  }
  void printSessionInfo() async {
    try {
      isEnglish = _appService.storage.read("lang") == 'en' ? true : false;
      final int status = await _appService.platformPrint.invokeMethod(
        'print',
        {
          'invoiceTemplate': sessionTemplate,
          'isEnglish': isEnglish,
        },
      );

      print("data in FLutter $status");
    } catch (e) {
      showSnackBar(TranslationKeys.errorinprint.tr);
      print('Error calling native method: $e');
    }
  }

  set isLoading(bool isLoading) => _isLoading.value = isLoading;
  bool get isLoading => _isLoading.value;

  final RxBool _isLoading = RxBool(false);
  late bool isEnglish;
  late String? sessionTemplate;
  final AppService _appService = Get.find();
  final AuthenticateController _authenticateController = Get.find();
  final SessionProvider _sessionProvider = SessionProvider();
  late SessionDetailsModel? sessionDetails;
  late int? sessionId;
}
