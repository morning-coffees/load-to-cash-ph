import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loadtocashph/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final _users = UserModel.empty().ref;

  User? _currentUser;

  UserProvider._privateConstructor();
  static final UserProvider instance = UserProvider._privateConstructor();

  UserProvider() {
    _currentUser = _fireAuth.currentUser;
  }

  Stream<QuerySnapshot<Object?>> streamUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }

  Future<UserModel?> getCurrentUser() async {
    return await _users
        .doc(_currentUser?.email)
        .get()
        .then((value) => value.data());
  }
}
