

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key, required this.onTap, required this.textButton});
  final Function() onTap;
  final String textButton;
  @override
  Widget build(BuildContext context) {
    return  Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: InkWell(
          onTap: onTap,
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.only(
                top: 12, bottom: 12, left: 8, right: 10),
            width: Get.size.width * 0.4,
            decoration: BoxDecoration(
                color: AppColors.kmainColorHex,
                borderRadius: const BorderRadius.all(
                    Radius.circular(40)),
                boxShadow: [
                  BoxShadow(
                      offset: Offset(0, 2),
                      blurRadius: 4,
                      color: AppColors.kmainColor),
                  BoxShadow(
                      offset: Offset(2, 2),
                      color: AppColors.kSecondColor),
                  BoxShadow(
                      offset: Offset(-2, 2),
                      color: AppColors.kSecondColor)
                ]),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(

                  child:
                  Obx(() =>  Text(
                    textButton,
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge!
                        .copyWith(
                        fontSize: AppTheme().fontSize,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                  ),)

                ),
                const SizedBox(
                  width: 5,
                ),
                Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: Get.size.height * 0.03,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
