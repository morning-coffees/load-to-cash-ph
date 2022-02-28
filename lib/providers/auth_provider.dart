import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _fireAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  User? _fireUser;

  AuthProvider._privateConstructor();
  static final AuthProvider instance = AuthProvider._privateConstructor();

  AuthProvider() {
    _fireUser = _fireAuth.currentUser;

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      _fireUser = user;
    });
  }

  User? get user => _fireUser;

  void signIn() {
    GoogleSignInAccount? user;
    _googleSignIn
        .signIn()
        .then((value) => user = _googleSignIn.currentUser)
        .then((value) async {
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await user?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      try {
        final UserCredential userCredential =
            await _fireAuth.signInWithCredential(credential);

        _fireUser = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
        } else if (e.code == 'invalid-credential') {}
      } catch (e) {
        print(e);
      }
    }).then((value) => notifyListeners());
  }

  void signOut() {
    _fireAuth
        .signOut()
        .then((value) => _fireUser = null)
        .then((value) => notifyListeners());
  }
}
