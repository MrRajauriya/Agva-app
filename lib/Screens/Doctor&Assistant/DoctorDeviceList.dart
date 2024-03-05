// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, library_private_types_in_public_api, use_key_in_widget_constructors
import 'dart:convert';
import 'package:agva_app/Screens/Doctor&Assistant/DoctorDeviceDetails.dart';
import 'package:agva_app/Service/SocketService.dart';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DoctorDeviceList extends StatefulWidget {
  @override
  _DoctorDeviceListState createState() => _DoctorDeviceListState();
}

class _DoctorDeviceListState extends State<DoctorDeviceList> {
  bool isLoading = true;
  List<Map<String, dynamic>> devicesForUserList = [];
  String? savedHospitalName;
  String? storedHospitalAddress;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    initSharedPref();
    fetchGetDevicesForDoctor();
    gethospital().then((hospitalName) {
      setState(() {
        savedHospitalName = hospitalName;
      });
    });
    gethospitalAddress().then((hospitalAddress) {
      setState(() {
        storedHospitalAddress = hospitalAddress;
      });
    });
  }

  void initSharedPref() async {
    prefs = await SharedPreferences.getInstance();
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mytoken');
  }

  Future<String?> gethospital() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hospitalName = prefs.getString('hospitalName');
    print('Retrieved hospital name: $hospitalName');
    return hospitalName;
  }

  Future<String?> gethospitalAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hospitalAddress = prefs.getString('hospitalAddress');
    print('Retrieved hospital address: $hospitalAddress');
    return hospitalAddress;
  }

  Future<void> fetchGetDevicesForDoctor() async {
    setState(() {
      isLoading = true;
    });

    String? token = await getToken();
    if (token != null) {
      var response = await http.get(
        Uri.parse(getDeviceForDoctor),
        headers: {
          "Authorization": 'Bearer $token',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      if (jsonResponse['statusValue'] == 'SUCCESS') {
        var data = jsonResponse['data'];
        devicesForUserList = List<Map<String, dynamic>>.from(data['data']);

        setState(() {
          isLoading = false;
        });
      } else {
        print('Invalid User Credential: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  List<Widget> buildDeviceList() {
    return devicesForUserList.map((data) {
      Map? deviceInfo = (data['deviceInfo'] as List?)?.first;

      Color? alarmColor;
      if (data['alarmData']?.isNotEmpty ?? false) {
        String priority = data['alarmData'][0]['priority'];

        if (priority == 'ALARM_LOW_LEVEL') {
          alarmColor = Colors.amber;
        } else if (priority == 'ALARM_MEDIUM_LEVEL') {
          alarmColor = Colors.amber;
        } else if (priority == 'ALARM_HIGH_LEVEL') {
          alarmColor = Colors.red;
        } else if (priority == 'ALARM_CRITICAL_LEVEL') {
          alarmColor = Colors.red;
        }
      } else {
        alarmColor = Colors.green;
      }

      Color? focusColor;
      if (data['addTofocus'] == true) {
        focusColor = Colors.pink;
      } else {
        focusColor = Color.fromARGB(255, 65, 65, 65);
      }

      return ListTile(
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: alarmColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: focusColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 65, 65, 65),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${deviceInfo?['DeviceType'] ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              '${deviceInfo?['Hospital_Name'] ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.005,
                            ),
                            Text(
                              'Ward: ${deviceInfo?['Ward_No'] ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'PT. Salim Raza',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              '24 YEARS',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              '58 KG',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.03,
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
        onTap: () {
          if (devicesForUserList.isNotEmpty) {
            String deviceId = data['deviceId'];
            String message = data['message'];
            String wardNo = deviceInfo?['Ward_No'];
            String deviceType = deviceInfo?['DeviceType'];
            String hospitalName = deviceInfo?['Hospital_Name'];
            String departmentName = deviceInfo?['Department_Name'];
            String bioMed = deviceInfo?['Bio_Med'];
            String aliasName = deviceInfo?['Alias_Name'];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDeviceDetails(
                    deviceId, SocketServices(), wardNo, deviceType, message),
              ),
            );
          }
        },
      );
    }).toList();
  }

  List<Widget> buildDeviceListHorizonatal() {
    return devicesForUserList.map((data) {
      Map? deviceInfo = (data['deviceInfo'] as List?)?.first;
      Color? alarmColor;
      if (data['alarmData']?.isNotEmpty ?? false) {
        String priority = data['alarmData'][0]['priority'];

        if (priority == 'ALARM_LOW_LEVEL') {
          alarmColor = Colors.amber;
        } else if (priority == 'ALARM_MEDIUM_LEVEL') {
          alarmColor = Colors.amber;
        } else if (priority == 'ALARM_HIGH_LEVEL') {
          alarmColor = Colors.red;
        } else if (priority == 'ALARM_CRITICAL_LEVEL') {
          alarmColor = Colors.red;
        }
      } else {
        alarmColor = Colors.green;
      }

      Color? focusColor;
      if (data['addTofocus'] == true) {
        focusColor = Colors.pink;
      } else {
        focusColor = Color.fromARGB(255, 65, 65, 65);
      }

      return ListTile(
        title: Container(
          height: MediaQuery.of(context).size.height * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: alarmColor,
          ),
          child: Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: focusColor,
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 65, 65, 65),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 11, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${deviceInfo?['DeviceType'] ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              '${deviceInfo?['Hospital_Name'] ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.005,
                            ),
                            Text(
                              'Ward: ${deviceInfo?['Ward_No'] ?? 'N/A'}',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'PT. Salim Raza',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.02,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.02,
                            ),
                            Text(
                              '24 YEARS',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.015,
                              ),
                            ),
                            SizedBox(
                              height: MediaQuery.of(context).size.width * 0.01,
                            ),
                            Text(
                              '58 KG',
                              style: TextStyle(
                                fontFamily: 'Avenir',
                                color: Color.fromARGB(255, 218, 218, 218),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.015,
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
        onTap: () {
          if (devicesForUserList.isNotEmpty) {
            String deviceId = data['deviceId'];
            String message = data['message'];
            String wardNo = deviceInfo?['Ward_No'];
            String deviceType = deviceInfo?['DeviceType'];
            String hospitalName = deviceInfo?['Hospital_Name'];
            String departmentName = deviceInfo?['Department_Name'];
            String bioMed = deviceInfo?['Bio_Med'];
            String aliasName = deviceInfo?['Alias_Name'];
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorDeviceDetails(
                    deviceId, SocketServices(), wardNo, deviceType, message),
              ),
            );
          }
        },
      );
    }).toList();
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
              // widget.deviceId,
              ' ',
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
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                savedHospitalName ?? 'Default Hospital Name',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.06,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                storedHospitalAddress ?? 'Default Hospital Address',
                style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.04,
                    fontWeight: FontWeight.w300),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            // Devices List
            if (isLoading)
              SizedBox(
                  height: 1,
                  child: Center(
                      child: LinearProgressIndicator(color: Colors.pink)))
            else
              Column(
                children: buildDeviceList(),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.15,
        vertical: MediaQuery.of(context).size.height * 0.01,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                savedHospitalName ?? 'Default Hospital Name',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.05),
              child: Text(
                storedHospitalAddress ?? 'Default Hospital Address',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.02,
            ),

            // Devices List
            if (isLoading)
              SizedBox(
                  height: 0.5,
                  child: Center(
                      child: LinearProgressIndicator(color: Colors.pink)))
            else
              Column(
                children: buildDeviceListHorizonatal(),
              ),
          ],
        ),
      ),
    );
  }
}
