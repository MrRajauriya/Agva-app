// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../Screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';
import './SignUp.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // bool _isNotValidate = false;

  bool passwordVisible = true;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  void signIn() async {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      try {
        var response = await http.post(
          Uri.parse(loginUser),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": emailController.text,
            "passwordHash": passwordController.text,
          }),
        );

        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        if (jsonResponse['statusValue'] == 'SUCCESS') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomeScreen()),
          );
        } else {
          print('Invalid User Credential: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.white, Colors.white],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Text(
                    "AgVa",
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      fontSize: 60,
                      color: Color.fromARGB(255, 157, 0, 86),
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: emailController,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.black87),
                        // errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintText: 'Enter your email',
                        hintStyle: TextStyle(color: Colors.black45),
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: passwordVisible,
                      style: TextStyle(color: Colors.black87),
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Colors.black87),
                        hintText: 'Enter your Password',
                        // errorText: _isNotValidate ? "Enter Proper Info" : null,
                        hintStyle: TextStyle(color: Colors.black45),
                        suffixIcon: IconButton(
                          icon: Icon(passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(230, 20, 0, 0),
                    child: Row(
                      children: [
                        InkWell(
                          child: Text(
                            "Forget Password ?",
                            style:
                                TextStyle(color: Colors.black87, fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                    child: Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 20,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 218, 0, 138),
                            Color.fromARGB(255, 142, 0, 90),
                          ],
                        ),
                      ),
                      child: TextButton(
                        onPressed: signIn,
                        style: TextButton.styleFrom(),
                        child: Text(
                          "SIGN IN",
                          style: TextStyle(color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                    child: Container(
                      height: 45,
                      width: 300,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 20,
                            offset: Offset(0, 3),
                          ),
                        ],
                        color: Colors.white,
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color.fromARGB(255, 255, 255, 255),
                            Color.fromARGB(255, 255, 255, 255),
                          ],
                        ),
                      ),
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp(),
                            ),
                          );
                        },
                        style: TextButton.styleFrom(),
                        child: Text(
                          "SIGN UP",
                          style: TextStyle(
                            color: Color.fromARGB(255, 157, 0, 86),
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
