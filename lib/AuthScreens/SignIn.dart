// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, use_build_context_synchronously

import 'dart:convert';
import 'package:agva_app/AuthScreens/SignUp.dart';
import 'package:agva_app/Screens/Doctor&Assistant/DoctorHomeScreen.dart';
import 'package:agva_app/Screens/Doctor&Assistant/NurseHomeScreen.dart';
import 'package:agva_app/Screens/User/UserHomeScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../config.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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

  String mytoken = "token";

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
        if (jsonResponse['statusValue'] == 'SUCCESS') {
          print(jsonResponse);
          var data = jsonResponse['data'];
          
          var name = data['name'];
          var email = data['email'];
          var token = data['token'];
          var hospitalName = data['hospitalName'];
          var hospitalAddress = data['hospitalAddress'];
          var usertype = data['userType'];
          var userID = data['_id'];

          saveUsername(name);
          saveUseremail(email);
          saveToken(token);
          saveHospital(hospitalName);
          saveHospitalAddress(hospitalAddress);
          saveusertype(usertype);
          saveuserID(userID);

          if (usertype == 'User') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserHomeScreen({
                  'hospitalName': hospitalName,
                  'name': name,
                  'hospitalAddress': hospitalAddress
                }),
              ),
            );
          } else if (usertype == 'Assistant') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => NurseHomeScreen({
                  'hospitalName': hospitalName,
                  'name': name,
                  'hospitalAddress': hospitalAddress
                }),
              ),
            );
          } else if (usertype == 'Doctor') {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorHomeScreen({
                  'hospitalName': hospitalName,
                  'name': name,
                  'hospitalAddress': hospitalAddress
                }),
              ),
            );
          }
        } else {
          print('Invalid User Credential: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  Future<void> saveUsername(String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    print('Saved username: $name');
  }

  Future<void> saveUseremail(String email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    print('Saved useremail: $email');
  }

  Future<void> saveToken(String mytoken) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('mytoken', mytoken);
  }

  Future<void> saveuserID(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('userID', userID);
  }

  Future<void> saveHospital(String hospitalName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hospitalName', hospitalName);
    print('Saved hospital name: $hospitalName');
  }

  Future<void> saveHospitalAddress(String hospitalAddress) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('hospitalAddress', hospitalAddress);
    print('Saved hospital address: $hospitalAddress');
  }

  Future<void> saveusertype(String usertype) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('usertype', usertype);
    print('Saved usertype: $usertype');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
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
                        color: Color.fromARGB(255, 181, 0, 100),
                      ),
                    ),
                    SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: emailController,
                        //     validator: (value) {
                        //   if (value == null || value.isEmpty) {
                        //     return 'Please enter email';
                        //   }
                        //   return null;
                        // },
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.white70),
                          // errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Colors.white70),
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: TextFormField(
                        controller: passwordController,
                        obscureText: passwordVisible,
                        style: TextStyle(color: Colors.white70),
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.white70),
                          hintText: 'Enter your Password',
                          // errorText: _isNotValidate ? "Enter Proper Info" : null,
                          hintStyle: TextStyle(color: Colors.white70),
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
                    // Padding(
                    //   padding: const EdgeInsets.fromLTRB(230, 20, 0, 0),
                    //   child: Row(
                    //     children: [
                    //       InkWell(
                    //         child: Text(
                    //           "Forget Password ?",
                    //           style: TextStyle(
                    //               color: Colors.white70, fontSize: 14),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
      ),
    );
  }
}
