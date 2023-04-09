import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import 'fitur_menu.dart';
import 'logout_button.dart';
import 'menu_controller.dart';
import 'photo_menu.dart';
import 'profile_menu.dart';

class MenuScreen extends GetView<MenuController> {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => controller.showLoading.value ? SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
              width: double.infinity,
            ),
            const PhotoMenu(),
            const SizedBox(height: 10),
            ProfileMenu(),
            const ListTile(
              leading: Icon(Icons.water_drop_outlined),
              title: Text('7 Galon'),
            ),
            const FiturMenu(),
            const SizedBox(height: 20),
            LogoutButton(),
          ],
        ),
      ) : const Center(child: CircularProgressIndicator())),
    );
  }
}
