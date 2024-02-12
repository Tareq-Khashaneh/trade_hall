import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hall/controllers/auth/authenticate_controller.dart';
import 'package:trade_hall/controllers/session/session_controller.dart';
import 'package:trade_hall/core/enums/enum_state.dart';
import 'package:get/get.dart';
import '../../core/constants/error.dart';

import '../../data/models/product_model.dart';
import '../../data/models/session_model.dart';
import '../../data/models/user_model.dart';
import '../../getx_service/app_service.dart';

class HomeController extends FullLifeCycleController with FullLifeCycleMixin {
  @override
  void onInit() {
    super.onInit();
    WidgetsBinding.instance?.addObserver(this);
    isBackPressed= false;
    cardId = '';
    currentUser = _authenticateController.currentUser;
    sessions = RxList([]);
    _products = RxList([]);
    cardReadStatus = CardReadStatus.failed;
    fetchSessions();
  }

  Future<bool> _readCard() async {
    try {
      final Map data = await appService.platformRead.invokeMethod('readCard');
      final bool isTimeOut = data['isTimeOut'];
      cardId = data['cardId'];
      if (isTimeOut == true ) {
       cardReadStatus =  CardReadStatus.timeout;

        isLoading = false;
// return true;
      }
     else if (cardId.isNotEmpty && currentUser != null) {
        isLoading = false;
       cardReadStatus = CardReadStatus.success;
       // update();
        // return true;
      }
    } catch (e) {
      showSnackBar(
        'خطأ في قراءة البطاقة',
      );
      print('Error calling native method: $e');
     cardReadStatus =  CardReadStatus.failed;

      isLoading = false;
      // update();
      // return false;
    }
    update();
   return cardReadStatus == CardReadStatus.success ? true : false;


  }

  void stopRead()async{
    appService.platformRead.invokeMethod('stopRead').then((value) {
      print("gere");
      if(value){
        cardReadStatus = CardReadStatus.stopped;
        isLoading = false;
      }
    });
  }
  void fetchSessions() async {
    try {
    List<SessionModel>? temp = await sessionController.fetchSessions();
      sessions.value = temp ?? [];
    } catch (e) {
      print("error in fetchSessions $e");
    }
  }
  Future<bool> readCard() async {
   cardReadStatus =  CardReadStatus.loading;
    isLoading = true;
    update();
    return _readCard();
  }
  final SessionController sessionController = Get.find();
  late RxList<SessionModel> sessions;
  final AppService appService = Get.find<AppService>();
  final AuthenticateController _authenticateController = Get.find();
  Rx<UserModel>? _currentUser;
  //setters
  set products(List<ProductModel> products) => _products.value = products.obs;
  set isLoading(bool isLoading) => _isLoading.value = isLoading;
  List<ProductModel> get products => _products;
  set currentUser(UserModel? currentUser) => _currentUser = currentUser?.obs;

  //getters
  UserModel? get currentUser => _currentUser?.value;

  // String get cardId => _cardId;
  bool get isLoading => _isLoading.value;
  final RxBool _isLoading = RxBool(false);
  final doubleClickInterval = 4000;
  late Timer  doubleClickTimer ;
  late String cardId;
  late CardReadStatus cardReadStatus;
  late bool isBackPressed;
  late RxList<ProductModel> _products;


  @override
  void onClose() {
    doubleClickTimer.cancel();
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    // Perform actions based on the app lifecycle state
    switch (state) {
      case AppLifecycleState.resumed:
      // App is resumed
        break;
      case AppLifecycleState.paused:
        stopRead();
      // App is paused
        break;
      case AppLifecycleState.inactive:
      // App is inactive
        break;
      case AppLifecycleState.detached:
      // App is detached (iOS specific)
        break;
      case AppLifecycleState.hidden:

    // TODO: Handle this case.
    }
  }

  @override
  void onDetached() {
    // TODO: implement onDetached
  }

  @override
  void onHidden() {
    // TODO: implement onHidden
  }

  @override
  void onInactive() {
    // TODO: implement onInactive
  }

  @override
  void onPaused() {
    // TODO: implement onPaused
  }

  @override
  void onResumed() {
    // TODO: implement onResumed
  }

}
