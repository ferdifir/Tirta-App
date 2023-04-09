import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:tirta/modules/login/login_controller.dart';
import 'package:tirta/routes/app_routes.dart';
import 'package:tirta/services/firebase_auth.dart';
import 'package:tirta/utils/assets.dart';
import 'package:tirta/utils/constant.dart';

import '../../services/firebase_db.dart';
import '../../services/shared_pref.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());
  final auth = Get.put(FirebaseAuthServices());
  final db = Get.put(FirebaseDbServices());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              Assets.logo,
              height: 200,
              width: 300,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 400,
              width: double.infinity,
              child: Stack(
                children: [
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              const SizedBox(height: 130),
                              TextField(
                                controller: controller.emailTxtController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                              Obx(
                                () => TextField(
                                  controller: controller.passwordTxtController,
                                  obscureText: controller.hidePassword.value,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    prefixIcon: const Icon(Icons.lock),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        controller.hidePassword.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        controller.hidePassword.toggle();
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.asset(
                        Assets.login,
                        width: 200,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Get.dialog(const Center(
                  child: CircularProgressIndicator(),
                ));
                auth
                    .signInWithEmailAndPassword(
                  controller.emailTxtController.text,
                  controller.passwordTxtController.text,
                )
                    .then((value) {
                  if (value['result']) {
                    SharedPref.saveString(uidPrefKey, value['uid']);
                    // db.addUser(
                    //   value['uid'],
                    //   controller.emailTxtController.text,
                    //   controller.passwordTxtController.text,
                    // );
                    Get.back();
                    Get.offAllNamed(Routes.MENU);
                  } else {
                    Get.back();
                    Get.snackbar('Error', value['errorMessage']);
                  }
                });
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: const TextStyle(fontWeight: FontWeight.bold),
              ),
              child: const Text('MASUK'),
            )
          ],
        ),
      ),
    );
  }
}
