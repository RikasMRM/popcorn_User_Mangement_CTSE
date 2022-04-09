import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_user_login_reg/screens/signup_screen.dart';

import '../services/auth_service.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  //authservice
  final AuthService _auth = AuthService();

  //text editing controllers
  final TextEditingController username_controller = TextEditingController();
  final TextEditingController pwd_controller = TextEditingController();

  // form key for email and password validation
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //username field
    final username_field = TextFormField(
      autofocus: false,
      controller: username_controller,
      //style: TextStyle(color: Colors.red),
      keyboardType: TextInputType.emailAddress,
      //email field validation
      validator: (val) {
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(val!)) {
          return ("Please enter a valid username");
        }
        if (val.isEmpty) {
          return ("Please enter your username");
        }
        return null;
      },
      onSaved: (val) {
        username_controller.text = val!;
      },
      style: TextStyle(color: Colors.black),
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.mail),
          fillColor: Colors.white,
          filled: true,
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "username",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //password field
    final pwd_field = TextFormField(
      autofocus: false,
      controller: pwd_controller,
      obscureText: true,
      style: TextStyle(color: Colors.black),
      //password field validation
      validator: (val) {
        RegExp regex = new RegExp(r'^.{6,}$');
        if (val!.isEmpty) {
          return ("Password is required");
        }
        if (!regex.hasMatch(val)) {
          return ("Password should have min length of 6 characters");
        }
        return null;
      },
      onSaved: (val) {
        pwd_controller.text = val!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "password",
          fillColor: Colors.white,
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          )),
    );

    //login button
    final signInBtn = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () async {
              _auth
                  .signIn(
                      email: username_controller.text,
                      password: pwd_controller.text)
                  .then((value) {
                if (value == null) {
                  Fluttertoast.showToast(msg: "SignIn Successful");
                  Navigator.pushReplacementNamed(context, '/home');
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      value,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ));
                }
              });
            },
            minWidth: MediaQuery.of(context).size.width,
            child: const Text(
              "Sign In",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    //guest view button
    final guestViewBtn = Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(10),
        color: Colors.red,
        child: MaterialButton(
            padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
            onPressed: () async {
              dynamic result = await _auth.getOrCreateAnoUser();
              if (result == null) {
                print('error signing in');
              } else {
                print(result);
                Navigator.pushNamed(context, '/home');
              }
            },
            minWidth: MediaQuery.of(context).size.width,
            child: const Text(
              "As a Guest",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )));

    //signup_navigation
    return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: SingleChildScrollView(
              child: Container(
                  color: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.all(25.0),
                    child: Form(
                        key: formKey,
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                  height: 200,
                                  child: Image.asset(
                                    "assets/images/logo_popcorn.png",
                                    fit: BoxFit.contain,
                                  )),
                              const SizedBox(height: 50),
                              username_field,
                              const SizedBox(height: 20),
                              pwd_field,
                              const SizedBox(height: 40),
                              signInBtn,
                              const SizedBox(height: 20),
                              guestViewBtn,
                              const SizedBox(height: 20),

                              //account creation navigation
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Text(
                                    "Don't have an account? ",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const SignUp_Screen()),
                                      );
                                    },
                                    child: const Text(
                                      "SignUp",
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 15),
                                    ),
                                  ),
                                ],
                              ),
                            ])),
                  ))),
        ));
  }
}
