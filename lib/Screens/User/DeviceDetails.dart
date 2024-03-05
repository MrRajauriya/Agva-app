// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:agva_app/Screens/User/MonitorData.dart';
import 'package:agva_app/Screens/User/DeviceAbout.dart';
import 'package:agva_app/Service/SocketService.dart';
import 'package:agva_app/config.dart';
import 'package:agva_app/widgets/TilesforLandscape.dart';
import 'package:agva_app/widgets/TilesforPortait.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LiveView.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DeviceDetails extends StatefulWidget {
  final String deviceId;
  final SocketServices socketService;
  final String wardNo;
  final String deviceType;
  final String message;

  const DeviceDetails(this.deviceId, this.socketService, this.wardNo,
      this.deviceType, this.message);

  @override
  State<DeviceDetails> createState() => _DeviceDetailsState();
}

class _DeviceDetailsState extends State<DeviceDetails> {
  late SocketServices socketService;
  bool isLoading = false;
  bool setFocus = false;
  bool currentStatus = false;
  double progress = 0.0;
  int loadingCount = 0;
  bool showLoader = false;
  late String deviceId;

  late String pip = '--';
  late String mVi = '--';
  late String vti = '--';
  late String rr = '--';
  late String pipValue = '--';
  late String mViValue = '--';
  late String vtiValue = '--';
  late String rrValue = '--';
  late String spo2value = '--';
  late String pulseValue = '--';
  late String fiO2 = '--';
  late String fiO2Value = '--';
  late String modeData = '--';
  late String alarmName;
  late String alarmColor;

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    return mytoken;
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        loadingCount = 1;
      });
    });
    getFocusStatus();
    widget.socketService.initializeSocket(url, widget.deviceId);
    widget.socketService.tilesDataCallBack((
      receivedPipData,
      receivedPipValue,
      receivedMviData,
      receivedMviValue,
      receivedVtiData,
      receivedVtiValue,
      receivedRRData,
      receivedRRValue,
      receivedSpo2Value,
      receivedPulseValue,
      receivedFio2Data,
      receivedFio2Value,
      receivedModeData,
    ) {
      setState(() {
        pip = receivedPipData;
        mVi = receivedMviData;
        vti = receivedVtiData;
        rr = receivedRRData.length >= 5
            ? receivedRRData.substring(0, 5)
            : receivedRRData;
        fiO2 = receivedFio2Data;
        if (receivedPipValue.length > maxLength) {
          pipValue = receivedPipValue.substring(0, maxLength);
        } else {
          pipValue = receivedPipValue;
        }
        if (receivedMviValue.length > maxLength) {
          mViValue = receivedMviValue.substring(0, maxLength);
        } else {
          mViValue = receivedMviValue;
        }
        if (receivedVtiValue.length > maxLength) {
          vtiValue = receivedVtiValue.substring(0, maxLength);
        } else {
          vtiValue = receivedVtiValue;
        }
        if (receivedRRValue.length > maxLength) {
          rrValue = receivedRRValue.substring(0, maxLength);
        } else {
          rrValue = receivedRRValue;
        }
        if (receivedFio2Value.length > maxLength) {
          fiO2Value = receivedFio2Value.substring(0, maxLength);
        } else {
          fiO2Value = receivedFio2Value;
        }
        spo2value = receivedSpo2Value;
        pulseValue = receivedPulseValue;
        modeData = receivedModeData;
      });
// Delayed loading mechanism
      Future.delayed(Duration(seconds: 1), () {
// After 1 second, hide the loader and show other widgets
        setState(() {
          showLoader = false;
        });
      });
    });
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight
    ]);
  }

  void toggleFocus() async {
    setState(() {
      isLoading = true;
    });
    String? token = await getToken();
    print(widget.deviceId);

    if (token != null) {
      var response = await http.put(
        Uri.parse('$addtofocus/${widget.deviceId}'),
        headers: {
          "Authorization": 'Bearer $token',
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "addTofocus": !setFocus,
        }),
      );
      print('before set $setFocus');
      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var data = jsonResponse['data'];
        var focusStatus = data['addTofocus'];
        setState(() {
          setFocus = focusStatus;
        });
        print('after set $setFocus');
        getFocusStatus();
      } else {
        print('Failed to update focus status: ${response.statusCode}');
      }
    } else {
      print("Token is null");
    }
  }

  void getFocusStatus() async {
    String? token = await getToken();
    print(widget.deviceId);
    if (token != null) {
      var response = await http.get(
        Uri.parse('$getStatus/${widget.deviceId}'),
        headers: {
          "Authorization": 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        var data = jsonResponse['data'];
        var focusStatus = data['addTofocus'];
        setState(() {
          currentStatus = focusStatus;
          isLoading = false;
          print(currentStatus);
        });
      } else {
        print('Failed to get focus status: ${response.statusCode}');
      }
    } else {
      print("Token is null");
    }
  }

  final int maxLength = 4;

  @override
  void dispose() {
    loadingCount = 0;
    widget.socketService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            actions: <Widget>[
              // IconButton(
              //   icon: FaIcon(
              //     FontAwesomeIcons.userNurse,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // ),
              // IconButton(
              //   icon: FaIcon(
              //     FontAwesomeIcons.userPlus,
              //     size: 20,
              //   ),
              //   onPressed: () {},
              // )
            ],
            backgroundColor: Colors.black,
            centerTitle: true,
            title: Text(
              'Patient Details',
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 24,
                color: Colors.white,
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

  String getImagePath(message) {
    switch (message) {
      case 'ACTIVE':
        return "assets/images/active.png";
      case 'INATIVE':
        return "assets/images/inactive.png";
      default:
        return "assets/images/inactive.png";
    }
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Stack(
      children: [
        if (loadingCount == 0)
          Column(
            children: [
              SizedBox(
                  height: 1,
                  child: LinearProgressIndicator(color: Colors.pink)),
              Center(
                child: Text("Please wait.. Connecting to server",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w100,
                        fontSize: 15.0)),
              ),
            ],
          ),
        if (loadingCount != 0)
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.035,
                ),
                Text(
                  "SALIM RAZA",
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    fontSize: MediaQuery.of(context).size.width * 0.07,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
                SizedBox(height: 16),

//Live tiles
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              width: MediaQuery.of(context).size.width * 0.42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(255, 89, 89, 89),
                              ),
                              child: TextButton(
                                onPressed: () {},
                                style: TextButton.styleFrom(),
                                child: Text(
                                  modeData,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 16),
                            TilesforPortait(
                              title: fiO2,
                              value: fiO2Value,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: vti,
                              value: vtiValue,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: 'SpO2',
                              value: spo2value,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: 'EtCo2',
                              value: '-',
                              width: constraints.maxWidth * 0.42,
                            ),
                          ],
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            TilesforPortait(
                              title: pip,
                              value: pipValue,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: rr,
                              value: rrValue,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: mVi,
                              value: mViValue,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: 'PULSE',
                              value: pulseValue,
                              width: constraints.maxWidth * 0.42,
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.015,
                            ),
                            TilesforPortait(
                              title: 'ET-CUFF',
                              value: '-',
                              width: constraints.maxWidth * 0.42,
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 16),
//buttons
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(255, 82, 82, 82),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DeviceAbout(
                                          widget.deviceId, widget.deviceType),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(),
                                child: Text(
                                  "ABOUT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Expanded(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(255, 82, 82, 82),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MonitorData(
                                        widget.deviceId,
                                      ),
                                    ),
                                  );
                                },
                                style: TextButton.styleFrom(),
                                child: Text(
                                  "MONITOR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(255, 82, 82, 82),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 15,
                                        child: Image.asset(
                                          getImagePath(widget.message),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          if (widget.message == 'ACTIVE') {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
// SocketGraphPage(
// widget.deviceId),
                                                    LiveView(widget.deviceId),
// LineGraphApp(),
                                              ),
                                            );
                                          } else {
                                            final snackBar = SnackBar(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 65, 65, 65),
                                              content: Text(
                                                "Device in Standby",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              action: SnackBarAction(
                                                textColor: Colors.black,
                                                backgroundColor: Colors.white,
                                                label: 'OK',
                                                onPressed: () {},
                                              ),
                                            );
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(snackBar);
                                          }
                                        },

// style: TextButton.styleFrom(),
                                        child: Text(
                                          "LIVE VIEW",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.045,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.03,
                          ),
                          Expanded(
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color.fromARGB(255, 82, 82, 82),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  final snackBar = SnackBar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 65, 65, 65),
                                    content: Text(
                                      "Currently Unavailable",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    action: SnackBarAction(
                                      textColor: Colors.black,
                                      backgroundColor: Colors.white,
                                      label: 'OK',
                                      onPressed: () {},
                                    ),
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                },
                                style: TextButton.styleFrom(),
                                child: Text(
                                  "SUPPORT",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.045,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      if (isLoading)
                        SizedBox(
                          height: 0.5,
                          child: LinearProgressIndicator(
                            color: Color.fromARGB(255, 174, 34, 104),
                          ),
                        )
                      else
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: currentStatus
                                ? Color.fromARGB(255, 174, 34, 104)
                                : Color.fromARGB(255, 82, 82, 82),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Container(
                              height:
                                  MediaQuery.of(context).size.height * 0.065,
                              width: 170,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(5),
                                  bottomRight: Radius.circular(5),
                                ),
                                color: Color.fromARGB(255, 82, 82, 82),
                              ),
                              child: TextButton(
                                  onPressed: toggleFocus,
                                  style: TextButton.styleFrom(),
                                  child: Text(
                                    currentStatus
                                        ? "REMOVE FOCUS"
                                        : "ADD TO FOCUS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.045,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    return Stack(
      children: [
        if (loadingCount == 0)
          Column(
            children: const [
              SizedBox(
                  height: 0.5,
                  child: LinearProgressIndicator(color: Colors.pink)),
              SizedBox(
                height: 20,
              ),
              Text("Connecting server..",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0))
            ],
          ),
        if (loadingCount != 0)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.035,
              ),
              Text(
                "SALIM RAZA",
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
//Live tiles
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.12,
              ),
              LayoutBuilder(
                builder: (context, constraints) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 89, 89, 89),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(),
                              child: Text(
                                modeData,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.02,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          TilesforLandscape(
                            title: rr,
                            value: rrValue,
                          ),
                          TilesforLandscape(
                            title: mVi,
                            value: mViValue,
                          ),
                          TilesforLandscape(
                            title: 'PULSE',
                            value: pulseValue,
                          ),
                          TilesforLandscape(
                            title: 'ET-CUFF',
                            value: '-',
                          ),
                        ],
                      ), // ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          TilesforLandscape(
                            title: fiO2,
                            value: fiO2Value,
                          ),
                          TilesforLandscape(
                            title: pip,
                            value: pipValue,
                          ),
                          TilesforLandscape(
                            title: vti,
                            value: vtiValue,
                          ),
                          TilesforLandscape(
                            title: 'SpO2',
                            value: spo2value,
                          ),
                          TilesforLandscape(
                            title: 'EtCo2',
                            value: '-',
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 82, 82, 82),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DeviceAbout(
                                        widget.deviceId, widget.deviceType),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(),
                              child: Text(
                                "ABOUT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.01,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 82, 82, 82),
                            ),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MonitorData(
                                      widget.deviceId,
                                    ),
                                  ),
                                );
                              },
                              style: TextButton.styleFrom(),
                              child: Text(
                                "MONITOR",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.01,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 82, 82, 82),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 10,
                                      child: Image.asset(
                                        getImagePath(widget.message),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        if (widget.message == 'ACTIVE') {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  LiveView(widget.deviceId),
// LineGraphApp(),
                                            ),
                                          );
                                        } else {
                                          final snackBar = SnackBar(
                                            content: Center(
                                              child: const Text(
                                                "Device in StandBy",
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            action: SnackBarAction(
                                              label: '',
                                              onPressed: () {},
                                            ),
                                          );
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(snackBar);
                                        }
                                      },

// style: TextButton.styleFrom(),
                                      child: Text(
                                        "LIVE VIEW",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.01,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            height: MediaQuery.of(context).size.height * 0.12,
                            width: MediaQuery.of(context).size.width * 0.15,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color.fromARGB(255, 82, 82, 82),
                            ),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(),
                              child: Text(
                                "SUPPORT",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      MediaQuery.of(context).size.width * 0.01,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: currentStatus
                                  ? Color.fromARGB(255, 174, 34, 104)
                                  : Color.fromARGB(255, 82, 82, 82),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.12,
                                width: MediaQuery.of(context).size.width * 0.14,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5),
                                  ),
                                  color: Color.fromARGB(255, 82, 82, 82),
                                ),
                                child: TextButton(
                                  onPressed: toggleFocus,
                                  style: TextButton.styleFrom(),
                                  child: Text(
                                    currentStatus
                                        ? "REMOVE FOCUS"
                                        : "ADD TO FOCUS",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.01,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
      ],
    );
  }
}
