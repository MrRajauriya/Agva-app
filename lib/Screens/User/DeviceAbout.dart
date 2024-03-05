// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DeviceAbout extends StatefulWidget {
  final String deviceId;
  final String deviceType;

  DeviceAbout(this.deviceId, this.deviceType);

  @override
  _DeviceAboutState createState() => _DeviceAboutState();
}

class _DeviceAboutState extends State<DeviceAbout> {
  Map<String, dynamic> deviceAbout = {};
  late String deviceId;
  late String deviceType;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    deviceId = widget.deviceId;
    deviceType = widget.deviceType;
    getProductionDetails();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    print('Saved Token: $mytoken');
    return mytoken;
  }

  void getProductionDetails() async {
    String? token = await getToken();
    if (token != null) {
      var response = await http.get(
        Uri.parse('$getProductionData/$deviceId'),
        headers: {
          "Authorization": 'Bearer $token',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['statusValue'] == 'SUCCESS') {
        setState(() {
          deviceAbout = jsonResponse['data'];
        });
      } else {
        print('Invalid User Credential: ${response.statusCode}');
      }
    } else {
      print('Token not found');
    }
  }

  void toggleFocus() async {
    String? token = await getToken();
    if (token != null) {
      var response = await http.put(
        Uri.parse('$addtofocus/$deviceId'),
        headers: {
          "Authorization": 'Bearer $token',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['statusCode'] == 200) {
        var data = jsonResponse['data'];
        print(data['addTofocus']);
        if (data['addTofocus'] == false) {
        }
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
              "About",
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return _buildPortraitLayout(context);
            } else {
              return _buildLandscapeLayout(context);
            }
          })),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        Text(
          widget.deviceType,
          style: TextStyle(
            fontFamily: 'Avenir',
            fontSize: MediaQuery.of(context).size.width * 0.08,
            color: Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Model :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Delivery Date :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Date of Manufacture :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Batch No :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Date of Warranty :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Last Service :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  deviceAbout['productType'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['model'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['dispatchDate'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['manufacturingDate'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['batchNumber'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['dateOfWarranty'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['last_service'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.05,
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Product :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Model :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Delivery Date :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Date of Manufacture :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Batch No :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Date of Warranty :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  'Last Service :',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  deviceAbout['productType'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['model'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['dispatchDate'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['manufacturingDate'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['batchNumber'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['dateOfWarranty'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  deviceAbout['last_service'] ?? 'N/A',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
