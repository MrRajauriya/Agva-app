// import 'package:agva_app/Service/SocketService.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// void main() {
//   SystemChrome.setPreferredOrientations([
//     DeviceOrientation.landscapeLeft,
//     DeviceOrientation.landscapeRight,
//   ]).then((_) {
//     runApp(LineGraphApp());
//   });
// }

// class LineGraphApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Line Graph',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: LineGraphPage(),
//     );
//   }
// }

// class LineGraphPage extends StatefulWidget {
//   @override
//   _LineGraphPageState createState() => _LineGraphPageState();
// }

// class _LineGraphPageState extends State<LineGraphPage> {
//   List<DataPoint> chartData = [];
//   bool freezeGraph = false;

//   @override
//   void initState() {
//     super.initState();
//     chartData = [];
//     SocketServices socketService = SocketServices();
//     socketService.initializeSocket('http://52.64.235.38:8000', "724963b4f3ae2a8f");
//     socketService.setOnGraphDataReceivedCallback((receivedXvalue,
//         receivedPressure, receivedVolume, receivedFlow, receivedGraphData) {
//       setState(() {
//         if (!freezeGraph) {
//           double x = double.parse(receivedXvalue.toString());
//           double y = double.parse(receivedPressure.toString());
//           chartData.add(DataPoint(x, y));
//           // Limit the size of chartData to control the number of points displayed
//           if (chartData.length > 50) {
//             chartData.removeAt(0);
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
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Line Graph'),
//       ),
//       body: Center(
//         child: AspectRatio(
//           aspectRatio: 16 / 9,
//           child: SfSparkLineChart.custom(
//             dataCount: chartData.map((e) => point),
//             trackball: const SparkChartTrackball(
//               activationMode: SparkChartActivationMode.tap,
//               // labelDisplayMode: TrackballDisplayMode.groupAllPoints,
//             ),
//             // axisLineStyle: const SparkChartAxisLineStyle(
//             //   thickness: 0.5,
//             // ),
//             po: chartData.map((point) => point.y).toList(),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // Data model for chart
// class DataPoint {
//   final double x;
//   final double y;

//   DataPoint(this.x, this.y);
// }

