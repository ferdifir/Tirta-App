import 'package:firebase_auth/firebase_auth.dart';
import 'package:tirta/utils/log.dart';

class FirebaseAuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // check if user is logged in
  Future<bool> isLoggedIn() async {
    User? user = _auth.currentUser;
    return user != null;
  }

  // sign in with email and password
  Future<Map<String, dynamic>> signInWithEmailAndPassword(String email, String password) async {
    String? errorMessage = '';
    bool result = true;
    String? uid = '';
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = userCredential.user;
      uid = user!.uid;
      result = true;
      errorMessage = null;
    } on FirebaseAuthException catch (e) {
      Log.i(e.toString());
      if (e.code == 'user-not-found') {
        errorMessage = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Wrong password provided for that user.';
      }
      uid = null;
      result = false;
    }
    return {'result': result, 'errorMessage': errorMessage, 'uid': uid};
  }

  // register with email and password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return user;
    } catch (e) {
      Log.i(e.toString());
      return null;
    }
  }

  // reset password
  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      Log.i(e.toString());
      return null;
    }
  }

  // sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      Log.i(e.toString());
      return null;
    }
  }
}