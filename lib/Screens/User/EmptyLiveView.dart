// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_import, unnecessary_string_interpolations, use_key_in_widget_constructors
import 'dart:math';
import 'package:agva_app/widgets/LineChartWidget.dart';
import 'package:agva_app/widgets/animatedChart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmptyLiveView extends StatefulWidget {
  @override
  _EmptyLiveViewState createState() => _EmptyLiveViewState();
}

class _EmptyLiveViewState extends State<EmptyLiveView> {
  String selectedMenu = 'GRAPHS';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //header
                  Header(),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.002,
                  ),
                  //buttons & graphs & tiles
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      //Side menu buttons
                      MenuButtons(
                        selectedMenu,
                        (menu) {
                          setState(() {
                            selectedMenu = menu;
                          });
                        },
                      ),

                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.002,
                      ),
                      //graph screen
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 0.74,
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Data screen
                              if (selectedMenu == 'DATA') DataScreen(),
                              if (selectedMenu == 'GRAPHS')
                                Column(
                                  children: [
                                    Container(
                                      // height:
                                      //     MediaQuery.of(context).size.height *
                                      //         0.5,
                                      width: MediaQuery.of(context).size.width *
                                          0.72,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 0, 0, 0),
                                      ),
                                              child: MyLineChart()
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    // Container(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.2,
                                    //   width: MediaQuery.of(context).size.width *
                                    //       0.76,
                                    //   decoration: BoxDecoration(
                                    //     color: Color.fromARGB(255, 0, 0, 0),
                                    //   ),
                                    //           child: MyLineChart()
                                    // ),
                                    // SizedBox(
                                    //   height: 5,
                                    // ),
                                    // Container(
                                    //   height:
                                    //       MediaQuery.of(context).size.height *
                                    //           0.2,
                                    //   width: MediaQuery.of(context).size.width *
                                    //       0.76,
                                    //   decoration: BoxDecoration(
                                    //     color: Color.fromARGB(255, 0, 0, 0),
                                    //   ),
                                    //   child: MyLineChart()
                                    // ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.002,
                      ),

                      //secondaryobserverdata tiles
                      Tiles(),
                    ],
                  ),

                  BottomTiles(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuButtons extends StatelessWidget {
  final String selectedMenu;
  final Function(String) onMenuSelected;

  MenuButtons(this.selectedMenu, this.onMenuSelected);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildMenuButton(context, 'DATA'),
            buildMenuButton(context, 'ALARMS'),
            buildMenuButton(context, 'LOOPS'),
            buildMenuButton(context, 'GRAPHS'),
            buildMenuButton(context, 'MODES'),
            buildMenuButton(context, 'CONTROLS'),
            buildMenuButton(context, 'SYSTEM'),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String menu) {
    bool isSelected = selectedMenu == menu;
    return GestureDetector(
      onTap: () {
        onMenuSelected(menu);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.13,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Color.fromARGB(255, 8, 8, 8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                menu,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: isSelected
                      ? Colors.black
                      : Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.015,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.all(25),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 0, 0, 0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              child: Column(
                children: [
                  Text(
                    '-',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      color: Color.fromARGB(255, 136, 136, 136),
                      fontSize: MediaQuery.of(context).size.width * 0.01,
                    ),
                  ),
                  Text(
                    '-',
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      color: Color.fromARGB(255, 218, 218, 218),
                      fontSize: MediaQuery.of(context).size.width * 0.02,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //mode
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color.fromARGB(255, 32, 76, 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.015,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          //patient details
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UHID22554484',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                    Text(
                      '45 Years',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.015,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '33 cms',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                    Text(
                      '52 kg',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.015,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '09-12-2023',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                    Text(
                      '00:08:25',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          //alarm box
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: Color.fromARGB(255, 188, 138, 0),
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          //action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/alarm.png",
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Image.asset(
                "assets/images/bettery.png",
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Image.asset(
                "assets/images/plug.png",
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              GestureDetector(
                // onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingScreen()))},
                onTap: () => {Navigator.pop(context)},
                child: Image.asset(
                  "assets/images/exit.png",
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          // pr spo2
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width * 0.16,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'PR',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    Text(
                      '-',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'SpO2',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    Text(
                      '-',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomTiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 8, 8, 8),
      ),
      child: Row(children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'FiO2',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Ti',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'RR',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Trigger',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'PEEP',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Psupp',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: MediaQuery.of(context).size.height * 0.11,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.symmetric(
              vertical: BorderSide(
                color: const Color.fromARGB(255, 90, 90, 90),
              ),
            ),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Pinsp',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 136, 136, 136),
                    fontSize: MediaQuery.of(context).size.width * 0.012,
                  ),
                ),
                Text(
                  '-',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.022,
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

class Tiles extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PIP',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: MediaQuery.of(context).size.width * 0.012,
                          ),
                        ),
                        Text(
                          // entry.value,
                          '-',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'PEEP',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: MediaQuery.of(context).size.width * 0.012,
                          ),
                        ),
                        Text(
                          // entry.value,
                          '-',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'VTi',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: MediaQuery.of(context).size.width * 0.012,
                          ),
                        ),
                        Text(
                          // entry.value,
                          '-',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'RR',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: MediaQuery.of(context).size.width * 0.012,
                          ),
                        ),
                        Text(
                          // entry.value,
                          '-',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ]))),
      Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'FiO2',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: MediaQuery.of(context).size.width * 0.012,
                          ),
                        ),
                        Text(
                          // entry.value,
                          '-',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.022,
                          ),
                        ),
                      ],
                    ),
                  ]))),
    ]);
  }
}
