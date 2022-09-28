import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../components/reusable_widget.dart';
import '../utils/colors_patch.dart';
import 'home_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _usernameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _firstTextController = TextEditingController();
  TextEditingController _lastTextController = TextEditingController();
  TextEditingController _countryTextController = TextEditingController();

  Future adduserDetails(String userName, String firstName, String lastName,
      String country, String email) async {
    await FirebaseFirestore.instance.collection("users").add({
      'username': userName,
      'first_name': firstName,
      'last_name': lastName,
      'country': country,
      'email': email
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Sign Up"),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
            stringToColour("FF512F"),
            stringToColour("9546C4"),
            stringToColour("DD2476")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                  20, MediaQuery.of(context).size.height * 0.2, 20, 0),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 30,
                  ),
                  reusableTextField("Enter Username", Icons.person_outline,
                      false, _usernameTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter First Name", Icons.person_outline,
                      false, _firstTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Last Name", Icons.person_outline,
                      false, _lastTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Country", Icons.location_city, false,
                      _countryTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Email", Icons.person_outline, false,
                      _emailTextController),
                  SizedBox(
                    height: 20,
                  ),
                  reusableTextField("Enter Password", Icons.lock_outline, true,
                      _passwordTextController),
                  SizedBox(
                    height: 20,
                  ),
                  loginSignupButton(context, false, () {
                    FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                            email: _emailTextController.text.trim(),
                            password: _passwordTextController.text.trim())
                        .then((value) {
                      print("Created New Account");

                      // FirebaseFirestore.instance.collection('users').add({
                      //   'user_name': _usernameTextController.text,
                      //   'first_name': _firstTextController.text,
                      //   'last_name': _lastTextController.text,
                      //   'country': _countryTextController.text,
                      //   'email': _emailTextController.text
                      // });
                      adduserDetails(
                          _usernameTextController.text.trim(),
                          _firstTextController.text.trim(),
                          _lastTextController.text.trim(),
                          _countryTextController.text.trim(),
                          _emailTextController.text.trim());
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomeScreen()));
                    }).onError((error, stackTrace) {
                      print("Error ${error.toString()}");
                    });
                  }),
                ],
              ),
            ),
          ),
        ));
  }
}
