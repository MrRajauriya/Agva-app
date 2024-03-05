// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_interpolation_to_compose_strings, library_private_types_in_public_api, avoid_print

import 'dart:convert';
import 'dart:io';
import 'package:agva_app/Screens/Doctor&Assistant/AddDiagnose.dart';
import 'package:agva_app/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;

class AddPatientData extends StatefulWidget {
  final String UHID;
  final String deviceId;
  AddPatientData(this.UHID, this.deviceId, {super.key});

  @override
  _AddPatientDataState createState() => _AddPatientDataState();
}

class _AddPatientDataState extends State<AddPatientData> {
  late String UHID;
  late String deviceId;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();
  String? _fileName;
  List<PlatformFile>? _paths;
  bool _isLoading = false;
  bool _userAborted = false;
  bool first = false;

  // TextEditingController enterdeviceIDController = TextEditingController();
  TextEditingController enterpatientnameController = TextEditingController();
  TextEditingController enterpatientageController = TextEditingController();
  TextEditingController enterheightincmController = TextEditingController();
  TextEditingController enterweightinkgController = TextEditingController();
  TextEditingController enterhospitalnameController = TextEditingController();
  TextEditingController enterdrnameController = TextEditingController();
  TextEditingController enterwardnoController = TextEditingController();
  TextEditingController enterdasageController = TextEditingController();

  String? get uploadURL => null;

  @override
  void initState() {
    super.initState();
    print(widget.UHID);
    print(widget.deviceId);
  }

  void addPatientdata() async {
    var regBody = {
      "UHID": widget.UHID,
      "age": enterpatientageController.text,
      "deviceId": widget.deviceId,
      "doctor_name": enterdrnameController.text,
      "dosageProvided": enterdasageController.text,
      "height": enterheightincmController.text,
      "hospitalName": enterhospitalnameController.text,
      "patientName": enterpatientnameController.text,
      "ward_no": enterwardnoController.text,
      "weight": enterweightinkgController.text
    };

    var response = await http.post(
      Uri.parse(updatePatientDetails),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(regBody),
    );
    var jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print(jsonResponse['data']);
      print('Patient data added successfully');
    } else {
      print("Something Went Wrong");
    }
  }

//  image upload api
// Uri.parse('$patientFileupload/${enterdeviceIDController.text}/${enteruhidController.text}'),
  void _pickFiles() async {
    _resetState();
    try {
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.custom,
        onFileLoading: (FilePickerStatus status) => print(status),
        allowedExtensions: ['jpeg', 'jpg', 'heic', 'pdf', 'png'],
      ))
          ?.files;
      if (_paths != null && _paths!.isNotEmpty) {
        // If files are selected, upload the first file
        _uploadFile(_paths!.first);
        // Add logging for file data
        print('File name: ${_paths!.first.name}');
        print('File size: ${_paths!.first.size}');
      }
    } on PlatformException catch (e) {
      _logException('Unsupported operation' + e.toString());
    } catch (e) {
      _logException(e.toString());
    }
    if (!mounted) return;
    setState(() {
      _isLoading = false;
      _fileName = _paths != null ? _paths!.first.name : '...';
      _userAborted = _paths == null;
    });
  }

  void _uploadFile(PlatformFile file) async {
    try {
      if (file.bytes != null) {
        var uri = Uri.parse(
            '$patientFileupload/${widget.deviceId}/${widget.UHID}'); // Replace uploadURL with your actual URL
        var request = http.MultipartRequest("POST", uri);
        // request.files.add(http.MultipartFile.fromBytes(
        //   "file",
        //   file.bytes!,
        //   filename: file.name,
        // ));
        //         request.files.add(http.MultipartFile.fromPath(

        // ));
        var response = await request.send();
        if (response.statusCode == 200) {
          // File uploaded successfully
          print('File uploaded successfully');
          // Optionally, you can add logic here to handle the response from the server
        } else {
          print('Failed to upload file: ${response.reasonPhrase}');
        }
      } else {
        print('Error: File bytes are null');
      }
    } catch (e) {
      print('Error uploading file: $e');
    }
  }

  // void _pickFiles() async {
  //   _resetState();
  //   try {
  //     _paths = (await FilePicker.platform.pickFiles(
  //       type: FileType.custom,
  //       onFileLoading: (FilePickerStatus status) => print(status),
  //       allowedExtensions: ['jpeg', 'jpg', 'heic', 'pdf', 'png'],
  //     ))
  //         ?.files;
  //   } on PlatformException catch (e) {
  //     _logException('Unsupported operation' + e.toString());
  //   } catch (e) {
  //     _logException(e.toString());
  //   }
  //   if (!mounted) return;
  //   setState(() {
  //     _isLoading = false;
  //     _fileName =
  //         _paths != null ? _paths!.map((e) => e.name).toString() : '...';
  //     _userAborted = _paths == null;
  //   });
  // }

  void _logException(String message) {
    print(message);
    _scaffoldMessengerKey.currentState?.hideCurrentSnackBar();
    _scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }

//export
  void _resetState() {
    if (!mounted) {
      return;
    }
    setState(() {
      _isLoading = true;
      _fileName = null;
      _userAborted = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _scaffoldMessengerKey;
    return Scaffold(
        backgroundColor: Colors.black,
        key: _scaffoldKey,
        appBar: AppBar(
           actions: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddDiagnose(widget.UHID),
                    ),
                  );
                },
              ),
            )
          ],
          title: Text(
            "Add Patient Details",
          ),
          backgroundColor: Colors.black,
        ),
        body: Stack(alignment: Alignment.center, children: [
          SingleChildScrollView(
              child: Container(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: TextFormField(
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
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 30, left: 30),
                child: TextFormField(
                   readOnly: true,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.important_devices,
                      color: Colors.white70,
                    ),
                    hintText: widget.deviceId,
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
                  controller: enterpatientnameController,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.person,
                      size: 20,
                    ),
                    hintText: 'Enter Patient Name',
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
                  controller: enterpatientageController,
                  style: TextStyle(color: Colors.white70),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.person,
                      size: 20,
                    ),
                    hintText: 'Enter Patient Age',
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
                  controller: enterheightincmController,
                  style: TextStyle(color: Colors.white70),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.person,
                      size: 20,
                    ),
                    hintText: 'Enter Height in cm',
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
                  controller: enterweightinkgController,
                  style: TextStyle(color: Colors.white70),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.person,
                      size: 20,
                    ),
                    hintText: 'Enter Weight in kg',
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
                  controller: enterhospitalnameController,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: FaIcon(
                      FontAwesomeIcons.hospital,
                      size: 20,
                    ),
                    hintText: 'Enter Hospital Name',
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
                  controller: enterdasageController,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.medical_information,
                      color: Colors.white70,
                    ),
                    hintText: 'Dosage Provided',
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
                  controller: enterdrnameController,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.person,
                      color: Colors.white70,
                    ),
                    hintText: 'Enter Dr. Name',
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
                  controller: enterwardnoController,
                  style: TextStyle(color: Colors.white70),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.cabin,
                      color: Colors.white70,
                    ),
                    hintText: 'Enter Ward No.',
                    hintStyle: TextStyle(color: Colors.white70),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
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
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                      color: Colors.white,
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.white,
                          ])),
                  child: TextButton(
                    onPressed: () => _pickFiles(),
                    style: TextButton.styleFrom(),
                    child: Text(
                      "Select Image",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                ),
              ),
              Builder(
                builder: (BuildContext context) => _isLoading
                    ? Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 5.0,
                                ),
                                child: const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                        ],
                      )
                    : _userAborted
                        ? Row(
                            children: [
                              Expanded(
                                child: Center(
                                  child: SizedBox(
                                    height: 10,
                                    child: ListTile(
                                      leading: Icon(
                                        Icons.error_outline,
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 10.0),
                                      title: const Text(
                                        'User has aborted the dialog',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : _paths != null
                            ? Container(
                                padding: EdgeInsets.symmetric(
                                    // vertical: 1.0,
                                    horizontal: 30),
                                height:
                                    MediaQuery.of(context).size.height * 0.1,
                                child: ListView.builder(
                                  itemCount:
                                      _paths != null && _paths!.isNotEmpty
                                          ? _paths!.length
                                          : 1,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final bool isMultiPath =
                                        _paths != null && _paths!.isNotEmpty;
                                    final String name = 'File:' +
                                        (isMultiPath
                                            ? _paths!
                                                .map((e) => e.name)
                                                .toList()[index]
                                            : _fileName ?? '...');
                                    Upload(File img) async {
                                      var uri = Uri.parse(uploadURL!);
                                      var request =
                                          http.MultipartRequest("POST", uri);
                                      request.files
                                          .add(http.MultipartFile.fromBytes(
                                        "file",
                                        img.readAsBytesSync(),
                                        filename: "Photo.jpg",
                                      ));

                                      var response = await request.send();
                                      print(response.statusCode);
                                      response.stream
                                          .transform(utf8.decoder)
                                          .listen((value) {
                                        print(value);
                                      });
                                    }

                                    return ListTile(
                                      title: Text(
                                        name,
                                      ),
                                    );
                                  },
                                ),
                              )
                            : SizedBox(
                                height: 1,
                              ),
              ),
              SizedBox(
                height: 20,
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
                          offset: Offset(0, 3), // changes position of shadow
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
                    onPressed: addPatientdata,
                    style: TextButton.styleFrom(),
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ]),
          )),
        ]));
  }
}
