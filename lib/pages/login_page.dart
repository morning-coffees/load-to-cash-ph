import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loadtocashph/models/user_model.dart';
import 'package:loadtocashph/providers/auth_provider.dart';
import 'package:loadtocashph/providers/user_provider.dart';
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
    User? user = context.watch<AuthProvider>().user;
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
            ElevatedButton(
              onPressed: () {
                // AuthProvider.instance.getAccountCredential();
                // context.read<AuthProvider>().streamUsers();
              },
              child: const Text("Tester ---------------------"),
            ),
            StreamBuilder(
                stream: context.read<UserProvider>().streamUsers(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    shrinkWrap: true,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return ListTile(title: Text(data['messages'][1]));
                    }).toList(),
                  );
                }),
            Text('Hello ${user?.displayName ?? ''}'),
          ],
        ),
      ),
    );
  }
}
