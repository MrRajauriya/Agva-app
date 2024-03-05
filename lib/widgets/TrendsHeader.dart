// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

class TrendsHeader extends StatelessWidget {
  const TrendsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Color.fromARGB(255, 121, 121, 121),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Text(
                    'Parameter',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Text(
                'Mode',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'PIP',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'PEEP',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'Mean Airway',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'VTi',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'VTe',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'MVe',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'MVi',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'FiO2',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'RR',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'I:E',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'Tinsp',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              // Text(
              //   'Texp',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Color.fromARGB(255, 218, 218, 218),
              //   ),
              // ),
              // Text(
              //   'Average Leak',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Color.fromARGB(255, 218, 218, 218),
              //   ),
              // ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                color: Color.fromARGB(255, 121, 121, 121),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                  child: Text(
                    'Unit',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ),
              Text(
                'Mode Type',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'cmH20',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'cmH20',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'cmH20',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'ml',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'ml',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'Litre',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'Litre',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                '%',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'BPM',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'Ratio',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              Text(
                'sec',
                style: TextStyle(
                  fontSize: 12,
                  color: Color.fromARGB(255, 218, 218, 218),
                ),
              ),
              // Text(
              //   'sec',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Color.fromARGB(255, 218, 218, 218),
              //   ),
              // ),
              // Text(
              //   '%',
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: Color.fromARGB(255, 218, 218, 218),
              //   ),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
