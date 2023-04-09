import 'package:get/get.dart';
import 'package:tirta/routes/app_routes.dart';
import 'package:tirta/services/firebase_auth.dart';

class SplashController extends GetxController {
  final FirebaseAuthServices auth = FirebaseAuthServices();
  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 3),
      () {
        auth.isLoggedIn().then(
          (value) {
            if (value) {
              Get.offNamed(Routes.MENU);
            } else {
              Get.offNamed(Routes.LOGIN);
            }
          },
        );
      },
    );
  }
}
