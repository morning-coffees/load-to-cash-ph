import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loadtocashph/models/user_model.dart';
import 'package:loadtocashph/providers/auth_provider.dart';
import 'package:loadtocashph/providers/user_provider.dart';
import 'package:loadtocashph/widgets/chat_tile.dart';

import 'package:loadtocashph/theme.dart';
import 'package:loadtocashph/widgets/user_profile_view.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // UserModel? userModel;

  // _initUserModel(context) async {
  //   await Provider.of<UserProvider>(context, listen: false)
  //       .getCurrentUser()
  //       .then((value) {
  //     setState(() {
  //       userModel = value;
  //     });
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // _initUserModel(context);
    return Scaffold(
      backgroundColor: blueColor,
      floatingActionButton: FloatingActionButton(
        backgroundColor: greenColor,
        onPressed: () {},
        child: const Icon(
          Icons.add,
          size: 28,
        ),
      ),
      body: SafeArea(
          child: Center(
        child: SingleChildScrollView(
          child: Column(children: [
            ElevatedButton(
              onPressed: () {
                context.read<AuthProvider>().signOut();
              },
              child: const Text("Sign out"),
            ),
            FutureBuilder(
              future: Provider.of<UserProvider>(context, listen: false)
                  .getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const UserProfileView(
                    imageUrl:
                        'https://lh3.googleusercontent.com/a/AATXAJwqNXMRg3zT8aCmMVZepNrKL3SsFmt4DSQQGQyc=s96-c',
                    displayName: 'Loading...',
                  );
                } else {
                  UserModel um = snapshot.data as UserModel;
                  return UserProfileView(
                    imageUrl: um.photoUrl,
                    displayName: um.displayName,
                  );
                }
              },
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                  color: whiteColor,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(40),
                  )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Friends',
                    style: titleTextStyle,
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/friend1.png',
                    name: 'Susi Susanti',
                    text: 'Ws madang urung mbok ?',
                    time: 'NOW',
                    isRead: true,
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/friend2.png',
                    name: 'Jamludin',
                    text: 'Mabar Gan ╰(*°▽°*)╯',
                    time: '15.23',
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/friend2.png',
                    name: 'Bambang',
                    text: 'ಥ_ಥ',
                    time: '15.00',
                    isRead: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Groups',
                    style: titleTextStyle,
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/group1.png',
                    name: 'Moba Analog',
                    text: 'Why does everyone ca...',
                    time: '11.11',
                    isRead: true,
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/group2.png',
                    name: 'Anak Mamah',
                    text: 'Mama mana woy!!',
                    time: '11.00',
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/group3.png',
                    name: 'Bar Bar Esport',
                    text: 'By one tod',
                    time: '23.00',
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/group2.png',
                    name: 'IT Inventory',
                    text: 'Hiks',
                    time: '23.00',
                    isRead: true,
                  ),
                  const ChatTile(
                    imageUrl: 'assets/images/group3.png',
                    name: 'Bar Bar Esport',
                    text: 'By one tod',
                    time: '23.00',
                  ),
                ],
              ),
            )
          ]),
        ),
      )),
    );
  }
}
