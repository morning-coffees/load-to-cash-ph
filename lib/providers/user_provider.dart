import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  User? _fireUser;
  bool _isLoggedIn = false;

  UserProvider._privateConstructor();
  static final UserProvider instance = UserProvider._privateConstructor();

  UserProvider() {
    _fireUser = _fireAuth.currentUser;

    // notify if user is loggout
  }

  User? get user => _fireUser;
  bool get isLoggedIn => _isLoggedIn;

  Stream<QuerySnapshot<Object?>> streamUsers() {
    return FirebaseFirestore.instance.collection('users').snapshots();
  }
}
