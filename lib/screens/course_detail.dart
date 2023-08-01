// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CourseDetail extends StatelessWidget {
  final int courseId;
  final String courseCode;
  final String courseName;
  final String description;
  final int departmentId;
  final String duration;
  final double fee;
  const CourseDetail({
    Key? key,
    required this.courseId,
    required this.courseCode,
    required this.courseName,
    required this.description,
    required this.departmentId,
    required this.duration,
    required this.fee,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("${courseName}"), actions: []),
        body: Center(
            child: Column(children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 40),
            child: Table(
              defaultColumnWidth: FixedColumnWidth(120.0),
              border: TableBorder.all(
                  color: Colors.black, style: BorderStyle.solid, width: 2),
              children: [
                TableRow(children: [
                  Column(children: [
                    Text('CourseName',
                        style: TextStyle(
                          fontSize: 35.0,
                        ))
                  ]),
                  Column(children: [
                    Text('Duration', style: TextStyle(fontSize: 35.0))
                  ]),
                  Column(children: [
                    Text('fee', style: TextStyle(fontSize: 35.0))
                  ]),
                ]),
                TableRow(children: [
                  Column(children: [
                    Text(
                      '${courseName}',
                      style: TextStyle(fontSize: 33),
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${duration}',
                      style: TextStyle(fontSize: 33),
                    )
                  ]),
                  Column(children: [
                    Text(
                      '${fee}',
                      style: TextStyle(fontSize: 33),
                    )
                  ]),
                ]),
              ],
            ),
          ),
        ])));
  }
}
