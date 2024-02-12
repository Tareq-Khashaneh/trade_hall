

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class CustomIcon extends StatelessWidget {
  const CustomIcon({super.key, required this.icon, this.color= const Color(0xFF065e97)});
  final IconData icon;
  final Color color ;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: Get.size.height * 0.02,left: 7.5,right: 7.5,bottom: Get.size.height * 0.025
      ), decoration: BoxDecoration(
        border:
        const Border.fromBorderSide(BorderSide.none),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(
                Get.size.height * 0.1),
            bottomLeft: Radius.circular(
                Get.size.height * 0.1)),
        color: AppColors.kSecondColor),
      child: Icon(
        icon,
        size: Get.size.height * 0.033,
        color: color,
      ),
    );
  }
}
