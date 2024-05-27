import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:trade_hall/core/theme/app_colors.dart';
import 'package:trade_hall/core/localization/translation_keys.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

abstract class Exceptions {
  static void getExceptionType(dio.DioException e){}
}

class DioExceptions implements Exceptions {
  // static late dio.DioException dioException;
  static void getExceptionType(dio.DioException e) {
    String errorMessage = "";
    switch (e.type) {
      case dio.DioExceptionType.connectionTimeout:
        errorMessage = "Connection timed out";
        break;
      case dio.DioExceptionType.receiveTimeout:
        errorMessage = "Response timed out";
        break;
      case dio.DioExceptionType.sendTimeout:
        errorMessage = "Request timed out while sending data";
        break;
      case dio.DioExceptionType.badCertificate:
        errorMessage = "The server's SSL certificate is invalid. Please contact the administrator.";

        break;
      case dio.DioExceptionType.badResponse:
        errorMessage = "Received a bad response from the server. Please try again later.";

        break;
      case dio.DioExceptionType.cancel:
        errorMessage = "Request canceled";
        break;
      case dio.DioExceptionType.connectionError:
        errorMessage = "Unable to establish a connection. Please check your Credentials";
        break;
      // TODO: Handle this case.
      case dio.DioExceptionType.unknown:
        errorMessage = "An unexpected error occurred";
        break;
      default:
        showSnackBar('An unexpected error occurred');
      // TODO: Handle this case.
    }
    showSnackBar(errorMessage);
  }
}

void showSnackBar(String? message,{bool isFail = true,snackPosition =SnackPosition.TOP,Color fontColor = Colors.white,Color? color ,Duration? duration}) {
  Get.snackbar(
    '',
    message ?? "no error message",
    messageText: Padding(
      padding: const EdgeInsets.only(bottom: 20,),
      child: Text(message ?? 'no error message',
          style:
              TextStyle(fontSize: Get.size.height * 0.03, color: fontColor),
      textAlign: TextAlign.center,
      ),
    ),
    isDismissible: true,
    snackPosition: snackPosition,
    snackStyle: SnackStyle.FLOATING,
    backgroundColor: isFail ? Colors.red : AppColors.kmainColor,
    colorText: Colors.white,
    duration: duration ??  const Duration(milliseconds: 4000),
    margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
    padding: const EdgeInsets.only(bottom: 10 ,left: 10.0,right: 10),
  );
}
Future<AwesomeDialog> showDialogue({
  String? title,
  String desc = '',
  dismissOnTouchOutside = true,
  required DialogType dialogType,
  required BuildContext context,
  bool autoDismiss = true,
  Function()? onPressYes,
  Function()? onPressNo,
  Widget? body,
  Widget? customHeader,
}) async =>
    AwesomeDialog(
        context: context,
        dialogType: dialogType,
        animType: AnimType.scale,
        title: title,
        desc: desc,
        body: body,
        customHeader: customHeader,
        dismissOnTouchOutside: dismissOnTouchOutside,
        headerAnimationLoop: false,
        autoDismiss: autoDismiss,
        btnOkColor: AppColors.kmainColor,
        btnOkText: 'نعم',
        btnCancelColor: Colors.grey.withOpacity(0.65),
        btnCancelText: "لا",
        btnCancelOnPress: onPressNo,
        btnOkOnPress: onPressYes)
      ..show();
