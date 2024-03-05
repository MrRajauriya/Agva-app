// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, must_be_immutable, unused_import, unnecessary_string_interpolations, use_key_in_widget_constructors
import 'dart:math';
import 'package:agva_app/Screens/User/EmptyLiveView.dart';
import 'package:agva_app/Service/SocketService.dart';
import 'package:agva_app/widgets/LineChartWidget.dart';
import 'package:agva_app/widgets/animatedChart.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LiveView extends StatefulWidget {
  final String deviceId;
  LiveView(this.deviceId);

  @override
  _LiveViewState createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  List<double> data1 = [];
  List<double> data2 = [];
  List<double> data3 = [];
  List<int> fifoLimit = [350];
  List<Color> lineColors = [Colors.black, Colors.white];

  bool isFirstTime = false;
  int xVal = 0;
  Color? newColor;

  late List<FlSpot> chartData;
  late List<FlSpot> chartDataVolume;
  late List<FlSpot> chartDataFlow;

  String selectedMenu = 'GRAPHS';
  late String deviceId;
  late String modeData = '-';
  late List<String> observedData = [];
  late List<String> setParameter = [];
  late List<String> secondaryObserved = [];
  late String alarmName = "";
  late String alarmColor;
  late String alarmColor2;
  late String xvalue = "";
  late String pressure = "";
  late String volume = "";
  late String flow = "";
  late List<String> graphData = [];

  late List<String> graphPressure = [];

  late List<String> graphVolume = [];

  late List<String> graphFlow = [];

  bool freezeGraph = false;

  void generateData() {
    if (freezeGraph) {
      return;
    }
  }

  Random random = Random();

  bool _isLoading = true;
  // late String alertData;

  callme() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  List<double> generateRandomData(int count) {
    // Generate 'count' random double values between 10 and 90
    final random = Random();
    return List.generate(count, (index) => random.nextDouble() * 80 + 10);
  }

  @override
  void initState() {
    super.initState();
    chartData = [];
    chartDataVolume = [];
    chartDataFlow = [];
    SocketServices socketService = SocketServices();
    socketService.initializeSocket('http://52.64.235.38:8000', widget.deviceId);
    socketService.setOnDataReceivedCallback((
      receivedModeData,
      receivedObservedData,
      receivedSetParameter,
      receivedSecondaryObserved,
      receivedAlarmName,
      receivedAlarmColor,
      receivedAlarmColor2,
    ) {
      setState(() {
        modeData = receivedModeData;
        observedData = receivedObservedData;
        secondaryObserved = receivedSecondaryObserved;
        setParameter = receivedSetParameter;
        alarmName = receivedAlarmName;
        alarmColor = receivedAlarmColor;
        alarmColor2 = receivedAlarmColor2;
        if (alarmColor == '#F4C430') {
          newColor = Colors.amber;
        } else if (alarmColor == '#AC0303') {
          newColor = Colors.red;
        } else if (alarmColor2 == '#000000') {
          newColor = Colors.black;
        }
      });
    });

    // socketService.setOnGraphDataReceivedCallback((receivedXvalue,
    //     receivedPressure, receivedVolume, receivedFlow, receivedGraphData) {
    //   setState(() {
    //     if (!freezeGraph) {
    //       xvalue = receivedXvalue.toString();
    //       pressure = receivedPressure.toString();
    //       volume = receivedVolume.toString();
    //       flow = receivedFlow.toString();
    //       graphData = receivedGraphData;
    //       graphPressure.add(xvalue);
    //       graphPressure.add(pressure);

    //       graphVolume.add(xvalue);
    //       graphVolume.add(volume);

    //       double x = double.parse(xvalue);
    //       double y = double.parse(pressure);

    //       double yvolume = double.parse(volume);

    //       double yFlow = double.parse(flow);

    //       // chartData.add(FlSpot(x, y));
    //       // chartDataVolume.add(FlSpot(x, yvolume));
    //       // chartDataFlow.add(FlSpot(x, yFlow));

    //       if (!isFirstTime) {
    //         chartData.add(FlSpot(x, y));
    //       } else {
    //         chartData[xVal] = FlSpot(x, y);
    //       }

    //       xVal++;
    //       if (xVal == 350) {
    //         isFirstTime = true;
    //         xVal = 0;
    //       }

    //       if (isFirstTime) {
    //         for (int i = 0; i < 12; i++) {
    //           if (i < 6) {
    //             if ((xVal - (6 - i)) < 0) {
    //               fifoLimit[i] = 350 + (xVal - (6 - i));
    //             } else {
    //               fifoLimit[i] = (xVal - (6 - i));
    //             }
    //           } else {
    //             fifoLimit[i] = (xVal + (i - 6));
    //           }
    //         }

    //         for (int index = 0; index < 350; index++) {
    //           if (fifoLimit.contains(index)) {
    //             lineColors[index] = Colors.black;
    //             // dpsVolume[index].lineColor = "#000000"
    //             // dpsFlow[index].lineColor = "#000000"
    //           } else {
    //             lineColors[index] = Colors.white;
    //             // dpsVolume[index].lineColor = "#FFFFFF"
    //             // dpsFlow[index].lineColor = "#FFFFFF"
    //           }
    //         }
    //       }

    //       // Limit the size of chartData to control the number of points displayed
    //       // if (chartData.length > 50) {
    //       //   // Remove the first element to make space for new data
    //       //   chartData.removeAt(0);
    //       // }
    //       if (chartDataVolume.length > 50) {
    //         // chartData.removeLast();
    //         // chartDataVolume = chartDataVolume.sublist(1);

    //         chartDataVolume.removeAt(0); // Remove the last element
    //         print("It cleared");
    //       }
    //       if (chartDataFlow.length > 50) {
    //         // chartData.removeLast();
    //         // chartDataFlow = chartDataFlow.sublist(1);

    //         chartDataFlow.removeAt(0); // Remove the last element
    //         print("It cleared");
    //       }
    //     } else {}

    //     print(
    //         "Graph values are $xvalue,$pressure,$volume,$flow,$graphData,'Here',$graphPressure");
    //   });
    // });

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    callme();
  }

  @override
  dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);
    // callme();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if (_isLoading)
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 10),
                    Text('Going Live...'),
                  ],
                ),
              )
            else if (observedData.isEmpty)
              EmptyLiveView()
            else
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //header

                    Header(modeData, alarmName, newColor),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.002,
                    ),
                    //buttons & graphs & tiles
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        //Side menu buttons
                        MenuButtons(
                          selectedMenu,
                          (menu) {
                            setState(() {
                              selectedMenu = menu;
                            });
                          },
                        ),

                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.002,
                        ),
                        //graph screen
                        Container(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.74,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                // Data screen
                                if (selectedMenu == 'DATA')
                                  DataScreen(observedData: observedData),
                                if (selectedMenu == 'GRAPHS')
                                  Column(
                                    children: [
                                      Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.76,
                                          decoration: BoxDecoration(
                                            color: Color.fromARGB(255, 0, 0, 0),
                                          ),
                                          child: MyLineChart()
                                          // child: LineChart(LineChartData(
                                          //     titlesData: FlTitlesData(
                                          //         leftTitles: AxisTitles(
                                          //             sideTitles: SideTitles(
                                          //                 showTitles: false)),
                                          //         rightTitles: AxisTitles(
                                          //             sideTitles: SideTitles(
                                          //                 showTitles: false)),
                                          //         bottomTitles: AxisTitles(
                                          //             sideTitles: SideTitles(
                                          //                 showTitles: false,
                                          //                 reservedSize: 0)),
                                          //         topTitles: AxisTitles(
                                          //             sideTitles: SideTitles(
                                          //                 showTitles: false))),
                                          //     // borderData: FlBorderData(
                                          //     //     show: false,
                                          //     //     border: Border.all(
                                          //     //       color: Colors.grey,
                                          //     //       width: 1,
                                          //     //     )),
                                          //     lineBarsData: [
                                          //       LineChartBarData(
                                          //         gradient: LinearGradient(
                                          //             colors: lineColors),
                                          //         // color: Colors.white,
                                          //         spots: chartData,
                                          //         isCurved: false,
                                          //         // color: Colors.white,
                                          //         belowBarData:
                                          //             BarAreaData(show: false),
                                          //         dotData: FlDotData(show: false),
                                          //       )
                                          //     ])),
                                          ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.76,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                        // child: LineChart(LineChartData(
                                        //     titlesData: FlTitlesData(
                                        //         leftTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false)),
                                        //         rightTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false)),
                                        //         bottomTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false,
                                        //                 reservedSize: 0)),
                                        //         topTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false))),
                                        //     borderData: FlBorderData(
                                        //         show: false,
                                        //         border: Border.all(
                                        //           color: Colors.grey,
                                        //           width: 1,
                                        //         )),
                                        //     lineBarsData: [
                                        //       LineChartBarData(
                                        //         spots: chartDataVolume,
                                        //         isCurved: false,
                                        //         color: Colors.white,
                                        //         belowBarData:
                                        //             BarAreaData(show: true),
                                        //         dotData: FlDotData(show: false),
                                        //       )
                                        //     ])),
                                                child: MyLineChart()
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.2,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.76,
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                        ),
                                                child: MyLineChart()
                                        // child: LineChart(LineChartData(
                                        //     titlesData: FlTitlesData(
                                        //         leftTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false)),
                                        //         rightTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false)),
                                        //         bottomTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false,
                                        //                 reservedSize: 0)),
                                        //         topTitles: AxisTitles(
                                        //             sideTitles: SideTitles(
                                        //                 showTitles: false))),
                                        //     borderData: FlBorderData(
                                        //         show: false,
                                        //         border: Border.all(
                                        //           color: Colors.grey,
                                        //           width: 1,
                                        //         )),
                                        //     lineBarsData: [
                                        //       LineChartBarData(
                                        //         spots: chartDataFlow,
                                        //         isCurved: false,
                                        //         color: Colors.white,
                                        //         belowBarData:
                                        //             BarAreaData(show: true),
                                        //         dotData: FlDotData(show: false),
                                        //       )
                                        //     ])),
                                      ),
                                    ],
                                  ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.002,
                        ),

                        //secondaryobserverdata tiles
                        Tiles(secondaryObserved),
                      ],
                    ),

                    BottomTiles(setParameter),
                  ],
                ),
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
              onPressed: () {
                setState(() {
                  freezeGraph = !freezeGraph;
                });
              },
              child: Icon(freezeGraph ? Icons.play_arrow : Icons.pause),
            ),
          ),
        ),
      ),
    );
  }
}

class MenuButtons extends StatelessWidget {
  final String selectedMenu;
  final Function(String) onMenuSelected;

  MenuButtons(this.selectedMenu, this.onMenuSelected);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildMenuButton(context, 'DATA'),
            buildMenuButton(context, 'ALARMS'),
            buildMenuButton(context, 'LOOPS'),
            buildMenuButton(context, 'GRAPHS'),
            buildMenuButton(context, 'MODES'),
            buildMenuButton(context, 'CONTROLS'),
            buildMenuButton(context, 'SYSTEM'),
          ],
        ),
      ),
    );
  }

  Widget buildMenuButton(BuildContext context, String menu) {
    bool isSelected = selectedMenu == menu;
    return GestureDetector(
      onTap: () {
        onMenuSelected(menu);
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.1,
        width: MediaQuery.of(context).size.width * 0.13,
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Color.fromARGB(255, 8, 8, 8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(9.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                menu,
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: isSelected
                      ? Colors.black
                      : Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.015,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DataScreen extends StatelessWidget {
  const DataScreen({
    Key? key,
    required this.observedData,
  }) : super(key: key);

  final List<String> observedData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            crossAxisSpacing: 0.0,
            mainAxisSpacing: 0.0,
          ),
          itemCount: observedData.length,
          itemBuilder: (BuildContext context, int index) {
            String data = observedData[index];
            List<String> dataParts = data.split('~');
            String label = dataParts[0].isEmpty ? '-' : dataParts[0];
            String value = dataParts[1].isEmpty ? '-' : dataParts[1];

            bool isMachine = value.contains('Machine');
            return Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          label.isEmpty ? '-' : label,
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 136, 136, 136),
                            fontSize: MediaQuery.of(context).size.width * 0.01,
                          ),
                        ),
                        Text(
                          isMachine ? 'M' : '$value',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  late String modeData;
  late String alarmName;
  Color? newColor;

  Header(this.modeData, this.alarmName, this.newColor);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.09,
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 0, 0, 0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //mode
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: Color.fromARGB(255, 32, 76, 0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  modeData.isEmpty ? '-' : modeData,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 218, 218, 218),
                    fontSize: MediaQuery.of(context).size.width * 0.015,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          //patient details
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'UHID22554484',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                    Text(
                      '45 Years',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.015,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '33 cms',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                    Text(
                      '52 kg',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.015,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '09-12-2023',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                    Text(
                      '00:08:25',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          //alarm box
          Container(
            height: MediaQuery.of(context).size.height * 0.08,
            width: MediaQuery.of(context).size.width * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              // color: Color.fromARGB(255, 188, 138, 0),
              color: newColor,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  alarmName,
                  style: TextStyle(
                    fontFamily: 'Avenir',
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: MediaQuery.of(context).size.width * 0.02,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          //action buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                "assets/images/alarm.png",
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Image.asset(
                "assets/images/bettery.png",
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              Image.asset(
                "assets/images/plug.png",
                height: 20,
                fit: BoxFit.cover,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.015,
              ),
              GestureDetector(
                // onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => LoadingScreen()))},
                onTap: () => {Navigator.pop(context)},
                child: Image.asset(
                  "assets/images/exit.png",
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.015,
          ),

          // pr spo2
          Container(
            height: MediaQuery.of(context).size.height * 0.14,
            width: MediaQuery.of(context).size.width * 0.16,
            decoration: BoxDecoration(
              border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'PR',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    Text(
                      '-',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.04,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'SpO2',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.01,
                      ),
                    ),
                    Text(
                      '-',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.006,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BottomTiles extends StatelessWidget {
  final List<String> setParameter;

  const BottomTiles(this.setParameter, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 8, 8, 8),
      ),
      child: Row(
        children: setParameter.map((parameter) {
          var splitParameter = parameter.split('~');
          var parameterName =
              splitParameter[0].isEmpty ? '-' : splitParameter[0];
          var parameterValue =
              splitParameter[1].isEmpty ? '-' : splitParameter[1];

          return Container(
            height: MediaQuery.of(context).size.height * 0.11,
            width: MediaQuery.of(context).size.width * 0.12,
            decoration: BoxDecoration(
              border: Border.symmetric(
                vertical: BorderSide(
                  color: const Color.fromARGB(255, 90, 90, 90),
                ),
              ),
              color: Color.fromARGB(255, 8, 8, 8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    parameterName.isEmpty ? '-' : parameterName,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      color: Color.fromARGB(255, 136, 136, 136),
                      fontSize: MediaQuery.of(context).size.width * 0.012,
                    ),
                  ),
                  Text(
                    parameterValue.isEmpty ? '-' : parameterValue,
                    style: TextStyle(
                      fontFamily: 'Avenir',
                      color: Color.fromARGB(255, 218, 218, 218),
                      fontSize: MediaQuery.of(context).size.width * 0.022,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class Tiles extends StatelessWidget {
  late List<String> secondaryObserved;

  Tiles(this.secondaryObserved);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: secondaryObserved.map((data) {
        var keyValuePairs = data.split(', ');
        Map<String, String> valuesMap = {};
        keyValuePairs.forEach((pair) {
          var splitPair = pair.split('~');
          valuesMap[splitPair[0]] = splitPair[1];
        });

        return Container(
          height: MediaQuery.of(context).size.height * 0.14,
          width: MediaQuery.of(context).size.width * 0.12,
          decoration: BoxDecoration(
            border: Border.all(color: const Color.fromARGB(255, 90, 90, 90)),
            color: Color.fromARGB(255, 8, 8, 8),
          ),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: valuesMap.entries.map((entry) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      entry.key.isEmpty ? '-' : entry.key,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 136, 136, 136),
                        fontSize: MediaQuery.of(context).size.width * 0.012,
                      ),
                    ),
                    Text(
                      // entry.value,
                      entry.value.isEmpty ? '-' : entry.value,
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.022,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        );
      }).toList(),
    );
  }
}
