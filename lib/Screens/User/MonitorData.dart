// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable

import 'dart:convert';
import 'package:agva_app/config.dart';
import 'package:agva_app/widgets/Alarms.dart';
import 'package:agva_app/widgets/Calibration.dart';
import 'package:agva_app/widgets/CrashLogs.dart';
import 'package:agva_app/widgets/Events.dart';
import 'package:agva_app/widgets/Trends.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class MonitorData extends StatefulWidget {
  final String deviceId;

  MonitorData(this.deviceId);

  @override
  _MonitorDataState createState() => _MonitorDataState();
}

class _MonitorDataState extends State<MonitorData> {
  bool isLoading = true;
  late String deviceId;
  String activeButton = 'Events';
  String activeButtonColor = 'Events';
  late Map<String, dynamic> jsonResponse;

  @override
  void initState() {
    super.initState();
    deviceId = widget.deviceId;
    getEventusingId();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    super.dispose();
  }

  Future<void> getEventusingId() async {
    var response = await http.get(
      Uri.parse('$getDeviceEventbyID/$deviceId'),
    );
    jsonResponse = jsonDecode(response.body);
    print('Current Device ID: $deviceId');
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
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 157, 0, 86),
                        ),
                        child: Row(
                          children: [
                            buildButton('Events'),
                            buildButton('Alarms'),
                            buildButton('Crash Logs'),
                            buildButton('Trends'),
                            buildButton('Calibration'),
                          ],
                        ),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width * 1,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color.fromARGB(255, 65, 65, 65),
                        ),
                        child: buildBigContainerContent(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromRGBO(255, 255, 255, 0.5)),
            child: FloatingActionButton(
              backgroundColor: Colors.transparent,
              onPressed: () => {Navigator.pop(context)},
              child: Icon(Icons.arrow_back),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildButton(String buttonName) {
    bool isActive = activeButton == buttonName;
    Color buttonColor = isActive
        ? Color.fromARGB(255, 249, 249, 249)
        : Color.fromARGB(255, 157, 0, 86);
    Color textColor = isActive ? Colors.black87 : Colors.white;

    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Container(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.09,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: buttonColor,
        ),
        child: GestureDetector(
          onTap: () {
            setActiveButton(buttonName);
          },
          child: Text(
            buttonName,
            style: TextStyle(
                color: textColor, fontSize: 12, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  void setActiveButton(String button) {
    setState(() {
      activeButton = button;
    });
  }

  Widget buildBigContainerContent() {
    switch (activeButton) {
      case 'Events':
        return isLoading ? buildLoading() : Events(deviceId);
      case 'Alarms':
        return isLoading ? buildLoading() : Alarms(deviceId);
      case 'Crash Logs':
        return isLoading ? buildLoading() : CrashLogs(deviceId);
      case 'Trends':
        return isLoading ? buildLoading() : Trends(deviceId);
      case 'Calibration':
        return isLoading ? buildLoading() : Calibration(deviceId);
      default:
        return Container();
    }
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
