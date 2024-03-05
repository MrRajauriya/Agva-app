import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../config.dart';

class AddDiagnose extends StatefulWidget {
  final String UHID;
  AddDiagnose(this.UHID);

  @override
  State<AddDiagnose> createState() => _AddDiagnoseState();
}

class _AddDiagnoseState extends State<AddDiagnose> {


  late String UHID;
  List<dynamic> userData = [];

  bool isLoading = true;

  void initState() {
    super.initState();
    print(widget.UHID);
  }

  TextEditingController medicineController = TextEditingController();
  TextEditingController procedureController = TextEditingController();
  TextEditingController otherController = TextEditingController();
     Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('mytoken');
  }


  void addDiagnoseData() async {
      String? token = await getToken();
    var regBody = {
      "medicine": medicineController.text,
      "procedure": procedureController.text,
      "others": otherController.text,
    };

    var response = await http.post(
      Uri.parse('$addDiagnoseDetails/${widget.UHID}'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": 'Bearer $token',
      },
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200) {
      print(jsonResponse['data']);
      print('Patient data added successfully');
    } else {
      print("Something Went Wrong");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Diagnose'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            TextFormField(
              readOnly: true,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.person,
                  color: Colors.white70,
                ),
                hintText: widget.UHID,
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: medicineController,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.medication,
                  color: Colors.white70,
                ),
                hintText: 'Enter Medicine Name',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: procedureController,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.scatter_plot_sharp,
                  color: Colors.white70,
                ),
                hintText: 'Enter Procedure',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 40,
            ),
            TextFormField(
              controller: otherController,
              style: TextStyle(color: Colors.white70),
              decoration: InputDecoration(
                icon: Icon(
                  Icons.edit,
                  color: Colors.white70,
                ),
                hintText: 'Discription',
                hintStyle: TextStyle(color: Colors.white70),
              ),
            ),
            SizedBox(
              height: 80,
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
              child: Container(
                height: 45,
                width: 250,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Color.fromARGB(255, 218, 0, 138),
                          Color.fromARGB(255, 142, 0, 90)
                        ])),
                child: TextButton(
                  onPressed: addDiagnoseData,
                  style: TextButton.styleFrom(),
                  child: Text(
                    "SUBMIT",
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
