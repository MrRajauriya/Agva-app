// // ignore_for_file: library_private_types_in_public_api

// import 'package:flutter/material.dart';
// import 'package:agva_app/Service/SocketService.dart';
// import 'package:flutter/services.dart';
// import 'package:socket_io_client/socket_io_client.dart' as IO;
// import 'package:fl_chart/fl_chart.dart';
// import 'dart:async';

// class SocketGraphPage extends StatefulWidget {
//   final String deviceId;
//   const SocketGraphPage(this.deviceId, {super.key});
//   @override
//   _SocketGraphPageState createState() => _SocketGraphPageState();
// }

// class _SocketGraphPageState extends State<SocketGraphPage> {
//   late IO.Socket socket;
//   List<int> fifoLimit = [350];
//   List<Color> lineColors = List.filled(350, Colors.white);

//   bool isFirstTime = false;
//   int xVal = 0;
//   Color? newColor;
//   bool freezeGraph = false;

//   late List<FlSpot> chartData;
//   late List<FlSpot> chartDataVolume;
//   late List<FlSpot> chartDataFlow;

//   String selectedMenu = 'GRAPHS';
//   late String deviceId;
//   late String modeData = '-';
//   late List<String> observedData = [];
//   late List<String> setParameter = [];
//   late List<String> secondaryObserved = [];
//   late String alarmName = "";
//   late String alarmColor;
//   late String alarmColor2;
//   late double pressure = 0.0;
//   late double volume = 0.0;
//   late double flow = 0.0;

//   Timer? _timer;


//   void startTimer() {
//     _timer = Timer.periodic(Duration(milliseconds: 30), (timer) {
//       customlinechart(chartData, lineColors);
//     });
//   }

//   @override
//   void initState() {
//     super.initState();
//  startTimer();
//     chartData = [];
//     chartDataVolume = [];
//     chartDataFlow = [];
//     SocketServices socketService = SocketServices();
//     socketService.initializeSocket('http://52.64.235.38:8000', widget.deviceId);
//     socketService.setOnDataReceivedCallback((
//       receivedModeData,
//       receivedObservedData,
//       receivedSetParameter,
//       receivedSecondaryObserved,
//       receivedAlarmName,
//       receivedAlarmColor,
//       receivedAlarmColor2,
//     ) {
//       setState(() {
//         modeData = receivedModeData;
//         observedData = receivedObservedData;
//         secondaryObserved = receivedSecondaryObserved;
//         setParameter = receivedSetParameter;
//         alarmName = receivedAlarmName;
//         alarmColor = receivedAlarmColor;
//         alarmColor2 = receivedAlarmColor2;
//         if (alarmColor == '#F4C430') {
//           newColor = Colors.amber;
//         } else if (alarmColor == '#AC0303') {
//           newColor = Colors.red;
//         } else if (alarmColor2 == '#000000') {
//           newColor = Colors.black;
//         }
//         // print("CHECK ALARM $alarmColor+ $alarmName");
//       });
//     });

//     socketService.setOnGraphDataReceivedCallback((receivedXvalue,
//         receivedPressure, receivedVolume, receivedFlow, receivedGraphData) {
//       setState(() {
//         pressure = receivedPressure;

//         if (!isFirstTime) {
//           chartData.add(FlSpot(xVal.toDouble(), pressure));
//         } else {
//           chartData[xVal] = FlSpot(xVal.toDouble(), pressure);

//           for (int index = 0; index < 350; index++) {
//             if (fifoLimit.contains(index)) {
//               lineColors[index] = Colors.black;
//               print('condition one');
//             } else {
//               lineColors[index] = Colors.white;
//               print("condition two");
//             }
//           }
//         }

//         xVal++;
//         if (xVal == 350) {
//           isFirstTime = true;
//           xVal = 0;
//         }

//         if (isFirstTime) {
//           for (int i = 0; i < 12; i++) {
//             if (i < 6) {
//               if ((xVal - (6 - i)) < 0) {
//                 fifoLimit[i] = 350 + (xVal - (6 - i));
//               } else {
//                 fifoLimit[i] = (xVal - (6 - i));
//               }
//             } else {
//               fifoLimit[i] = (xVal + (i - 6));
//             }
//           }
//         }
//       });
//     });

//     SystemChrome.setPreferredOrientations([
//       DeviceOrientation.landscapeRight,
//       DeviceOrientation.landscapeLeft,
//     ]);
//   }

//   @override
//   void dispose() {
//     socket.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Socket Graph'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: customlinechart(chartData, lineColors),
//       ),
//     );
//   }
// }

// Widget customlinechart(chartData, lineColors) {
//   return LineChart(
//     LineChartData(
//       lineBarsData: [
//         LineChartBarData(
//           spots: chartData,
//           isCurved: false,
//           // color: Colors.white,
//           gradient: LinearGradient(
//             colors: lineColors,
//           ),
//           barWidth: 2,
//           isStrokeCapRound: true,
//           belowBarData: BarAreaData(show: false),
//           dotData: const FlDotData(show: false),
//         ),
//       ],
//       minY: 0,
//       gridData: const FlGridData(show: false),
//       titlesData: const FlTitlesData(
//           // leftTitles:  SideTitles(showTitles: true),
//           // bottomTitles: SideTitles(showTitles: true),
//           ),
//       borderData: FlBorderData(
//         show: false,
//         border: Border.all(color: Colors.black),
//       ),
//     ),
//   );
// }

