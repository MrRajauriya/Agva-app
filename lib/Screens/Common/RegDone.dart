import 'dart:async';
import 'package:agva_app/AuthScreens/SignIn.dart';
import 'package:flutter/material.dart';

class RegDone extends StatefulWidget {
  const RegDone();

  @override
  State<RegDone> createState() => _RegDoneState();
}

class _RegDoneState extends State<RegDone> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 1), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => SignIn( )),
      );
    });
  }

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/RegDone.gif",
                width: 200,
                height: 200,
                fit: BoxFit.cover,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
