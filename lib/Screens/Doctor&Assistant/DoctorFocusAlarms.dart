
// ignore_for_file: prefer_const_constructors, must_be_immutable, library_private_types_in_public_api, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'package:agva_app/Screens/Doctor&Assistant/DoctorAlarmList.dart';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;




class DoctorFocusAlarms extends StatefulWidget {
  @override
  _DoctorFocusAlarmsState createState() => _DoctorFocusAlarmsState();
}

class _DoctorFocusAlarmsState extends State<DoctorFocusAlarms> {
  List<Map<String, dynamic>> focusedDevices = [];
  bool isLoading = true;
  Color? newColor;

  @override
  void initState() {
    super.initState();
    fetchFocusedDevices();
  }

  Future<void> fetchFocusedDevices() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');

    if (mytoken != null) {
      var response = await http.get(
        Uri.parse(getDeviceForDoctor),
        headers: {
          "Authorization": 'Bearer $mytoken',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse['data']['data'];
        setState(() {
          isLoading = false;
          focusedDevices = List<Map<String, dynamic>>.from(data)
              .where((device) => device['addTofocus'] == true)
              .toList();
        });
      } else {
        print('Failed to fetch focused devices: ${response.statusCode}');
      }
    } else {
      print("Token is null");
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
              'My Devices',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return SingleChildScrollView(
                child: DevicelistsPortrait(
                  focusedDevices: focusedDevices,
                  isLoading: isLoading,
                  // alarmPriority:,
                ),
              );
            } else {
              return SingleChildScrollView(
                child: DevicelistsLandscape(
                  focusedDevices: focusedDevices,
                  isLoading: isLoading,
                ),
              );
            }
          })),
    );
  }
}

class DevicelistsPortrait extends StatelessWidget {
  late bool isLoading;

  DevicelistsPortrait({
    super.key,
    required this.focusedDevices,
    required this.isLoading,
  });
  final List<Map<String, dynamic>> focusedDevices;

  @override
  Widget build(BuildContext context) {
    Color? newColor;

    return Column(
      children: [
        if (isLoading)
          SizedBox(
              height: 1, child: LinearProgressIndicator(color: Colors.pink))
        else
          for (var device in focusedDevices)
            Builder(builder: (context) {
              if (device['alarmData'] != null &&
                  device['alarmData'].isNotEmpty) {
                var priority = device['alarmData'][0]['priority'];
                if (priority == 'ALARM_LOW_LEVEL' ||
                    priority == 'ALARM_MEDIUM_LEVEL') {
                  newColor = Colors.amber;
                } else if (priority == 'ALARM_HIGH_LEVEL' ||
                    priority == 'ALARM_CRITICAL_LEVEL') {
                  newColor = Colors.red;
                } else {
                  newColor = Colors.green;
                }
              } else {
                // Handle the case when alarmData is null or empty
                newColor = Colors.green; // Or any default color
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GestureDetector(
                       onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorAlarmList(
                                device['deviceInfo']?[0]?['DeviceId'],
                                device['deviceInfo']?[0]?['Hospital_Name'],
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: newColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 174, 34, 104)),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.12,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 65, 65, 65),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 11, vertical: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${device['deviceInfo']?[0]?['DeviceType']}',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Text(
                                              '${device['deviceInfo']?[0]?['Hospital_Name']}',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.005,
                                            ),
                                            Text(
                                              'Ward No. ${device['deviceInfo']?[0]?['Ward_No']}',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              'PT. Salim Raza',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.04,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.02,
                                            ),
                                            Text(
                                              '24 YEARS',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.01,
                                            ),
                                            Text(
                                              '58 KG',
                                              style: TextStyle(
                                                fontFamily: 'Avenir',
                                                color: Color.fromARGB(
                                                    255, 218, 218, 218),
                                                fontSize: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.03,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ],
    );
  }
}

class DevicelistsLandscape extends StatelessWidget {
  late bool isLoading;

  DevicelistsLandscape(
      {super.key, required this.focusedDevices, required this.isLoading});

  final List<Map<String, dynamic>> focusedDevices;

  @override
  Widget build(BuildContext context) {
    Color? newColor;
    return Column(
      children: [
        if (isLoading)
          SizedBox(
              height: 1, child: LinearProgressIndicator(color: Colors.pink))
        else
          for (var device in focusedDevices)
            Builder(builder: (context) {
              if (device['alarmData'] != null &&
                  device['alarmData'].isNotEmpty) {
                var priority = device['alarmData'][0]['priority'];
                if (priority == 'ALARM_LOW_LEVEL' ||
                    priority == 'ALARM_MEDIUM_LEVEL') {
                  newColor = Colors.amber;
                } else if (priority == 'ALARM_HIGH_LEVEL' ||
                    priority == 'ALARM_CRITICAL_LEVEL') {
                  newColor = Colors.red;
                } else {
                  newColor = Colors.green;
                }
              } else {
                // Handle the case when alarmData is null or empty
                newColor = Colors.green; // Or any default color
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 150),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      for (var device in focusedDevices)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: GestureDetector(
                            onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorAlarmList(
                                device['deviceInfo']?[0]?['DeviceId'],
                                device['deviceInfo']?[0]?['Hospital_Name'],
                              ),
                            ),
                          );
                        },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: newColor
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color.fromARGB(255, 174, 34, 104)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.3,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Color.fromARGB(255, 65, 65, 65),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 11, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  '${device['deviceInfo']?[0]?['DeviceType']}',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color.fromARGB(
                                                        255, 218, 218, 218),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015,
                                                ),
                                                Text(
                                                  '${device['deviceInfo']?[0]?['Hospital_Name']}',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color.fromARGB(
                                                        255, 218, 218, 218),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.015,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                ),
                                                Text(
                                                  'Ward No. ${device['deviceInfo']?[0]?['Ward_No']}',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color.fromARGB(
                                                        255, 218, 218, 218),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.015,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Text(
                                                  'PT. Salim Raza',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color.fromARGB(
                                                        255, 218, 218, 218),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.02,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.015,
                                                ),
                                                Text(
                                                  '24 YEARS',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color.fromARGB(
                                                        255, 218, 218, 218),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.015,
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.005,
                                                ),
                                                Text(
                                                  '58 KG',
                                                  style: TextStyle(
                                                    fontFamily: 'Avenir',
                                                    color: Color.fromARGB(
                                                        255, 218, 218, 218),
                                                    fontSize:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.015,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
