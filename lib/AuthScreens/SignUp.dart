// ignore_for_file: prefer_const_constructors, prefer_final_fields, use_build_context_synchronously, prefer_const_literals_to_create_immutables

import 'package:agva_app/AuthScreens/SignIn.dart';
import 'package:agva_app/Screens/Common/RegDone.dart';
import 'package:agva_app/Screens/Common/TermsCondition.dart';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isPhoneNumberFilled = false;
  bool passwordVisible = false;
  bool _isNotValidate = false;
  bool first = false;
  String rolesSelection = '';
  bool isPhoneNumberVerified = false;
  List<String> hospitalNames = [];
  String searchText = '';

  String specialitydropdown = 'Select Speciality';
  var specialityItems = [
    'Select Speciality',
    'Neuro Surgen',
    'Neurology',
    'Anesthesia',
    'Nurse',
    'Cardiologist',
    'General Surgery',
    'Opthalomologist',
    'Orthopedic',
    'Pathologist',
    'Obstetrics',
    'Internal Medicines',
    'Radiology',
    'Urology',
    'Plastic Surgery',
    'Pediatrics',
    'Gynaecology',
    'Psychiatry',
    'Energency Medicines',
    'Gastroenterologist',
    'Hematologist',
    'Pulmonologist',
    'Nephrologist',
  ];

  String rolesdropdown = 'Select Role';
  var rolesdropdownItems = [
    'Select Role',
    'Doctor',
    'Assistant',
    'User',
  ];

  String designationdropdown = 'Select Designation';
  var designationItems = [
    'Select Designation',
    'Dr.',
    'Dr. Prof.',
    'Prof.',
    'Nurse',
    'Support Staff',
    'Engineer',
    'Admin',
    'Owner',
  ];

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController hospitalNameController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController doctorkeyController = TextEditingController();

  void register() async {
    if (firstNameController.text.isNotEmpty &&
        lastNameController.text.isNotEmpty &&
        hospitalNameController.text.isNotEmpty &&
        departmentController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text &&
        isPhoneNumberVerified) {
      var regBody = {
        "firstName": firstNameController.text,
        "lastName": lastNameController.text,
        "hospitalName": hospitalNameController.text,
        "designation": designationdropdown != 'Select Designation'
            ? designationdropdown
            : '',
        "department": departmentController.text,
        "contactNumber": contactNumberController.text,
        "email": emailController.text,
        "passwordHash": passwordController.text,
        "speciality":
            specialitydropdown != 'Select Speciality' ? specialitydropdown : '',
        "userType": rolesdropdown != 'Select Role' ? rolesdropdown : '',
        "securityCode":
            rolesdropdown != 'Doctor' ? doctorkeyController.text : '',
      };

      var response = await http.post(
        Uri.parse(registerUser),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(regBody),
      );
      var jsonResponse = jsonDecode(response.body);
      print(jsonResponse);
      if (response.statusCode == 200) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegDone()),
        );
      } else {
        print("Something Went Wrong");
      }
    } else {
      setState(() {
        // _isNotValidate = true;
      });
    }
  }

  void sendOTPtophone(BuildContext context) async {
    String phoneNumber = contactNumberController.text;
    var response = await http.get(
      Uri.parse('$sendOtp/$phoneNumber'),
      headers: {
        "Content-Type": "application/json",
      },
    );
    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (jsonResponse['statusValue'] == 'SUCCESS') {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(minutes: 10),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        backgroundColor: Colors.white,
        content: Column(
          children: [
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "OTP",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
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
            Text(
              "Enter 4 Digit OTP",
              style: TextStyle(
                  color: const Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 20,
            ),
            OTPTextField(
              length: 4,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 40,
              style: TextStyle(fontSize: 14, color: Colors.black),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.box,
              onCompleted: (otp) {
                print("Completed OTP: $otp");
                putOTPtophone(otp);
              },
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ));
    } else {
      print('Invalid User Credential: ${response.statusCode}');
    }
  }

  void putOTPtophone(String otp) async {
    Map<String, dynamic> requestBody = {
      'otp': otp,
    };
    String requestBodyJson = jsonEncode(requestBody);

    var response = await http.post(
      Uri.parse(verifyOtp),
      headers: {
        "Content-Type": "application/json",
      },
      body: requestBodyJson,
    );

    var jsonResponse = jsonDecode(response.body);
    print(jsonResponse);
    if (response.statusCode == 200 &&
        jsonResponse['statusValue'] == 'SUCCESS') {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      setState(() {
        isPhoneNumberVerified = true;
      });
    } else {
      print('Invalid OTP: ${response.statusCode}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Invalid OTP'),
        ),
      );
    }
  }

// hospital list

  void extractHospitalNames(List<dynamic> responseData) {
    hospitalNames.clear();
    responseData.forEach((hospital) {
      hospitalNames.add(hospital['Hospital_Name']);
    });
  }

  List<String> filterHospitalList(String searchQuery) {
    return hospitalNames
        .where((hospital) =>
            hospital.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();
  }

  void onSearchTextChanged(String query) {
    setState(() {
      searchText = query;
    });
  }

  Widget buildHospitalList() {
    List<String> filteredList = filterHospitalList(searchText);
    return Padding(
      padding: const EdgeInsets.only(left: 35),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 36, 36, 36),
        ),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: filteredList.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(filteredList[index]),
              onTap: () {
                setState(() {
                  String selectedHospital = filteredList[index];
                  hospitalNameController.text = selectedHospital;
                  if (selectedHospital == hospitalNameController.text) {
                    searchText = '';
                    print(searchText);
                  }
                });
              },
            );
          },
        ),
      ),
    );
  }

  void getHospitallist() async {
    var response = await http.get(
      Uri.parse(hospitalList),
      headers: {
        "Content-Type": "application/json",
      },
    );
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      var data = jsonResponse['data'];
      extractHospitalNames(data);
    } else {
      print('Failed to get focus status: ${response.statusCode}');
    }
  }

  @override
  void initState() {
    super.initState();
    getHospitallist();
    passwordVisible = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(alignment: Alignment.center, children: [
          SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 80,
                      ),
                      Text(
                        "AgVa",
                        style: TextStyle(
                          fontFamily: 'Avenir',
                          fontSize: 40,
                          color: Color.fromARGB(255, 157, 0, 86),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 35),
                        child: Container(
                          width: 330,
                          decoration: BoxDecoration(),
                          child: DropdownButtonFormField(
                            value: designationdropdown,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                            ),
                            isDense: true,
                            decoration: InputDecoration(
                              icon: FaIcon(
                                FontAwesomeIcons.clipboardUser,
                                size: 20,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 15,
                              ),
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white70,
                                  width: 0.7,
                                ),
                              ),
                            ),
                            items: designationItems.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                designationdropdown = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 35),
                        child: Container(
                          width: 330,
                          decoration: BoxDecoration(),
                          child: DropdownButtonFormField(
                            value: rolesdropdown,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                            ),
                            isDense: true,
                            decoration: InputDecoration(
                              icon: FaIcon(
                                FontAwesomeIcons.clipboardUser,
                                size: 20,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 15,
                              ),
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white70,
                                  width: 0.7,
                                ),
                              ),
                            ),
                            items: rolesdropdownItems.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                rolesdropdown = newValue!;
                                rolesSelection = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                      if (rolesSelection == 'Assistant' ||
                          rolesSelection == 'User')
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 30, left: 30, top: 30),
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            controller: doctorkeyController,
                            style: TextStyle(color: Colors.white70),
                            decoration: InputDecoration(
                              icon: Icon(
                                Icons.numbers,
                                color: Colors.white70,
                              ),
                              hintText: 'Enter Doctor key',
                              errorText:
                                  _isNotValidate ? "Enter Proper Info" : null,
                              hintStyle: TextStyle(color: Colors.white70),
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 35),
                        child: Container(
                          width: 330,
                          decoration: BoxDecoration(),
                          child: DropdownButtonFormField(
                            value: specialitydropdown,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            iconSize: 24,
                            elevation: 16,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 16.0,
                            ),
                            isDense: true,
                            decoration: InputDecoration(
                              icon: FaIcon(
                                FontAwesomeIcons.clipboardUser,
                                size: 20,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 0,
                                vertical: 15,
                              ),
                              border: InputBorder.none,
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.white70,
                                  width: 0.7,
                                ),
                              ),
                            ),
                            items: specialityItems.map((String item) {
                              return DropdownMenuItem(
                                value: item,
                                child: Text(item),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                specialitydropdown = newValue!;
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          controller: firstNameController,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white70,
                            ),
                            hintText: 'First Name',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          controller: lastNameController,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.person,
                              color: Colors.white70,
                            ),
                            hintText: 'Last Name',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          controller: emailController,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.email,
                              color: Colors.white70,
                            ),
                            hintText: 'Enter your Email',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: hospitalNameController,
                              onChanged: onSearchTextChanged,
                              style: TextStyle(color: Colors.white70),
                              decoration: InputDecoration(
                                icon: FaIcon(
                                  FontAwesomeIcons.squareH,
                                  size: 20,
                                ),
                                hintText: 'Enter Hospital Name',
                                errorText:
                                    _isNotValidate ? "Enter Proper Info" : null,
                                hintStyle: TextStyle(color: Colors.white70),
                              ),
                            ),
                            if (searchText.isNotEmpty)
                              SingleChildScrollView(
                                  child: Container(
                                      height: 200, child: buildHospitalList())),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          controller: departmentController,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: FaIcon(
                              FontAwesomeIcons.hospitalUser,
                              size: 20,
                            ),
                            hintText: 'Enter your Department',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: IntlPhoneField(
                          controller: contactNumberController,
                          initialCountryCode: 'IN',
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.phone,
                              color: Colors.white70,
                            ),
                            hintText: 'Contact Number',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                          ),
                          onChanged: (phone) {
                            setState(() {
                              isPhoneNumberFilled = phone.number.isNotEmpty;
                            });
                          },
                        ),
                      ),
                      if (isPhoneNumberFilled && !isPhoneNumberVerified)
                        Padding(
                          padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                          child: Container(
                            height: 45,
                            width: 100,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 3,
                                    blurRadius: 20,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                                color: Colors.white,
                                gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      Color.fromARGB(255, 218, 0, 138),
                                      Color.fromARGB(255, 142, 0, 90)
                                    ])),
                            child: TextButton(
                              onPressed: () {
                                sendOTPtophone(context);
                              },
                              style: TextButton.styleFrom(),
                              child: Text(
                                "Verify",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      if (isPhoneNumberVerified)
                        Text(
                          "Verified",
                          style: TextStyle(color: Colors.green),
                        ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          controller: passwordController,
                          obscureText: passwordVisible,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white70,
                            ),
                            hintText: 'Enter your Password',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 30, left: 30),
                        child: TextFormField(
                          controller: confirmPasswordController,
                          obscureText: passwordVisible,
                          style: TextStyle(color: Colors.white70),
                          decoration: InputDecoration(
                            icon: Icon(
                              Icons.lock,
                              color: Colors.white70,
                            ),
                            hintText: 'Confirm Password',
                            errorText:
                                _isNotValidate ? "Enter Proper Info" : null,
                            hintStyle: TextStyle(color: Colors.white70),
                            suffixIcon: IconButton(
                              icon: Icon(passwordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                              onPressed: () {
                                setState(
                                  () {
                                    passwordVisible = !passwordVisible;
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: first,
                            activeColor: const Color.fromARGB(255, 184, 46, 92),
                            checkColor: Colors.white,
                            onChanged: (bool? value) {
                              setState(() {
                                first = value!;
                              });
                            },
                          ),
                          Text(
                            "I agree with ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TermsCondition(),
                                ),
                              );
                              print('Terms and Conditions clicked');
                            },
                            child: Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 45,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 20,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 218, 0, 138),
                                    Color.fromARGB(255, 142, 0, 90)
                                  ])),
                          child: TextButton(
                            onPressed: register,
                            style: TextButton.styleFrom(),
                            child: Text(
                              "SIGN UP",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 45,
                          width: 300,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 3,
                                  blurRadius: 20,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 255, 255, 255),
                                    Color.fromARGB(255, 255, 255, 255)
                                  ])),
                          child: TextButton(
                            style: TextButton.styleFrom(),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SignIn(),
                                ),
                              );
                            },
                            child: Text(
                              "SIGN IN",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 157, 0, 86),
                                  fontSize: 15),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 80,
                      ),
                    ])),
          )
        ]));
  }
}
