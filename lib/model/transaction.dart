import 'package:cloud_firestore/cloud_firestore.dart';

class HistoryTransaction {
  final bool status;
  final int item;
  final int jumlah;
  final Timestamp waktu;

  HistoryTransaction({
    required this.status,
    required this.item,
    required this.jumlah,
    required this.waktu,
  });

  factory HistoryTransaction.fromMap(Map<String, dynamic> map) {
    return HistoryTransaction(
      status: map['status'],
      item: map['item'],
      jumlah: map['jumlah'],
      waktu: map['waktu'],
    );
  }
}
