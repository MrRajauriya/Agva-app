// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'DoctorDeviceList.dart';

class DoctorHospitals extends StatefulWidget {
  DoctorHospitals();

  @override
  _DoctorHospitalsState createState() => _DoctorHospitalsState();
}

class _DoctorHospitalsState extends State<DoctorHospitals> {
  String? savedhospitalName;
  String? savedhospitalAddress;
  late SharedPreferences prefs;
  bool isExpanded = false;

  @override
  void initState() {
    super.initState();
    getHospital().then((hospitalName) {
      setState(() {
        savedhospitalName = hospitalName;
      });
    });
    getHospitalAddress().then((hospitalAddress) {
      setState(() {
        savedhospitalAddress = hospitalAddress;
      });
    });
  }

  Future<String?> getHospital() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hospitalName = prefs.getString('hospitalName');
    print('Retrieved Username: $hospitalName');
    return hospitalName;
  }

  Future<String?> getHospitalAddress() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? hospitalAddress = prefs.getString('hospitalAddress');
    print('Retrieved Username: $hospitalAddress');
    return hospitalAddress;
  }

  List<String> projectsForHospital = [
    'AgVa PRO',
    'Emergency',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        }));
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.05,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'HOSPITALS',
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.6,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 65, 65, 65),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    savedhospitalName ?? 'Hospital Name',
                                    style: TextStyle(
                                      fontFamily: 'Avenir',
                                      color: Color.fromARGB(255, 218, 218, 218),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                  ),
                                  Text(
                                    savedhospitalName ?? 'Hospital Address',
                                    style: TextStyle(
                                      fontFamily: 'Avenir',
                                      color: Color.fromARGB(255, 218, 218, 218),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: Image.asset("assets/images/hospital.png"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                if (isExpanded)
                  ...projectsForHospital.map(
                    (project) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DoctorDeviceList(),
                              ),
                            );
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.55,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 90, 90, 90),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 30),
                                  child: Text(
                                    project,
                                    style: TextStyle(
                                      fontFamily: 'Avenir',
                                      color: Color.fromARGB(255, 228, 228, 228),
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.02,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 15),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width * 0.1,
                                    child: Image.asset(
                                      getImagePath(project),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width * 0.08,
            vertical: MediaQuery.of(context).size.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'HOSPITALS',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.07,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.015,
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 65, 65, 65),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                savedhospitalName ?? 'Hospital Name',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                              ),
                              Text(
                                savedhospitalAddress ?? 'Hospital Address',
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 218, 218, 218),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.25,
                            child: Image.asset("assets/images/hospital.png"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              if (isExpanded)
                ...projectsForHospital.map(
                  (project) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {
                        if (project == 'AgVa PRO') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DoctorDeviceList(),
                            ),
                          );
                        } else {
                          final snackBar = SnackBar(
                            backgroundColor:
                                const Color.fromARGB(255, 65, 65, 65),
                            content: Text(
                              "Not Available",
                              style: TextStyle(color: Colors.white),
                            ),
                            action: SnackBarAction(
                              textColor: Colors.black,
                              backgroundColor: Colors.white,
                              label: 'OK',
                              onPressed: () {},
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                      },
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Color.fromARGB(255, 90, 90, 90),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 30),
                              child: Text(
                                project,
                                style: TextStyle(
                                  fontFamily: 'Avenir',
                                  color: Color.fromARGB(255, 228, 228, 228),
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.06,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Image.asset(
                                  getImagePath(project),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  String getImagePath(project) {
    switch (project) {
      case 'AgVa PRO':
        return "assets/images/deviceimage.png";
      case 'Emergency':
        return "assets/images/deviceimage.png";
      default:
        return "assets/images/inactive.png";
    }
  }
}
