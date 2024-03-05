// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

// class LineChartWidget extends StatefulWidget {
//   final String xvalue, pressure, volume, flow;

//   LineChartWidget(this.xvalue, this.pressure, this.volume, this.flow);

//   @override
//   _LineChartWidgetState createState() => _LineChartWidgetState();
// }

// class _LineChartWidgetState extends State<LineChartWidget> {
//   late StreamController<List<FlSpot>> streamController;

//   @override
//   void initState() {
//     super.initState();

//     streamController = StreamController<List<FlSpot>>();

//     Timer.periodic(Duration(milliseconds: 1000), (timer) {
//       List<FlSpot> data = [
//         FlSpot(double.parse(widget.xvalue), double.parse(widget.pressure)),
//       ];

//       streamController.add(data);
//     });
//   }

//   @override
//   void dispose() {
//     streamController.close();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: StreamBuilder<List<FlSpot>>(
//         stream: streamController.stream,
//         builder: (context, snapshot) {
//           return LineChart(
//             LineChartData(
//               gridData: FlGridData(show: false),
//               titlesData: FlTitlesData(show: false),
//               borderData: FlBorderData(
//                 show: false,
//                 border: Border.all(color: const Color(0xff37434d), width: 1),
//               ),
//               lineBarsData: [
//                 LineChartBarData(
//                   spots: snapshot.data!,
//                   isCurved: false,
//                   // barWidth: 1,
//                   color: Colors.white,
//                   dotData: FlDotData(show: false),
//                   belowBarData: BarAreaData(show: true),
//                 ),
//               ],
//               minX: 0,
//               maxX: 1,
//               // minX: 0,
//               // maxX: 0,
//               minY: 0,
//               maxY: 50,
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
