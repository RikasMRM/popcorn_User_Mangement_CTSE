import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:flutter_user_login_reg/screens/edit_profile.dart';
import 'package:flutter_user_login_reg/screens/home_screen.dart';
import 'package:flutter_user_login_reg/screens/login_screen.dart';
import 'package:flutter_user_login_reg/screens/signup_screen.dart';
import 'package:flutter_user_login_reg/screens/userProfile.dart';

// import 'screens/add_event.dart';
// import 'screens/add_inquiry.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Popcorn',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Login_Screen(),
        '/signup': (context) => const SignUp_Screen(),
        '/home': (context) => const HomeScreen(),
        '/userprofile': (context) => ProfilePage(),
        '/edit_profile': (context) => EditProfilePage(),
      },
    );
  }
}
