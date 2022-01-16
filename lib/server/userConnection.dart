import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:legend_app/models/userModel.dart';

class UserConnection {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Stream<UserModel> get userStream {
    return _auth
        .authStateChanges()
        .asyncMap((user) => UserModel(user?.email, '', user?.uid));
  }

  Future<bool> get ifUserConnected async {
    //
    return false;
  }

  Future<UserModel> get UserConnected async {
    User? user = _auth.currentUser;
    UserModel userModel = UserModel(user?.email, '', user?.uid);
    return userModel;
  }

  Future<UserModel> Authentification(email, password) async {
    UserCredential _userCredential;
    try {
      _userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      String userId = "";
      userId = _userCredential.user!.uid;
      print(userId);
      UserModel _user = UserModel(email, password, userId);
      return _user;
    } catch (e) {
      //return a empty user
      return new UserModel('', '');
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    // Navigator.pushAndRemoveUntil(context, newRoute, (route) => false)
  }
}
