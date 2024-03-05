// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Events extends StatefulWidget {
  final String deviceId;
  const Events(this.deviceId);

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  bool isLoading = true;
  late String deviceId;
  late Map<String, dynamic> jsonResponse;

  @override
  void initState() {
    super.initState();
    deviceId = widget.deviceId;
    getEventusingId();
  }

  Future<void> getEventusingId() async {
    var response = await http.get(
      Uri.parse('$getDeviceEventbyID/$deviceId?page=1&limit=5'),
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
                  buildColumnHeading('Type'),
                  buildColumnHeading('Date'),
                  buildColumnHeading('Time'),
                ],
              ),
            ),
            Container(
              height: 0.1,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
            if (isLoading) // Show loading indicator
              buildEmptyContainer2()
            else if (jsonResponse['data']['findDeviceById']
                .isEmpty) // Show "No Alarm Logs" message
              buildEmptyContainer()
            else
              for (var eventData in jsonResponse['data']['findDeviceById'])
                buildEventDataRow(eventData),
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


  Widget buildEmptyContainer() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'No Events Found',
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

  Widget buildEventDataRow(Map<String, dynamic> eventData) {
    if (eventData.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20),
                buildColumnContent(builDeviceIdContent(eventData['did'])),
                SizedBox(width: 10),
                buildColumnContent(buildMsgContent(eventData['message'])),
                SizedBox(         width: MediaQuery.of(context).size.width * 0.01,),
                buildColumnContent(buildTypeContent(eventData['type'])),
                buildColumnContent(buildDateContent(eventData['date'])),
                buildColumnContent(buildTimeContent(eventData['time'])),
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
    } else {
      return buildEmptyContainer();
    }
  }



  Widget builDeviceIdContent(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 12,
        color: Color.fromARGB(255, 218, 218, 218),
      ),
    );
  }

  Widget buildMsgContent(String text) {
    return SizedBox(
       width: MediaQuery.of(context).size.width * 0.17,
      child: Text(
        text,
        maxLines: 3,
        softWrap: true,
        style: TextStyle(
          fontSize: 12,
          color: Color.fromARGB(255, 218, 218, 218),
        ),
      ),
    );
  }

  Widget buildTypeContent(String text) {
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
