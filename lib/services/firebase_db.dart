import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tirta/model/profile.dart';

class FirebaseDbServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  addUser(String uid, String email, String password) {
    _db.collection('users').doc(uid).set({
      'email': email,
      'password': password,
      'name': '',
      'phone': '',
      'address': '',
    });
  }

  Stream<Profile> getUser(String uid) {
    return _db.collection('users').doc(uid).snapshots().map(
          (snapshot) => Profile.fromMap(snapshot.data() as Map<String, dynamic>),
        );
  }

  updateName(String uid, String name) {
    print('check: $uid, $name');
    _db.collection('users').doc(uid).update({'name': name});
  }

  updatePhone(String uid, String phone) {
    _db.collection('users').doc(uid).update({'phone': phone});
  }

  updateAddress(String uid, String address) {
    _db.collection('users').doc(uid).update({'address': address});
  }
}