import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loadtocashph/pages/home_page.dart';
import 'package:loadtocashph/pages/login_page.dart';
import 'package:loadtocashph/pages/message_page.dart';
import 'package:loadtocashph/providers/auth_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      initialRoute: LoginPage.routeName,
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        LoginPage.routeName: (context) => const LoginPage(),
        // When navigating to the "/second" route, build the SecondScreen widget.
        HomePage.routeName: (context) => const HomePage(),
        MessagePage.routeName: (context) => const MessagePage(),
      },
    );
  }
}
