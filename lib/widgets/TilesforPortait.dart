// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TilesforPortait extends StatelessWidget {
  final String title;
  final String value;
  final String unit;
  final double width;

  TilesforPortait({
    required this.title,
    this.value = '',
    this.unit = '',
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.065,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Color.fromARGB(255, 87, 87, 87),
        // color: Color.fromARGB(255, 86, 160, 198),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.005,
                ),
                Text(
                  unit,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
              ],
            ),
            Text(
              '$value',
              style: TextStyle(
                fontFamily: 'Avenir',
                color: Color.fromARGB(255, 218, 218, 218),
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
