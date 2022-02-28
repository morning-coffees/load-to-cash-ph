import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loadtocashph/pages/home_page.dart';
import 'package:loadtocashph/pages/login_page.dart';
import 'package:loadtocashph/pages/message_page.dart';
import 'package:loadtocashph/providers/auth_provider.dart';
import 'package:loadtocashph/providers/user_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<AuthProvider>(context).user;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      home: (user != null ? const HomePage() : const LoginPage()),
      routes: {
        LoginPage.routeName: (context) => const LoginPage(),
        HomePage.routeName: (context) => const HomePage(),
        MessagePage.routeName: (context) => const MessagePage(),
      },
    );
  }
}
