import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransfterData extends StatefulWidget {
  const TransfterData({super.key});

  TransfterDataWidget createState() => TransfterDataWidget();
}

class TransfterDataWidget extends State<TransfterData> {
  // Getting value from TextField widget.
  final fnameController = TextEditingController();
  final lnameController = TextEditingController();
  final dobController = TextEditingController();
  final genderController = TextEditingController();
  final contactNumberController = TextEditingController();
  final emailNumberController = TextEditingController();
  final addressController = TextEditingController();
  final nationalityController = TextEditingController();
  final admissionController = TextEditingController();
  final studIdController = TextEditingController();
  final imageController = TextEditingController();

  // Boolean variable for CircularProgressIndicator.
  bool visible = false;

  Future webCall() async {
    // Showing CircularProgressIndicator using State.
    setState(() {
      visible = true;
    });

    String studenid = studIdController.text;
    String fname = fnameController.text;
    String lname = lnameController.text;
    String dob = dobController.text;
    String gender = genderController.text;
    String contacNumber = contactNumberController.text;
    String email = emailNumberController.text;
    String address = addressController.text;
    String nationality = nationalityController.text;
    String admission = admissionController.text;

    var url = 'http://192.168.64.2/students/insertIntoadmission.php';

    var data = {
      'StudentID': studenid,
      'FirstName': fname,
      'LastName': lname,
      'DateOfBirth': dob,
      'Gender': gender,
      'ContactNumber': contacNumber,
      'Email': email,
      'Address': address,
      'Nationality': nationality,
      'AdmissionStatus': admission
    };

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    var message = jsonDecode(response.body);

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

    // Showing Alert Dialog with Response JSON.
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(message),
          actions: <Widget>[
            ElevatedButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    genderController.text = 'Male';
  }

  // Function to pick an image from the gallery

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 33,
                          color: Colors.indigo,
                        ),
                      ),
                      Text(
                        'Fill All Information',
                        style: TextStyle(fontSize: 22, color: Colors.indigo),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: fnameController,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter First Name'),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: lnameController,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter Last Name'),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: dobController,
                    autocorrect: true,
                    // textInputAction:
                    decoration: InputDecoration(
                      hintText: 'Enter Birth Date',
                      icon: Icon(Icons.calendar_today_rounded),
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(
                            2000), //DateTime.now() - not to allow to choose before today.
                        lastDate: DateTime(2101),
                      );
                      if (pickedDate != null) {
                        print(
                            pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                        String formattedDate =
                            DateFormat('yy-MM-dd').format(pickedDate);
                        print(
                            formattedDate); //formatted date output using intl package =>  2021-03-16
                        //you can implement different kind of Date Format here according to your requirement

                        setState(() {
                          dobController.text =
                              formattedDate; //set output date to TextField value.
                        });
                      } else {
                        dobController.text =
                            "fadlangali xiliga aad dhalatay,".toString();
                      }
                    },
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: DropdownButtonFormField<String>(
                    value: genderController.text,
                    onChanged: (String? newValue) {
                      setState(() {
                        genderController.text = newValue!;
                      });
                    },
                    items: <String>['Male', 'Female'].map((String gender) {
                      return DropdownMenuItem<String>(
                        value: gender,
                        child: Text(gender),
                      );
                    }).toList(),
                    decoration: InputDecoration(hintText: 'Select Gender'),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: contactNumberController,
                    autocorrect: true,
                    decoration:
                        InputDecoration(hintText: 'Enter Contact Number'),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: emailNumberController,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter Email'),
                  ),
                ),
                Container(
                  width: 280,
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: addressController,
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter Address'),
                  ),
                ),
                ElevatedButton(
                  onPressed: webCall,
                  child: Text('Submit'),
                ),
                Visibility(
                  visible: visible,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
