import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import "package:flutter/material.dart";

import '../model/user_model.dart';
import '../services/auth_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedPage = 0;
  PageController pageController = PageController();

  //authservice
  final AuthService _auth = AuthService();
  user_model currentUser = user_model();

  @override
  void initState() {
    // init state
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .get()
        .then((val) {
      setState(() {
        currentUser = user_model.fromMap(val.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "popcorn",
          style: TextStyle(
              color: Colors.red, fontWeight: FontWeight.w600, fontSize: 25),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout_rounded,
              color: Colors.red,
              size: 35,
            ),
            onPressed: () {
              _auth.signOut();
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Signed Out Successfully')));
              Navigator.pushReplacementNamed(context, '/');
            },
            padding: const EdgeInsets.only(right: 10),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/userprofile');
            },
            child: Padding(
                padding: EdgeInsets.all(9.0),
                child: currentUser.imagePath != null
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.imagePath!),
                      )
                    : const CircleAvatar(
                        backgroundImage: NetworkImage(
                            'https://firebasestorage.googleapis.com/v0/b/popcornauth-ac9bf.appspot.com/o/Dpppp.png?alt=media&token=a3c89c52-1755-4dda-9965-5facf94858ab'),
                      )),
          ),
        ],
      ),
    );
  }
}
