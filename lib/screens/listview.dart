// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/result_screen.dart';

class Student {
  final int studentID;
  final String firstName;
  final String status;
  final String lastName;
  final String gender;
  final String contactNumber;
  final String address;
  final String dateOfBirth;
  final String email;

  Student({
    required this.studentID,
    required this.firstName,
    required this.status,
    required this.lastName,
    required this.gender,
    required this.contactNumber,
    required this.address,
    required this.dateOfBirth,
    required this.email,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      studentID: json['StudentID'] != null
          ? int.parse(json['StudentID'].toString())
          : 0,
      firstName: json['FirstName'] != null ? json['FirstName'].toString() : '',
      lastName: json['LastName'] != null ? json['LastName'].toString() : '',
      status: json['AdmissionStatus'] != null
          ? json['AdmissionStatus'].toString()
          : '',
      gender: json['Gender'] != null ? json['Gender'].toString() : '',
      contactNumber:
          json['ContactNumber'] != null ? json['ContactNumber'].toString() : '',
      address: json['Address'] != null ? json['Address'].toString() : '',
      dateOfBirth:
          json['DateOfBirth'] != null ? json['DateOfBirth'].toString() : '',
      email: json['Email'] != null ? json['Email'].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'StudentID': studentID,
      'FirstName': firstName,
      'LastName': lastName,
      'AdmissionStatus': status,
      'Gender': gender,
      'ContactNumber': contactNumber,
      'Address': address,
      'DateOfBirth': dateOfBirth,
      'Email': email,
    };
  }
}

class SearchListViewFromAPI extends StatefulWidget {
  @override
  _SearchListViewFromAPIState createState() => _SearchListViewFromAPIState();
}

class _SearchListViewFromAPIState extends State<SearchListViewFromAPI> {
  List<Student> originalList = [];
  List<Student> filteredList = [];
  TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchDataFromAPI();
  }

  Future<void> fetchDataFromAPI() async {
    final response = await http
        .get(Uri.parse('http://169.254.131.90/students/fetch_student.php'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        originalList = data.map((item) => Student.fromJson(item)).toList();
        filteredList.addAll(originalList);
      });
    } else {
      // Handle error when fetching data from the API
    }
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      setState(() {
        filteredList.clear();
        filteredList.addAll(originalList);
      });
    } else {
      List<Student> tempSearchList = [];
      originalList.forEach((student) {
        if (student.email.toLowerCase().contains(query.toLowerCase())) {
          tempSearchList.add(student);
        }
      });
      setState(() {
        filteredList.clear();
        filteredList.addAll(tempSearchList);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.indigo, // Custom app bar color
      ),
      body: Column(
        children: [
          Container(
            height: 150,
            width: MediaQuery.of(context).size.width,
            color: Colors.indigo,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Find Your Result',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _emailController,
                    onChanged: (value) {
                      filterSearchResults(value);
                    },
                    style: TextStyle(color: Colors.white, fontSize: 18),
                    decoration: InputDecoration(
                      hintText: 'Enter your email...',
                      hintStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.indigo[700],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_emailController
              .text.isNotEmpty) // Condition to check if the email is not empty
            Expanded(
              child: ListView.builder(
                itemCount: filteredList.length,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.indigo[50],
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultScreen(
                              studentID: filteredList[index].studentID,
                              firstName: filteredList[index].firstName,
                              status: filteredList[index].status,
                              lastName: filteredList[index].lastName,
                              gender: filteredList[index].gender,
                              address: filteredList[index].address,
                              contactNumber: filteredList[index].contactNumber,
                              dateOfBirth: filteredList[index].dateOfBirth,
                              email: filteredList[index].email,
                            ),
                          ),
                        );
                      },
                      title: Text(
                        '${filteredList[index].email}',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        filteredList[index].status,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
