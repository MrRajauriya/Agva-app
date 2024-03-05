// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

class BlankScreen extends StatelessWidget {
  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Image.asset("assets/images/Nodevicefound.png"),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'No device found',
            style: TextStyle(
                fontFamily: 'Avenir',
                color: Colors.white70,
                fontSize: MediaQuery.of(context).size.width * 0.05,
                fontWeight: FontWeight.w200),
          ),
        ],
      )),
    );
  }
}
