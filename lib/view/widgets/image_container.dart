

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageContainer extends StatelessWidget {
   ImageContainer({super.key, this.height, this.width, required this.img,  this.isAllCornerCurve = false,  this.boxFit = BoxFit.fill,  this.borderRadius = 40,this.isCurve = true , this.opacity = 1.0,this.child});
  final double? height;
  final double? width;
  final String img;
  final bool isAllCornerCurve;
  final BoxFit boxFit;
  final double borderRadius;
  final bool isCurve;
  final double opacity;
  final Widget? child;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? Get.size.height * 0.5,
      decoration:  BoxDecoration(
          image: DecorationImage(
            image: AssetImage(img),
            fit: boxFit,
            opacity: opacity,
          ),

          borderRadius:
              isCurve ?
          isAllCornerCurve ?
           BorderRadius.all(Radius.circular(borderRadius)):
           BorderRadius.only(
              topLeft: Radius.circular(borderRadius),
              topRight: Radius.circular(borderRadius))
                  :null

      ),
      child: child,
    );

  }
}
