import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trade_hall/controllers/auth/authenticate_controller.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:get/get.dart';

import '../../core/theme/app_colors.dart';

class CustomField extends StatefulWidget {
  CustomField(
      {super.key,
      required this.controller,
      required this.label,
      this.isSecure,
      this.contentPadding,
      this.validator, this.inputFormatters, this.keyboardType});
  final TextEditingController controller;
  final String label;
  late bool? isSecure;
  final EdgeInsets? contentPadding;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late Icon visibilityIcon;
  @override
  void initState() {
    visibilityIcon = Icon(
      Icons.visibility_off_outlined,
      color: AppColors.kIconColor,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.isSecure ?? false,
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.inputFormatters,
      decoration: InputDecoration(
        suffixIcon: widget.isSecure != null
            ? IconButton(
                onPressed: () {
                  setState(() {
                    if (widget.isSecure != null) {
                      widget.isSecure = !widget.isSecure!;
                      visibilityIcon = widget.isSecure == false
                          ? const Icon(Icons.visibility_rounded)
                          : const Icon(Icons.visibility_off_outlined);
                    }
                  });
                },
                icon: visibilityIcon)
            : null,
        label: Text(widget.label),
        labelStyle: TextStyle(color: AppColors.kmainColor),
        contentPadding: widget.contentPadding,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.kTextColor),
            borderRadius:
                BorderRadius.all(Radius.circular(Get.size.height * 0.1))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.kTextColor),
            borderRadius:
                BorderRadius.all(Radius.circular(Get.size.height * 0.1))),
        errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red),
            borderRadius:
                BorderRadius.all(Radius.circular(Get.size.height * 0.1))),
      ),
      validator: widget.validator,
    );
  }
}
