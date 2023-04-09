import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import 'menu_controller.dart';

class LogoutButton extends StatelessWidget {
  LogoutButton({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        controller.logout().then((value) {
          Get.offAllNamed(Routes.LOGIN);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 150,
          vertical: 12,
        ),
      ),
      child: const Text('Keluar'),
    );
  }
}

