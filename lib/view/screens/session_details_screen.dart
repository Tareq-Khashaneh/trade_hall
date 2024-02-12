import 'package:flutter/material.dart';
import 'package:trade_hall/controllers/session/session_controller.dart';
import 'package:trade_hall/view/widgets/circular_loading.dart';
import 'package:trade_hall/view/widgets/drawer_widget.dart';
import 'package:get/get.dart';
import '../../core/localization/translation_keys.dart';

class SessionDetailsScreen extends GetView<SessionController> {
  const SessionDetailsScreen({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: const DrawerWidget(),
      appBar: AppBar(title: Text(TranslationKeys.sessionInfo.tr), actions: [
        IconButton(
            onPressed: () => controller.printSessionInfo(),
            icon: const Icon(Icons.print_rounded))
      ]),
      body: SingleChildScrollView(
        child: GetBuilder<SessionController>(builder: (controller) {
          return controller.isLoading
              ? const CircularLoading()
              : controller.sessionTemplate != null
                  ? Padding(
                      padding: const EdgeInsets.only(
                        top: 30,
                        left: 30,
                        right: 20

                      ),
                      child: Text(
                        controller.sessionTemplate!,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    )
                  : const Text("No Session details");
        }),
      ),
    ));
  }

  // AppBar buildAppBar({
  //   required String title,
  //   required BuildContext context,
  //   List<Widget>? actions,
  // }) {
  //   return AppBar(
  //     title: Text(
  //       title,
  //       style: Theme.of(context)
  //           .textTheme
  //           .headlineSmall!
  //           .copyWith(color: AppColors.kWhiteColor),
  //     ),
  //     automaticallyImplyLeading: false,
  //     centerTitle: true,
  //     backgroundColor: AppColors.kmainColor,
  //     actions: actions,
  //   );
  // }
}
