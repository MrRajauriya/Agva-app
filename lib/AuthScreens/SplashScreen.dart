import 'dart:async';
import 'package:agva_app/Screens/Doctor&Assistant/DoctorHomeScreen.dart';
import 'package:agva_app/Screens/Doctor&Assistant/NurseHomeScreen.dart';
import 'package:agva_app/Screens/User/UserHomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './SignIn.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getUserType();
    Timer(Duration(seconds: 2), () {
      checkIfLoggedIn();
    });
  }

  Future<String?> getUserType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? usertype = prefs.getString('usertype');
    print('Retrieved usertype: $usertype');
    return usertype;
  }

  Future<void> checkIfLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String storedToken = prefs.getString('mytoken') ?? "";
    String usertype = prefs.getString('usertype') ?? "";

    if (storedToken.isNotEmpty) {
      if (usertype == 'User') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => UserHomeScreen({})),
        );
      } else if (usertype == 'Assistant') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NurseHomeScreen({})),
        );
      } else if (usertype == 'Doctor') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => DoctorHomeScreen({})),
        );
      }
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignIn()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/AGVA.gif",
              width: 200,
              height: 200,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
