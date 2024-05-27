import 'dart:async';

import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityController extends GetxController {

   late List<ConnectivityResult>  connectivityResult  ;
   late StreamSubscription<List<ConnectivityResult>> subscription;
  Future<bool> checkNetworkConnection() async {
    connectivityResult = await (Connectivity().checkConnectivity());

    return (connectivityResult.contains(ConnectivityResult.wifi)  || connectivityResult.contains( ConnectivityResult.mobile) );
  }
}
