// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables

import 'package:agva_app/Screens/Common/TermsCondition.dart';
import 'package:agva_app/Screens/Common/About.dart';
import 'package:agva_app/Service/FAQ.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  void initState() {
    super.initState();
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
            'Settings',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SettingsPortrait();
          } else {
            return SettingsLandscape();
          }
        }),
        floatingActionButton: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color.fromARGB(255, 181, 0, 100),
          ),
          child: FloatingActionButton(
            backgroundColor: Colors.transparent,
            onPressed: () => {Navigator.pop(context)},
            child: Icon(Icons.chat),
          ),
        ),
      ),
    );
  }
}

class SettingsLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              Text(
                "AgVa",
                style: TextStyle(
                  fontFamily: 'Avenir',
                  fontSize: 40,
                  color: Color.fromARGB(255, 181, 0, 100),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => About()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'About',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TermsCondition()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Terms & Conditions',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.02,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Faq()),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Color.fromARGB(255, 54, 54, 54),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'FAQ',
                          style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 218, 218, 218),
                            fontSize: MediaQuery.of(context).size.width * 0.02,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_outlined),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 1,
          child: Container(
            color: Color.fromARGB(255, 181, 0, 100),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              Text(
                'Customer Support',
                style: TextStyle(
                  fontFamily: 'Avenir',
                  color: Color.fromARGB(255, 218, 218, 218),
                  fontSize: MediaQuery.of(context).size.width * 0.02,
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address :',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        '',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Mobile No.',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Email :',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Support :',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'GST No.',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'A-1 Sector 83 Noida,',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      Text(
                        'Uttar Pradesh 201301 (IN)',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '+91-73 30 40 50 60',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'info@agvahealthcare.com',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'support@agvahelthcare.com',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '09ABLFA3988M1ZL',
                        style: TextStyle(
                            fontFamily: 'Avenir',
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 14,
                            fontWeight: FontWeight.w200),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class SettingsPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Text(
            "AgVa",
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 40,
              color: Color.fromARGB(255, 181, 0, 100),
            ),
          ),
          SizedBox(
            height: 60,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => About()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 54, 54, 54),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TermsCondition()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 54, 54, 54),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Terms & Conditions',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Faq()),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromARGB(255, 54, 54, 54),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'FAQ',
                      style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 218, 218, 218),
                        fontSize: MediaQuery.of(context).size.width * 0.05,
                      ),
                    ),
                    Icon(Icons.arrow_forward_ios_outlined),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 1,
            child: Container(
              color: Color.fromARGB(255, 181, 0, 100),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Customer Support',
            style: TextStyle(
              fontFamily: 'Avenir',
              color: Color.fromARGB(255, 218, 218, 218),
              fontSize: MediaQuery.of(context).size.width * 0.05,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Address :',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Mobile No.',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Email :',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Support :',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'GST No.',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'A-1 Sector 83 Noida,',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  Text(
                    'Uttar Pradesh 201301 (IN)',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '+91-73 30 40 50 60',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'info@agvahealthcare.com',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'support@agvahelthcare.com',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                  SizedBox(height: 10),
                  Text(
                    '09ABLFA3988M1ZL',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Color.fromARGB(255, 255, 255, 255),
                        fontSize: 16,
                        fontWeight: FontWeight.w200),
                  ),
                ],
              ),
            ],
          ),
          // GestureDetector(
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(
          //     //     builder: (context) =>  ()),
          //     // );
          //   },
          //   child: Container(
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.circular(5),
          //       color: Color.fromARGB(255, 54, 54, 54),
          //     ),
          //     child: Padding(
          //       padding:
          //           const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          //       child: Row(
          //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //         children: [
          //           Text(
          //             'Customer Support',
          //             style: TextStyle(
          //               fontFamily: 'Avenir',
          //               color: Color.fromARGB(255, 218, 218, 218),
          //               fontSize: MediaQuery.of(context).size.width * 0.05,
          //             ),
          //           ),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
