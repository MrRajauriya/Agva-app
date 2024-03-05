// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, dead_code, use_key_in_widget_constructors

import 'dart:convert';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CrashLogs extends StatefulWidget {
  final String deviceId;
  const CrashLogs(this.deviceId);

  @override
  State<CrashLogs> createState() => _CrashLogsState();
}

class _CrashLogsState extends State<CrashLogs> {
  bool isLoading = true;
  late String deviceId;
  late Map<String, dynamic> jsonResponse;

  @override
  void initState() {
    super.initState();
    deviceId = widget.deviceId;
    getCrashbyId();
  }

  Future<void> getCrashbyId() async {
    var response = await http.get(
      Uri.parse('$getDeviceCrashLogsbyID/$deviceId'),
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
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildColumnHeading('Device ID'),
                  buildColumnHeading('Message'),
                  buildColumnHeading('Version'),
                  buildColumnHeading('Date'),
                  buildColumnHeading('Time'),
                ],
              ),
            ),
            Container(
              height: 0.1,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            if (isLoading) 
              buildEmptyContainer2()
            else if (jsonResponse['data']['findDeviceById']
                .isEmpty) 
              buildEmptyContainer()
            else
              for (var crashData in jsonResponse['data']['findDeviceById'])
                buildCrashDataRow(crashData),
          ],
        ),
      ),
    );
  }

  Widget buildEmptyContainer2() {
    return Padding(
        padding: const EdgeInsets.only(top: 80),
        child: CircularProgressIndicator());
  }

  Widget buildCrashDataRow(Map<String, dynamic> crashData) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 20),
              buildColumnContent(buildDeviceIdContent(crashData['deviceId'])),
                       SizedBox(width: 20),
              buildColumnContent(buildMsgContent(crashData['message'])),
                         SizedBox(width: 10),
              buildColumnContent(buildVerContent(crashData['version'])),
              buildColumnContent(buildDateContent(crashData['date'])),
              buildColumnContent(buildTimeContent(crashData['time'])),
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 0.1,
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Widget buildEmptyContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 80),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No CrashLogs Logs',
            style: TextStyle(
              fontSize: 12,
              color: Color.fromARGB(255, 218, 218, 218),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget buildDeviceIdContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );
  }
Widget buildMsgContent(String text) {
  int maxLines = 1; 
  bool isExpanded = false;

  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(
        width: 100,
        child: Text(
          text,
          maxLines: isExpanded ? null : maxLines,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: Color.fromARGB(255, 218, 218, 218),
          ),
        ),
      ),
      // if (text.length > 100) 
      //   TextButton(
      //     onPressed: () {
      //       setState(() {
      //         isExpanded = !isExpanded;
      //       });
      //     },
      //     child: Text(
      //       isExpanded ? 'Read Less' : 'Read More',
      //       style: TextStyle(
      //         color: Colors.blue,
      //         fontSize: 12,
      //       ),
      //     ),
      //   ),
      // Visibility(
      //   visible: isExpanded,
      //   child: Container(
      //     padding: EdgeInsets.only(top: 8),
      //     child: Text(
      //       text,
      //       style: TextStyle(
      //         fontSize: 12,
      //         color: Color.fromARGB(255, 218, 218, 218),
      //       ),
      //     ),
      //   ),
      // ),
    ],
  );
}

  Widget buildVerContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );
  }

  Widget buildDateContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );
  }

  Widget buildTimeContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );
  }

  Widget buildColumnContent(Widget child) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          child,
        ],
      ),
    );
  }

  Widget buildColumnHeading(String heading) {
    return Text(
      heading,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );
  }
}
