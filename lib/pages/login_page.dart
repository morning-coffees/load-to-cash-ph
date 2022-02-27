import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loadtocashph/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  static const routeName = '/login';
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? user = context.watch<AuthProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hello world"),
      ),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signIn();
              },
              child: const Text("Sign in"),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
              },
              child: const Text("Sign out"),
            ),
            Text('Hello ${user?.displayName ?? ''}'),
          ],
        ),
      ),
    );
  }
}
