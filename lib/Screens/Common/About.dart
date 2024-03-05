// ignore_for_file: must_be_immutable, prefer_const_constructors, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  void initState() {
    super.initState();
     SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
  ]);
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
            'About',
            style: TextStyle(
              fontFamily: 'Avenir',
              fontSize: 24,
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
        ),
        body: OrientationBuilder(builder: (context, orientation) {
          if (orientation == Orientation.portrait) {
            return SingleChildScrollView(child: AboutPortrait());
          } else {
            return AboutLandscape();
          }
        }),
      ),
    );
  }
}

class AboutLandscape extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 10,
        ),
        Text(
          'Work in Progress',
          style: TextStyle(
            fontFamily: 'Avenir',
            color: Color.fromARGB(255, 218, 218, 218),
            fontSize: MediaQuery.of(context).size.width * 0.02,
          ),
        ),
      ],
    );
  }
}

class AboutPortrait extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 150, child: Image.asset("assets/images/company.png")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'AgVa Healthcare',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 160,
                    child: Text(
                      'AGVA HEADQUARTERS SPREAD IN HALF AND ACRE OF STATE OF THE ART RESEARCH & DEVELOPMENT FACILITY',
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 40,
          ),
          Text(
            'VISIONARIES',
            style: TextStyle(
                fontFamily: 'Avenir',
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            height: 1,
            child: Container(
              color: Color.fromARGB(255, 181, 0, 100),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Prof. Diwakar Vaish (CEO)',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 160,
                    child: Text(
                      'He is a leading Robotics scientist of the country who has filed for over 20 patents and have invented Indias first completely made in India Robot Manav and Worlds first brain controlled wheelchair. Hes also the inventor of his proprietary brain cloning technology using EEG',
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
              Container(
                  width: 150,
                  child: Image.asset("assets/images/profdiwakar.png")),
            ],
          ),
          SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 1,
            child: Container(
              color: Color.fromARGB(255, 181, 0, 100),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 150, child: Image.asset("assets/images/drdeepak.png")),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr. Deepak Agarwal',
                    style: TextStyle(
                        fontFamily: 'Avenir',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 160,
                    child: Text(
                      'Dr Deepak Agarwal is a pioneer and one of the world renowned name in neurosurgery. He is currently a practicing neurosurgeon at Indias most premier medical institute AIIMS New Delhi',
                      style: TextStyle(
                          fontFamily: 'Avenir',
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w200),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
