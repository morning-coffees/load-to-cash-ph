import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:loadtocashph/models/user_model.dart';

class UserProvider with ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;
  final _users = FirebaseFirestore.instance
      .collection('users')
      .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (user, _) => user.toJson());

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
    print('current user: ============${_currentUser?.email}===========');

    return await _users
        .doc(_currentUser?.email)
        .get()
        .then((value) => value.data());
  }
}
