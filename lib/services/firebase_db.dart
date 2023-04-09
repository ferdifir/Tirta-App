import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirta/model/profile.dart';
import 'package:tirta/model/transaction.dart';

class FirebaseDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUser(String uid, String email, String password) {
    //check if the uid have empty name, phone, address or not
    _db.collection('users').doc(uid).set({
      'email': email,
      'password': password,
      'name': '',
      'phone': '',
      'address': '',
    });
  }

  Stream<List<HistoryTransaction>> getTransaction(String uid) {
    return _db.collection('users').doc(uid).snapshots().map((event) {
      final history = event['historyTransaction'] as List<dynamic>;
      return history
          .map((transaction) => HistoryTransaction.fromMap(transaction))
          .toList();
    });
  }

  addTransaction(String uid, HistoryTransaction transaction) {
    _db.collection('users').doc(uid).update({
      'historyTransaction': FieldValue.arrayUnion([transaction.toMap()])
    });
  }

  Stream<int> getStockGalon(String uid) {
    return _db
        .collection('users')
        .doc(uid)
        .snapshots()
        .map((event) => event['stockGalon']);
  }

  updateStockGalon(String uid, String stock) {
    _db.collection('users').doc(uid).update({'stockGalon': int.parse(stock)});
  }

  Stream<Profile> getUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map(
          (snapshot) =>
              Profile.fromMap(snapshot.data() as Map<String, dynamic>),
        );
  }

  updateName(String uid, String name) {
    _db.collection('users').doc(uid).update({'name': name});
  }

  updatePhone(String uid, String phone) {
    _db.collection('users').doc(uid).update({'phone': phone});
  }

  updateAddress(String uid, String address) {
    _db.collection('users').doc(uid).update({'address': address});
  }
}
