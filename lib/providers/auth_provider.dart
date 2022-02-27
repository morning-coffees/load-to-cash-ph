import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  GoogleSignInAccount? _user;

  AuthProvider() {
    _user = _googleSignIn.currentUser;
  }

  GoogleSignInAccount? get user => _user;

  void signIn() {
    _googleSignIn
        .signIn()
        .then((value) => _user = _googleSignIn.currentUser)
        .then((value) => notifyListeners());
  }

  void signOut() {
    _googleSignIn
        .signOut()
        .then((value) => _user = null)
        .then((value) => notifyListeners());
  }
}
