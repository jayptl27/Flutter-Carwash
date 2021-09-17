import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_carwash/models/user.dart';
import 'package:flutter_carwash/services/database.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  String userUid;
  String get getUserUid => userUid;

  //Create user object based on firebase user
  UserFB _userFromFirebaseUser(User user) {
    return user != null ? UserFB(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<UserFB> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirebaseUser);
  }

  //register with Email and Password
  Future registerWithEmailAndPassword(
      String email, String password, String phonenumber, String name) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      userUid = user.uid;
      await DatabaseService(uid: user.uid)
          .setUserDetails(email, name, phonenumber);
      await user.sendEmailVerification();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign in with Email and Password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      userUid = user.uid;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //sign out of the app
  Future signOut() async {
    try {
      return _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //reset password
  Future resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
