// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable, curly_braces_in_flow_control_structures
import 'dart:convert';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AlarmList extends StatefulWidget {
  final String deviceId;
  final String hospital_Name;

  AlarmList(this.deviceId, this.hospital_Name);

  @override
  AlarmListState createState() => AlarmListState();
}

class AlarmListState extends State<AlarmList> {
  bool isLoading = true;
  late String deviceId;
  late String hospital_Name;
  late Map<String, dynamic> jsonResponse;
  Color? newColor;

  @override
  void initState() {
    super.initState();
    deviceId = widget.deviceId;
    hospital_Name = widget.hospital_Name;
    getAlarmbyId();
  }

  Future<void> getAlarmbyId() async {
    var response = await http.get(
      Uri.parse('$getDeviceAlarmsbyID/$deviceId?page=1&limit=5'),
    );
    jsonResponse = jsonDecode(response.body);
    print('Current Device ID: $jsonResponse');
    if (jsonResponse['statusCode'] == 200) {
      setState(() {
        isLoading = false;
      });
    } else {
      print('Invalid User Credential: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              'Alarms',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return SingleChildScrollView(child: portraitAlarm());
            } else {
              return SingleChildScrollView(child: landscapeAlarm());
            }
          })),
    );
  }

  Container portraitAlarm() {
    return Container(
      child: Column(
        children: [
          if (isLoading)
            SizedBox(
                height: 1, child: LinearProgressIndicator(color: Colors.pink))
          else if (jsonResponse['data']['findDeviceById'].isEmpty)
            buildEmptyContainer()
          else
            for (var alarmData in jsonResponse['data']['findDeviceById'])
              _buildPortraitAlarmsList(alarmData),
        ],
      ),
    );
  }

  Widget _buildPortraitAlarmsList(Map<String, dynamic> alarmData) {
    Color? newColor;
    Color? textColor;

    if (alarmData['priority'] == 'ALARM_LOW_LEVEL') {
      newColor = Colors.amber;
      textColor = Colors.black;
    } else if (alarmData['priority'] == 'ALARM_MEDIUM_LEVEL') {
      newColor = Colors.amber;
      textColor = Colors.black;
    } else {
      newColor = Colors.red;
      textColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(100, 73, 73, 73),
              ),
              height: MediaQuery.of(context).size.height * 0.12,
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                        ),
                        color: newColor),
                    height: MediaQuery.of(context).size.height * 0.04,
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        alarmData['ack']['msg'],
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          color: textColor,
                          fontSize: MediaQuery.of(context).size.width * 0.03,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  alarmData['ack']['date'],
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      color: Color.fromARGB(255, 218, 218, 218),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.w200),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  alarmData['ack']['time'],
                                  style: TextStyle(
                                      fontFamily: 'Avenir',
                                      color: Color.fromARGB(255, 218, 218, 218),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.03,
                                      fontWeight: FontWeight.w200),
                                ),
                              ],
                            ),
                            Text(
                              hospital_Name,
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'Ward No. 14',
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.w200),
                            ),
                            Text(
                              'PT. Salim Raza',
                              style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                  fontWeight: FontWeight.w200),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container landscapeAlarm() {
    return Container(
      child: Column(
        children: [
          if (isLoading)
            SizedBox(
                height: 0.5, child: LinearProgressIndicator(color: Colors.pink))
          else if (jsonResponse['data']['findDeviceById'].isEmpty)
            buildEmptyContainer()
          else
            for (var alarmData in jsonResponse['data']['findDeviceById'])
              _buildLandscapeAlarmsList(alarmData),
        ],
      ),
    );
  }

  Widget _buildLandscapeAlarmsList(Map<String, dynamic> alarmData) {
    Color? newColor;
    Color? textColor;

    if (alarmData['priority'] == 'ALARM_LOW_LEVEL') {
      newColor = Colors.amber;
      textColor = Colors.black;
    } else if (alarmData['priority'] == 'ALARM_MEDIUM_LEVEL') {
      newColor = Colors.amber;
      textColor = Colors.black;
    } else {
      newColor = Colors.red;
      textColor = Colors.white;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color.fromARGB(100, 73, 73, 73),
              ),
              height: MediaQuery.of(context).size.height * 0.16,
              width: double.infinity,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color: newColor),
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Center(
                    child: Text(
                      alarmData['ack']['msg'],
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: textColor,
                        fontSize: MediaQuery.of(context).size.width * 0.015,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.015,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.16,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            alarmData['ack']['date'],
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.01,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            alarmData['ack']['time'],
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.01,
                                fontWeight: FontWeight.w200),
                          ),
                          Text(
                            'Ward No. 14',
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.01,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            hospital_Name,
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.01,
                                fontWeight: FontWeight.w200),
                          ),
                          SizedBox(
                            width: 3,
                          ),
                          Text(
                            'PT. Salim Raza',
                            style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.01,
                                fontWeight: FontWeight.w200),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
              // child: Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.all(15.0),
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.start,
              //             children: [
              //               Row(
              //                 children: [
              //                   Text(
              //                     alarmData['ack']['date'],
              //                     style: TextStyle(
              //                         fontFamily: 'Avenir',
              //                         color: Color.fromARGB(255, 218, 218, 218),
              //                         fontSize:
              //                             MediaQuery.of(context).size.width *
              //                                 0.03,
              //                         fontWeight: FontWeight.w200),
              //                   ),
              //                   SizedBox(
              //                     width: 5,
              //                   ),
              //                   Text(
              //                     alarmData['ack']['time'],
              //                     style: TextStyle(
              //                         fontFamily: 'Avenir',
              //                         color: Color.fromARGB(255, 218, 218, 218),
              //                         fontSize:
              //                             MediaQuery.of(context).size.width *
              //                                 0.03,
              //                         fontWeight: FontWeight.w200),
              //                   ),
              //                 ],
              //               ),
              //               Text(
              //                 hospital_Name,
              //                 style: TextStyle(
              //                     fontFamily: 'Avenir',
              //                     color: Color.fromARGB(255, 218, 218, 218),
              //                     fontSize:
              //                         MediaQuery.of(context).size.width * 0.03,
              //                     fontWeight: FontWeight.w200),
              //               ),
              //             ],
              //           ),
              //           Column(
              //             crossAxisAlignment: CrossAxisAlignment.end,
              //             children: [
              //               Text(
              //                 'Ward No. 14',
              //                 style: TextStyle(
              //                     fontFamily: 'Avenir',
              //                     color: Color.fromARGB(255, 218, 218, 218),
              //                     fontSize:
              //                         MediaQuery.of(context).size.width * 0.03,
              //                     fontWeight: FontWeight.w200),
              //               ),
              //               Text(
              //                 'PT. Salim Raza',
              //                 style: TextStyle(
              //                     fontFamily: 'Avenir',
              //                     color: Color.fromARGB(255, 218, 218, 218),
              //                     fontSize:
              //                         MediaQuery.of(context).size.width * 0.03,
              //                     fontWeight: FontWeight.w200),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //     )
              //   ],
              // ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyContainer() {
    return SizedBox(
        height: MediaQuery.of(context).size.height / 1.3,
        child: Center(
          child: Text(
            'No alarms',
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Color.fromARGB(255, 218, 218, 218),
              fontSize: MediaQuery.of(context).size.width * 0.05,
              fontWeight: FontWeight.w100,
            ),
          ),
        ));
  }
}
