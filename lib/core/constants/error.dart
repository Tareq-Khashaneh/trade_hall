import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trade_hall/core/theme/app_colors.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

abstract class Exceptions {
  void getExceptionType(dio.DioException e);
}

class DioExceptions implements Exceptions {
  @override
  void getExceptionType(dio.DioException e) {
    switch (e.type) {
      case dio.DioExceptionType.connectionTimeout:
        showSnackBar(e.message);
        break;
      case dio.DioExceptionType.receiveTimeout:
        showSnackBar(e.message);
        break;
      case dio.DioExceptionType.sendTimeout:
        showSnackBar(e.message);
        break;
      case dio.DioExceptionType.badCertificate:
        showSnackBar(e.message);
        break;
      case dio.DioExceptionType.badResponse:
        showSnackBar(e.message);
        break;
      case dio.DioExceptionType.cancel:
        showSnackBar(e.message);
        break;
      case dio.DioExceptionType.connectionError:
        showSnackBar(e.message);
        break;
      // TODO: Handle this case.
      case dio.DioExceptionType.unknown:
        showSnackBar(e.message);
        break;
      default:
        showSnackBar('حدث خطأ اثناء تحميل البيانات');
      // TODO: Handle this case.
    }
  }
}

void showSnackBar(String? message,{bool isFail = true,snackPosition =SnackPosition.TOP,Color fontColor = Colors.white,Color? color ,Duration? duration}) {
  Get.snackbar(
    isFail ? TranslationKeys.failOccur.tr : '',
    message!,

    messageText: Padding(
      padding: const EdgeInsets.only(bottom: 20,),
      child: Text(message,
          style:
              TextStyle(fontSize: Get.size.height * 0.03, color: fontColor),
      textAlign: TextAlign.center,
      ),
    ),
    isDismissible: true,
    snackPosition: snackPosition,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: color ?? Colors.red,
    colorText: Colors.white,
    duration: duration ??  const Duration(milliseconds: 3500),
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    padding: const EdgeInsets.only(bottom: 10 ,left: 10.0,right: 10),
  );
}
Future<AwesomeDialog> showDialogue(
    { required String title,
      required String desc,
      required DialogType dialogType,
      required BuildContext context,
      required Function() onPressYes}) async =>
    AwesomeDialog(
      context: context,
      dialogType: dialogType,
      animType: AnimType.scale,
      title: title ,
      desc: desc,
      headerAnimationLoop: false,
      btnOkColor: AppColors.kmainColor,
      btnOkText: TranslationKeys.yes.tr,
      btnCancelColor: Colors.grey.withOpacity(0.65),
      btnCancelText: TranslationKeys.no.tr,
      btnCancelOnPress: (){

      },
      btnOkOnPress: () {
        onPressYes();
      },
    )..show();
