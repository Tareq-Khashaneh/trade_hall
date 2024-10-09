import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trade_hall/controllers/settings/settings_controller.dart';
import 'package:trade_hall/core/constants/routes.dart';
import 'package:trade_hall/core/keys/settings_screen_key.dart';
import 'package:trade_hall/core/localization/locale_controller.dart';
import 'package:trade_hall/getx_service/app_service.dart';
import 'package:trade_hall/view/screens/authenticate_screen.dart';
import 'package:trade_hall/view/screens/settings_screen.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("configuration end to end test", (){
    // This will run once before all the tests in the group
    setUpAll(() async{
      await AppService().initialize();
      Get.put(SettingsController());
      Get.put(LocaleController());
    });

    testWidgets("wifi selection", (WidgetTester tester)async{
      await tester.pumpWidget(GetMaterialApp(
          getPages: AppRoutes.pages,
         home:  const SettingsScreen()));

      await tester.pumpAndSettle();
      final dropDown = find.byKey(SettingsKeys.dropDown);
      expect(dropDown, findsOneWidget);

      await tester.pumpAndSettle();
      await tester.tap(dropDown);
      await tester.pumpAndSettle();
      final wifiChoose = find.text("Wifi").last;
      expect(wifiChoose, findsOneWidget);
      // await tester.drag(wifiChoose, const Offset(182.0, 138.0));
      // await tester.pumpAndSettle();
      await tester.tap(wifiChoose);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      final networkName = find.byKey(SettingsKeys.wifiNetworkName);
      expect(networkName, findsOneWidget);
      await tester.enterText(networkName, "Source_code");
      final password = find.byKey(SettingsKeys.wifiPassword);
      expect(password, findsOneWidget);
      await tester.enterText(password, "12345678");
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump(); // Update the UI after submitting the input

      final wifiIp = find.byKey(SettingsKeys.wifiIp);
      expect(wifiIp, findsOneWidget);
      await tester.enterText(wifiIp, "192.168.120.103");
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump(); // Update the UI after submitting the input
      await Future.delayed(const Duration(seconds: 1));
      final wifiPort = find.byKey(SettingsKeys.wifiPort);
      expect(wifiPort, findsOneWidget);
      await tester.enterText(wifiPort, "7000");     // await tester.drag(find.byKey(const Key("wifi form")), const Offset(180.0, 373.9));
      await tester.pump();
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pumpAndSettle(Duration(seconds: 5)); // Update the UI after submitting the input

      // await Future.delayed(const Duration(seconds: 2));

      final connectButton = find.byKey(const Key("connect"));

      // Get the center position of the widget
      final Offset centerPosition = tester.getCenter(connectButton);
      print('Center Position: $centerPosition');
      expect(connectButton, findsOneWidget);
      // await tester.drag(connectButton, const Offset(180.0, 600.4));
      await tester.tap(connectButton,warnIfMissed: false);
      await tester.pumpAndSettle(const Duration(seconds: 12));
      expect(find.byType(AuthenticateScreen), findsOneWidget);
    });
  });
}