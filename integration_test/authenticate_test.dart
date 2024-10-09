


import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:trade_hall/main.dart' as app;
import 'package:trade_hall/view/screens/auth_admin_screen.dart';
import 'package:trade_hall/view/screens/settings_screen.dart';

void main(){
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  group("auth end to end test", (){
    testWidgets("admin auth success", (tester)async{
      app.main();
      await tester.pumpAndSettle(const Duration(seconds: 4));
      final authAdminScreen = find.byType(AuthAdminScreen);
      expect(authAdminScreen, findsOneWidget);
      final adminPasswordField = find.byKey(const Key("CustomField"));
      expect(adminPasswordField, findsOneWidget);
      await tester.enterText(adminPasswordField, '1111');
      expect(find.text('1111'), findsOneWidget);
      await Future.delayed(const Duration(seconds: 2));
      final loginButton  = find.byKey(const Key('login button'));
      await tester.drag(loginButton, const Offset(267.0, 540.5));
      await tester.tap(loginButton);
      await tester.pumpAndSettle(const Duration(seconds: 2));
      expect(find.byType(SettingsScreen), findsOneWidget);
    });
  });
}

