
import 'package:trade_hall/controllers/home/home_controller.dart';
import 'package:trade_hall/controllers/session/session_controller.dart';
import 'package:get/get.dart';
import '../../core/constants/error.dart';
import '../../data/models/session_details_model.dart';
import '../../data/providers/auth_provider.dart';
import '../../getx_service/app_service.dart';
import '../auth/authenticate_controller.dart';

class DrawerGetxController extends GetxController {
  @override
  void onInit() {
    // isEnglish = _appService.prefs.getString("lang") == 'en' ? true : false;
    super.onInit();
  }

  void setDeviceTime() async {
    isLoadingSetTime = true;
    update();
    if (await _appService.setDeviceInfo()) {
      isLoadingSetTime = false;
      showSnackBar("Time was set",
          isFail: false, snackPosition: SnackPosition.BOTTOM);
    } else {
      isLoadingSetTime = false;
      showSnackBar("Time was not set",
          isFail: true, snackPosition: SnackPosition.BOTTOM);
    }
    update();
  }
  Future<bool> logout() async {
    try {
      logoutData = await _authProvider.getLogoutData({
        'dev_sn': _appService.deviceSerialNum,
        'app_version': _appService.appVersion,
        'session_id': authenticateController.authModel!.sessionId,
      });
      if (logoutData != null) {
        sessionController.printSessionInfo();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("error in logout $e");
      return false;
    }
  }
  late bool isEnglish;
  late bool isLoadingSetTime = false;
  final SessionController sessionController = Get.find();
  final AuthenticateController authenticateController = Get.find();
  final HomeController homeController = Get.find();
  final AuthProvider _authProvider = AuthProvider();
  SessionDetailsModel? logoutData;
  final AppService _appService = Get.find<AppService>();
}
