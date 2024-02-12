

import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';

  AppBar buildAppBar({required String title,required BuildContext context,List<Widget>? actions ,}) {
    return AppBar(
      title: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .copyWith(color: AppColors.kWhiteColor),
      ),automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: AppColors.kmainColor,
      actions: actions,

    );
  }

