import 'package:flutter/material.dart';

class ResultScreen extends StatelessWidget {
  final int studentID;
  final String firstName;
  final String status;
  final String lastName;
  final String gender;
  final String contactNumber;
  final String address;
  final String dateOfBirth;
  final String email;

  ResultScreen({
    required this.studentID,
    required this.firstName,
    String? status, // Allow null for admission status
    required this.lastName,
    required this.gender,
    required this.contactNumber,
    required this.address,
    required this.dateOfBirth,
    required this.email,
  }) : status = status ?? "Pending"; // Set "Pending" if status is null

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(
          fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget _buildDescriptionItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label + ':',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 5),
          Text(
            value,
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Result',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        backgroundColor: Colors.indigo,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 30,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        color: Colors.indigo[900],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hello, ${firstName}",
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.indigo[700],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionHeader('Student Name'),
                      SizedBox(height: 5),
                      Text(
                        '$firstName $lastName',
                        style: TextStyle(fontSize: 24, color: Colors.white),
                      ),
                      SizedBox(height: 20),
                      _buildSectionHeader('Description'),
                      SizedBox(height: 5),
                      _buildDescriptionItem('Email', email),
                      _buildDescriptionItem('Address', address),
                      _buildDescriptionItem('Date of Birth', dateOfBirth),
                      _buildDescriptionItem('Contact Number', contactNumber),
                      _buildDescriptionItem('Gender', gender),
                      _buildDescriptionItem('Admission Status', status),
                    ],
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
