import 'package:get/get.dart';
import 'package:tirta/modules/login/login_screen.dart';
import 'package:tirta/modules/menu/menu_screen.dart';
import 'package:tirta/modules/splash/splash_screen.dart';
import 'package:tirta/modules/transaction/transaction_screen.dart';
import 'package:tirta/routes/app_routes.dart';

import '../modules/menu/menu_binding.dart';

class AppPages {
  static List<GetPage> pages = [
    GetPage(
      name: Routes.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: Routes.MENU,
      page: () => MenuScreen(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => TransactionScreen(),
    )
  ];
}
