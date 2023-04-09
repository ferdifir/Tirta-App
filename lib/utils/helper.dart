import 'package:cloud_firestore/cloud_firestore.dart';

import 'constant.dart';

class Helper {
  // convert int to rupiah format
  static String rupiah(int value) {
    return 'Rp. ${value.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (match) => '${match[1]},')}';
  }

  // convert rupiah format to int
  static int rupiahToInt(String value) {
    return int.parse(value.replaceAll(RegExp(r'[^0-9]'), ''));
  }

  // convert timestamp from firestor to date format
  // example: 1 Feb 2021
  static String date(Timestamp value) {
    final date = value.toDate();
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  // convert timestamp from firestor to time format
  static String time(Timestamp value) {
    final date = value.toDate();
    return '${date.hour}:${date.minute}';
  }

}