import 'package:trade_hall/controllers/auth/auth_admin_bindings.dart';
import 'package:trade_hall/controllers/basket_quota/basket_quota_bindings.dart';
import 'package:trade_hall/controllers/cart/cart_bindings.dart';
import 'package:trade_hall/controllers/drawer/drawer_bindings.dart';
import 'package:trade_hall/controllers/facility/facility_bindings.dart';
import 'package:trade_hall/networking/connectivity_bindings.dart';
import 'package:trade_hall/view/screens/auth_admin_screen.dart';
import 'package:trade_hall/view/screens/basket_quota_screen.dart';
import 'package:trade_hall/view/screens/authenticate_screen.dart';
import 'package:trade_hall/view/screens/cart_screen.dart';
import 'package:trade_hall/view/screens/facility_info_screen.dart';
import 'package:trade_hall/view/screens/splash_screen.dart';
import 'package:get/get.dart';
import '../../controllers/auth/auth_bindings.dart';
import '../../controllers/facility/facility_confirm_form_bindings.dart';
import '../../controllers/home/home_bindings.dart';
import '../../controllers/session/session_bindings.dart';
import '../../controllers/settings/settings_bindgins.dart';
import '../../view/screens/facility_confirm_form_screen.dart';
import '../../view/screens/facility_login_screen.dart';
import '../../view/screens/facility_screen.dart';
import '../../view/screens/facility_send_quantity_screen.dart';
import '../../view/screens/home_screen.dart';
import '../../view/screens/language_screen.dart';
import '../../view/screens/session_details_screen.dart';
import '../../view/screens/settings_screen.dart';

class AppRoutes {
  static const String splash = "/splash";
  static const String homeScreenRoute = '/home';
  static const String authenticateRoute = '/auth';
  static const String authAdminRoute = '/auth-admin';
  static const String basketQuotaRoute = '/basket-quota';
  static const String settingsRoute = '/settings';
  static const String languageRoute = '/language';
  static const String cartRoute = '/cart';
  static const String sessionRoute = '/session';
  static const String facilityAuthRoute = '/facility-login';
  static const String facilityRoute = '/facility';
  static const String facilityInfoRoute = '/facility-info';
  static const String facilitySendQuantityRoute = '/facility-send-quantity';
  static const String facilityConfirmFormRoute = '/facility-confirm-form';
  static final List<GetPage> pages = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
        name: AppRoutes.authAdminRoute,
        page: () => const AuthAdminScreen(),
        bindings: [ConnectivityBindings(),AuthAdminBindings(),]),
    GetPage(
        name: AppRoutes.settingsRoute,
        page: () => const SettingsScreen(),
      binding: SettingsBindings()
    ),
    GetPage(
        name: AppRoutes.authenticateRoute,
        page: () => const AuthenticateScreen(),
        binding: AuthBindings()),
    GetPage(
        name: AppRoutes.homeScreenRoute,
        page: () => const HomeScreen(),
        bindings: [HomeBindings(),SessionBindings(),DrawerBindings()]),
    GetPage(
        name: AppRoutes.sessionRoute,
        page: () => const SessionDetailsScreen(),
        bindings: [SessionBindings()]),
    GetPage(
        name: AppRoutes.facilityRoute,
        page: () => const FacilityScreen(),
        binding: FacilityBindings()),
    GetPage(
        name: AppRoutes.facilityAuthRoute,
        page: () => const FacilityLoginScreen(),
        binding: FacilityBindings()),
    GetPage(
        name: AppRoutes.facilityInfoRoute,
        page: () => const FacilityInfoScreen(),
        binding: FacilityBindings()),
    GetPage(
        name: AppRoutes.facilitySendQuantityRoute,
        page: () => const FacilitySendQuantityScreen(),
        binding: FacilityBindings()),
    GetPage(
        name: AppRoutes.facilityConfirmFormRoute,
        page: () => const FacilityConfirmFormScreen(),
        binding: FacilityConfirmFormBindings()),
    GetPage(
        name: AppRoutes.basketQuotaRoute,
        page: () => const BasketQuotaScreen(),
        bindings: [BasketQuotaBindings(), CartBindings()]),
    GetPage(
        name: AppRoutes.cartRoute,
        page: () => const CartScreen(),
        binding: CartBindings()),
    GetPage(
      name: AppRoutes.languageRoute,
      page: () => LanguageScreen(),
    )
  ];
}
