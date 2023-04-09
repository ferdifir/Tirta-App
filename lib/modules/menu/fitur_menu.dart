import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tirta/modules/menu/menu_controller.dart';

import '../../routes/app_routes.dart';
import 'update_galon_dialog.dart';

class FiturMenu extends StatelessWidget {
  FiturMenu({
    Key? key,
  }) : super(key: key);

  final controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            'FITUR',
            textAlign: TextAlign.start,
          ),
        ),
        ListTile(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => UpdateGalonDialog(),
              barrierDismissible: false,
            );
          },
          leading: const Icon(Icons.water_drop),
          title: const Text('Update Stock Galon'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
        ListTile(
          onTap: () {
            Get.toNamed(Routes.TRANSACTION,arguments: controller.uid);
          },
          leading: const Icon(Icons.home),
          title: const Text('Riwayat Transaksi'),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ],
    );
  }
}