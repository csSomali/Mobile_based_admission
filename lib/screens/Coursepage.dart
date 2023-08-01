import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'course_detail.dart';

class Course {
  final int courseId;
  final String courseCode;
  final String courseName;
  final String description;
  final int departmentId;
  final String duration;
  final double fee;

  Course({
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.description,
    required this.departmentId,
    required this.duration,
    required this.fee,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseId: int.parse(json['CourseID']),
      courseCode: json['CourseCode'],
      courseName: json['CourseName'],
      description: json['Description'],
      departmentId: int.parse(json['DepartmentID']),
      duration: json['Duration'],
      fee: double.parse(json['Fee']),
    );
  }
}

class CourseListScreen extends StatefulWidget {
  @override
  State<CourseListScreen> createState() => _CourseListScreenState();
}

class _CourseListScreenState extends State<CourseListScreen> {
  List<Course> courses = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://169.254.131.90/students/course.php'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      setState(() {
        courses = List<Course>.from(
            jsonData.map((course) => Course.fromJson(course)));
      });
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Course List')),
      body: ListView.builder(
        itemCount: courses.length,
        itemBuilder: (context, index) {
          final course = courses[index];
          return Card(
            child: ListTile(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CourseDetail(
                            courseId: course.courseId,
                            courseCode: course.courseCode,
                            courseName: course.courseName,
                            description: course.description,
                            departmentId: course.departmentId,
                            duration: course.duration,
                            fee: course.fee)));
              },
              title: Text(
                course.courseName,
                style: TextStyle(fontSize: 23),
              ),
              subtitle: Text(course.courseCode),
              trailing: Text('\$${course.fee.toStringAsFixed(2)}'),
            ),
          );
        },
      ),
    );
  }
}
