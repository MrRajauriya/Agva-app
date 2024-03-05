// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'TrendsHeader.dart';
import 'TrendsHeaderEmpty.dart';

class Trends extends StatefulWidget {
  final String deviceId;
  const Trends(this.deviceId);

  @override
  State<Trends> createState() => _TrendsState();
}

class _TrendsState extends State<Trends> {
  bool isLoading = true;
  late String deviceId;
  List<Map<String, String>> trendsDataList = [];

  @override
  void initState() {
    super.initState();
    deviceId = widget.deviceId;
    getTrendsbyId();
  }

  Future<void> getTrendsbyId() async {
    var response = await http.get(
      Uri.parse('$getDeviceTrendsbyID/$deviceId?page=1&limit=5'),
    );
    var jsonResponse = jsonDecode(response.body);
    if (jsonResponse['statusCode'] == 200) {
      setState(() {
        isLoading = false;
        trendsDataList = List<Map<String, String>>.from(
          (jsonResponse['data']['findDeviceById'] as List<dynamic>)
              .map((dynamic item) {
            Map<String, String> stringMap = {};
            (item as Map<String, dynamic>).forEach((key, value) {
              stringMap[key] = value.toString();
            });
            return stringMap;
          }),
        );
      });
    } else {
      print('Invalid User Credential: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (trendsDataList.isEmpty) buildEmptyContainer() else TrendsHeader(),
        Expanded(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: trendsDataList.map((trendsData) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      color: Color.fromARGB(255, 121, 121, 121),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 25, vertical: 5),
                        child: Text(
                          '${trendsData['time']}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${trendsData['mode']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['pip']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['peep']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['mean_Airway']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['vti']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['vte']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['mve']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['mvi']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['fio2']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['respiratory_Rate']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['ie']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    Text(
                      '${trendsData['tinsp']}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromARGB(255, 218, 218, 218),
                      ),
                    ),
                    // Text(
                    //   '${trendsData['texp']}',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Color.fromARGB(255, 218, 218, 218),
                    //   ),
                    // ),
                    // Text(
                    //   '${trendsData['averageLeak']}',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Color.fromARGB(255, 218, 218, 218),
                    //   ),
                    // ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  // Widget buildEmptyContainer2() {
  //   return Center(
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         CircularProgressIndicator(),
  //       ],
  //     ),
  //   );
  // }

  Widget buildEmptyContainer() {
    return Row(
      children: [
        TrendsHeaderEmpty(),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              color: Color.fromARGB(255, 121, 121, 121),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                child: Text(
                  '00:00',
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                ),
              ),
            ),
            Text(
              'N/A',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            Text(
              '0',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 218, 218, 218),
              ),
            ),
            // Text(
            //   '0',
            //   style: TextStyle(
            //     fontSize: 12,
            //     color: Color.fromARGB(255, 218, 218, 218),
            //   ),
            // ),
            // Text(
            //   '0',
            //   style: TextStyle(
            //     fontSize: 12,
            //     color: Color.fromARGB(255, 218, 218, 218),
            //   ),
            // ),
          ],
        ),
      ],
    );
  }
}
