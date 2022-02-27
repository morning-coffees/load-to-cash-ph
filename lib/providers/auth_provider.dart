import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:loadtocashph/providers/auth_provider.dart';

class AuthProvider with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth fireAuth = FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? _user;
  User? _fireUser;

  AuthProvider._privateConstructor();
  static final AuthProvider instance = AuthProvider._privateConstructor();

  AuthProvider() {
    _user = _googleSignIn.currentUser;
  }

  GoogleSignInAccount? get user => _user;

  void signIn() {
    _googleSignIn
        .signIn()
        .then((value) => _user = _googleSignIn.currentUser)
        .then((value) async {
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await _user?.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );
      try {
        final UserCredential userCredential =
            await fireAuth.signInWithCredential(credential);

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
    _googleSignIn.signOut().then((value) {
      _user = null;
      _fireUser = null;
    }).then((value) => notifyListeners());
  }

  Future<AuthCredential?> getAccountCredential() async {
    print(_fireUser);
  }
}
