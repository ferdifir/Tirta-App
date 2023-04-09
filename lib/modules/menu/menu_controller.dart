import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tirta/services/firebase_auth.dart';
import 'package:tirta/services/firebase_db.dart';
import 'package:tirta/services/shared_pref.dart';
import 'package:tirta/utils/constant.dart';

import '../../model/profile.dart';

class MenuController extends GetxController {
  final auth = FirebaseAuthServices();
  final db = FirebaseDbServices();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final galonController = TextEditingController().obs;
  String? uid;
  final showLoading = false.obs;

  @override
  void onInit() async {
    super.onInit();
    uid = await SharedPref.getString(uidPrefKey);
    if (uid != null) {
      showLoading.value = true;
      getUser(uid!).listen((event) {
        if (event.address != '' && event.name != '' && event.phone != '') {
          nameController.text = event.name;
          phoneController.text = event.phone;
          addressController.text = event.address;
        } else {
          nameController.text = 'Nama';
          phoneController.text = 'No. Telp';
          addressController.text = 'Alamat';
        }
      });
      getStock(uid!).listen((event) {
        galonController.value.text = event.toString();
      });
    } else {
      showLoading.value = false;
    }
  }

  logout() async {
    await auth.signOut();
  }

  updateName(String uid, String name) {
    db.updateName(uid, name);
  }

  updatePhone(String uid, String phone) {
    db.updatePhone(uid, phone);
  }

  updateAddress(String uid, String address) {
    db.updateAddress(uid, address);
  }

  Stream<Profile> getUser(String uid) {
    return db.getUser(uid);
  }

  Stream<int> getStock(String uid) {
    return db.getStockGalon(uid);
  }

  updateStock(String uid) {
    db.updateStockGalon(uid, galonController.value.text);
  }
}
