import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';
import '../../core/constants/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

final AppService _appService = Get.find();

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(milliseconds: 4000)).then((value) {
      if (_appService.storage.read('admin') != null) {
        _appService.storage.read('admin')!
            ? Get.offNamed(AppRoutes.authenticateRoute)
            : Get.offNamed(AppRoutes.authAdminRoute);
      } else {
        Get.offNamed(AppRoutes.authAdminRoute);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            image: DecorationImage(
          image: AssetImage("assets/images/login_img.jpg"),
          fit: BoxFit.cover,
          opacity: 0.7,
        )),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: Get.size.height * 0.15,
              backgroundImage: const AssetImage("assets/images/logo.jpeg"),
              backgroundColor: Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}
