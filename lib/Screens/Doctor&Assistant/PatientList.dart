// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'package:agva_app/Screens/Doctor&Assistant/AddPatientData.dart';
import 'package:agva_app/Screens/Doctor&Assistant/DosageHistory.dart';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class PatientList extends StatefulWidget {
  final String deviceId;
  const PatientList(this.deviceId);

  @override
  _PatientListState createState() => _PatientListState();
}

class _PatientListState extends State<PatientList> {
  late String deviceId;
  List<dynamic> userData = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getPatientData();
  }

  void getPatientData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    if (mytoken != null) {
      var response = await http.get(
        Uri.parse('$patientList/${widget.deviceId}'),
        headers: {
          "Authorization": 'Bearer $mytoken',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (jsonResponse['statusCode'] == 200) {
        setState(() {
          userData = jsonResponse['data'];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Patient Information'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              if (isLoading)
                SizedBox(
                    height: 1,
                    child: LinearProgressIndicator(
                      color: Colors.pink,
                    ))
              else
                Column(children: buildActiveUserWidgets(userData)),
            ],
          ),
        ));
  }

  List<Widget> buildActiveUserWidgets(List<dynamic> userData) {
    return userData.map((user) {
      String UHID = '${user['UHID']}';
      String userId = '${user['_id']}';
      print(userId);

      String deviceId = '${user['deviceId']}';
      print(deviceId);

      return Column(
        children: [
          //  if (getdata)
          // SizedBox(
          //   height: 1,
          //   child: Center(child: LinearProgressIndicator(color: Colors.pink)),
          // ) else
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.25,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Patient Name :'),
                          Text('UHID :'),
                          Text('Age :'),
                          Text('Weight :'),
                          Text('Hight :'),
                          Text('Ward No. :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['patientName']}'),
                          Text('${user['UHID']}'),
                          Text('${user['age']}'),
                          Text('${user['weight']}'),
                          Text('${user['height']}'),
                          Text('${user['ward_no']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DosageHistory(UHID)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                        child: Text(
                          "View Dosage",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      AddPatientData(UHID, deviceId)));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: Text(
                          "Edit Details",
                          style: TextStyle(color: Colors.pink),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }
}
