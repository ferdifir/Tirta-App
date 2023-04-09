import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:tirta/utils/helper.dart';

import '../../model/transaction.dart';
import '../../services/firebase_db.dart';

class TransactionController extends GetxController {
  final statusController = TextEditingController();
  final itemController = TextEditingController(
    text: '1',
  );
  final jumlahController = TextEditingController();
  final waktuController = TextEditingController();
  final db = FirebaseDbServices();
  final uid = Get.arguments;
  dynamic filterWaktu = 'Semua';
  ScrollController scrollController = ScrollController();
  RxBool isVisible = true.obs;
  late Timer timer = Timer(Duration.zero, () {});
  int timeToShow = 1;

  @override
  void onInit() {
    super.onInit();
    waktuController.text = DateTime.now().toString().substring(0, 16);
    changeJumlah(itemController.text);
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.onClose();
  }

  changeFilterWaktu(dynamic value) {
    filterWaktu = value;
    update();
  }

  void scrollListener() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      // hide FAB when scrolling down
      if (isVisible.value) {
        isVisible = false.obs;
        update();
      }
    } else {
      // show FAB when scrolling up
      if (!isVisible.value) {
        timer.cancel();
        timer = Timer(Duration(seconds: timeToShow), () {
          isVisible = true.obs;
          update();
        });
      }
    }
  }

  void changeJumlah(String value) {
    if (value.isNotEmpty) {
      jumlahController.text = Helper.rupiah(int.parse(value) * 7000);
      update();
    } else {
      jumlahController.text = '';
      update();
    }
  }

  int tag = 1;
  List<String> options = [
    'Berhasil',
    'Gagal',
  ];

  selectStatus(int value) {
    tag = value;
    update();
  }

  addTransaction() {
    bool state = tag == 0 ? true : false;
    Timestamp timestamp =
        Timestamp.fromDate(DateTime.parse(waktuController.text));
    int jumlah = Helper.rupiahToInt(jumlahController.value.text);
    db.addTransaction(
      uid,
      HistoryTransaction(
        status: state,
        item: int.parse(itemController.text),
        jumlah: jumlah,
        waktu: timestamp,
      ),
    );
    itemController.text = '1';
    jumlahController.text = Helper.rupiah(7000);
    waktuController.text = DateTime.now().toString().substring(0, 16);
    Get.back();
  }
}
