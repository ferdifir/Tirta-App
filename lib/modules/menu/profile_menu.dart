import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/profile.dart';
import 'menu_controller.dart';
import 'update_profile_dialog.dart';

class ProfileMenu extends StatelessWidget {
  ProfileMenu({
    Key? key,
  }) : super(key: key);

  final MenuController controller = Get.find<MenuController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'KIOS ASRI',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(
              Icons.settings,
              size: 14,
            ),
            Text('agen'),
          ],
        ),
        const SizedBox(height: 20),
        Container(
          alignment: Alignment.centerLeft,
          margin: const EdgeInsets.only(left: 10),
          child: const Text(
            'PROFIL',
            textAlign: TextAlign.start,
          ),
        ),
        ListTile(
          leading: const Icon(Icons.person),
          title: StreamBuilder<Profile>(
            stream: controller.getUser(controller.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.name == '') {
                  return const Text('Nama');
                } else {
                  return Text(snapshot.data!.name);
                }
              } else {
                return const Text('Loading...');
              }
            },
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpdateProfileDialog(
                  icon: Icons.person,
                  title: 'Nama',
                  labelText: 'Masukkan nama',
                  controller: controller.nameController,
                  onPressed: () {
                    controller.updateName(controller.uid!,
                        controller.nameController.text);
                    Get.back();
                  },
                ),
                barrierDismissible: false,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.home),
          title: StreamBuilder<Profile>(
            stream: controller.getUser(controller.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.address == '') {
                  return const Text('Alamat');
                } else {
                  return Text(snapshot.data!.address);
                }
              } else {
                return const Text('Loading...');
              }
            },
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpdateProfileDialog(
                  icon: Icons.home,
                  title: 'Alamat',
                  labelText: 'Masukkan alamat',
                  controller: controller.addressController,
                  onPressed: () {
                    controller.updateAddress(controller.uid!,
                        controller.addressController.value.text);
                    Get.back();
                  },
                ),
                barrierDismissible: false,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ),
        ListTile(
          leading: const Icon(Icons.phone),
          title: StreamBuilder<Profile>(
            stream: controller.getUser(controller.uid!),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.phone == '') {
                  return const Text('Nomor Telepon');
                } else {
                  return Text(snapshot.data!.phone);
                }
              } else {
                return const Text('Loading...');
              }
            },
          ),
          trailing: IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => UpdateProfileDialog(
                  icon: Icons.phone,
                  title: 'Nomor Telepon',
                  labelText: 'Masukkan nomor telepon',
                  controller: controller.phoneController,
                  onPressed: () {
                    controller.updatePhone(controller.uid!,
                        controller.phoneController.value.text);
                    Get.back();
                  },
                ),
                barrierDismissible: false,
              );
            },
            icon: const Icon(Icons.edit),
          ),
        ),
      ],
    );
  }
}
