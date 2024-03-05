// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserControl extends StatefulWidget {
  @override
  State<UserControl> createState() => _UserControlState();
}

class _UserControlState extends State<UserControl> {
  List<dynamic> userData = [];
  List<dynamic> inactiveuserData = [];
  List<dynamic> requestsuserData = [];
  String updateUser = 'Active Users';
  bool isLoading = true;
  bool getdata = true;

  @override
  void initState() {
    super.initState();
    getActiveUser();
    getinActiveUser();
    getPendingUser();
  }

  void removeUser(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');

    if (mytoken != null) {
      var response = await http.put(
        Uri.parse('$updateUserstatus/$userID'),
        headers: {
          "Authorization": 'Bearer $mytoken',
          "Content-Type": "application/json",
        },
        body: jsonEncode({"accountStatus": "Inactive"}),
      );
      if (response.statusCode == 200) {
        print(response.statusCode);
        print('user removed');
        setState(() {
          getdata = false;
                  getActiveUser();
           getPendingUser();
        });

      } else {
        print('Failed to update focus status: ${response.statusCode}');
      }
    } else {
      print("Token is null");
    }
  }

  void activeUser(String userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');

    if (mytoken != null) {
      var response = await http.put(
        Uri.parse('$updateUserstatus/$userID'),
        headers: {
          "Authorization": 'Bearer $mytoken',
          "Content-Type": "application/json",
        },
        body: jsonEncode({"accountStatus": "Active"}),
      );
      if (response.statusCode == 200) {
           print(response.statusCode);
                   print('user active');
            getinActiveUser();
               getPendingUser();
      } else {
        print('Failed to update focus status: ${response.statusCode}');
      }
    } else {
      print("Token is null");
    }
  }

  void getActiveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    if (mytoken != null) {
      var response = await http.get(
        Uri.parse(getActiveUsers),
        headers: {
          "Authorization": 'Bearer $mytoken',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      if (jsonResponse['statusCode'] == 200) {
        setState(() {
          userData = jsonResponse['data'];
          isLoading = false;
        });
      } else {
        print('Invalid User Credential: ${response.statusCode}');
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  void getinActiveUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    if (mytoken != null) {
      var response = await http.get(
        Uri.parse(getInactiveUsers),
        headers: {
          "Authorization": 'Bearer $mytoken',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      if (jsonResponse['statusCode'] == 200) {
        setState(() {
          inactiveuserData = jsonResponse['data'];
        });
      } else {
        print('Invalid User Credential: ${response.statusCode}');
      }
    }
  }

  void getPendingUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? mytoken = prefs.getString('mytoken');
    if (mytoken != null) {
      var response = await http.get(
        Uri.parse(getPendingUsers),
        headers: {
          "Authorization": 'Bearer $mytoken',
        },
      );
      var jsonResponse = jsonDecode(response.body);
      // print(jsonResponse);
      if (jsonResponse['statusCode'] == 200) {
        setState(() {
          requestsuserData = jsonResponse['data'];
        });
      } else {
        print('Invalid User Credential: ${response.statusCode}');
      }
    }
  }
// String formatDateTime(String dateTimeString) {
//   DateTime dateTime = DateTime.parse(dateTimeString);
//   return DateFormat.yMd().add_jm().format(dateTime);
// }

  List<Widget> buildRequestsUserWidgets(List<dynamic> requestsuserData,
      Function(String) removeUser, Function(String) activeUser) {
    return requestsuserData.map((user) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
             height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :'),
                          Text('Speciality :'),
                          Text('Contact :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['firstName']} ${user['lastName']}'),
                          Text('${user['speciality']}'),
                          Text('${user['contactNumber']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              await activeUser(user['_id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            child: Text(
                              "Accept",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              await removeUser(user['_id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              "Remove",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

// inactive user list
  List<Widget> buildInactiveUserWidgets(
      List<dynamic> inactiveuserData, Function(String) activeUser) {
    return inactiveuserData.map((user) {
      return Column(
        children: [
          
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :'),
                          Text('Speciality :'),
                          Text('Contact :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['firstName']} ${user['lastName']}'),
                          Text('${user['speciality']}'),
                          Text('${user['contactNumber']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                    child: Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await activeUser(user['_id']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  // active user list

  List<Widget> buildActiveUserWidgets(
      List<dynamic> userData, Function(String) removeUser) {
    return userData.map((user) {
      return Column(
        children: [
          
          //  if (getdata)
          // SizedBox(
          //   height: 1,
          //   child: Center(child: LinearProgressIndicator(color: Colors.pink)),
          // ) else
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
             height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :'),
                          Text('Speciality :'),
                          Text('Contact :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['firstName']} ${user['lastName']}'),
                          Text('${user['speciality']}'),
                          Text('${user['contactNumber']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              await removeUser(user['_id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            child: Text(
                              "Remove",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
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
              "User Control",
              style: TextStyle(
                fontFamily: 'Avenir',
                fontSize: 24,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
            ),
          ),
          body: OrientationBuilder(builder: (context, orientation) {
            if (orientation == Orientation.portrait) {
              return SingleChildScrollView(
                  child: _buildPortraitLayout(context));
            } else {
              return SingleChildScrollView(child: _buildLandscapeLayout(context));
            }
          })),
    );
  }

  Widget _buildPortraitLayout(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    updateUser = 'Active Users';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: updateUser == 'Active Users'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Text(
                    'Active Users',
                    style: TextStyle(
                      color: updateUser == 'Active Users'
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    updateUser = 'InActive Users';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: updateUser == 'InActive Users'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Text(
                    'InActive Users',
                    style: TextStyle(
                      color: updateUser == 'InActive Users'
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    updateUser = 'Requests';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.05,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: updateUser == 'Requests'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Text(
                    'Requests',
                    style: TextStyle(
                      color: updateUser == 'Requests'
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        if (isLoading)
          SizedBox(
            height: 1,
            child: Center(child: LinearProgressIndicator(color: Colors.pink)),
          )
        // else if (userData.isEmpty)
        //     SizedBox(
        //       child: Text(
        //         'No data',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     )
        else
          Column(
            children: updateUser == 'Active Users'
                ? buildActiveUserWidgets(userData, removeUser)
                : updateUser == 'InActive Users'
                    ? buildInactiveUserWidgets(inactiveuserData, activeUser)
                    : buildRequestsUserWidgets(
                        requestsuserData, activeUser, removeUser),
          ),
      ],
    );
  }

  Widget _buildLandscapeLayout(BuildContext context) {
    
   return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    updateUser = 'Active Users';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: updateUser == 'Active Users'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Text(
                    'Active Users',
                    style: TextStyle(
                      color: updateUser == 'Active Users'
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    updateUser = 'InActive Users';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: updateUser == 'InActive Users'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Text(
                    'InActive Users',
                    style: TextStyle(
                      color: updateUser == 'InActive Users'
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    updateUser = 'Requests';
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 0.10,
                  width: MediaQuery.of(context).size.width * 0.25,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: updateUser == 'Requests'
                        ? Colors.white
                        : Colors.transparent,
                  ),
                  child: Text(
                    'Requests',
                    style: TextStyle(
                      color: updateUser == 'Requests'
                          ? Colors.black
                          : Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.035,
        ),
        if (isLoading)
          SizedBox(
            height: 1,
            child: Center(child: LinearProgressIndicator(color: Colors.pink)),
          )
        // else if (userData.isEmpty)
        //     SizedBox(
        //       child: Text(
        //         'No data',
        //         style: TextStyle(color: Colors.white),
        //       ),
        //     )
        else
          Column(
            children: updateUser == 'Active Users'
                ? buildActiveUserWidget(userData, removeUser)
                : updateUser == 'InActive Users'
                    ? buildInactiveUserWidget(inactiveuserData, activeUser)
                    : buildRequestsUserWidget(
                        requestsuserData, activeUser, removeUser),
          ),
      ],
    );
  }
 List<Widget> buildRequestsUserWidget(List<dynamic> requestsuserData,
      Function(String) removeUser, Function(String) activeUser) {
    return requestsuserData.map((user) {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
             height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :'),
                          Text('Speciality :'),
                          Text('Contact :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['firstName']} ${user['lastName']}'),
                          Text('${user['speciality']}'),
                          Text('${user['contactNumber']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              await activeUser(user['_id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            child: Text(
                              "Accept",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              await removeUser(user['_id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: Text(
                              "Remove",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

// inactive user list
  List<Widget> buildInactiveUserWidget(
      List<dynamic> inactiveuserData, Function(String) activeUser) {
    return inactiveuserData.map((user) {
      return Column(
        children: [
          
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :'),
                          Text('Speciality :'),
                          Text('Contact :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['firstName']} ${user['lastName']}'),
                          Text('${user['speciality']}'),
                          Text('${user['contactNumber']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                    child: Container(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        onPressed: () async {
                          await activeUser(user['_id']);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pink,
                        ),
                        child: Text(
                          "Active",
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

  // active user list

  List<Widget> buildActiveUserWidget(
      List<dynamic> userData, Function(String) removeUser) {
    return userData.map((user) {
      return Column(
        children: [
          
          //  if (getdata)
          // SizedBox(
          //   height: 1,
          //   child: Center(child: LinearProgressIndicator(color: Colors.pink)),
          // ) else
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.025,
          ),
          Container(
             height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 60, 60, 60),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Name :'),
                          Text('Speciality :'),
                          Text('Contact :'),

                          // Text('Last Active :'),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${user['firstName']} ${user['lastName']}'),
                          Text('${user['speciality']}'),
                          Text('${user['contactNumber']}'),

                          // Text('${user['lastLogin']}'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  ),
                  Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, 22, 0),
                        child: Container(
                          height: 30,
                          width: 100,
                          child: ElevatedButton(
                            onPressed: () async {
                              await removeUser(user['_id']);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.pink,
                            ),
                            child: Text(
                              "Remove",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      );
    }).toList();
  }

}

