import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'admission_screen.dart';

class Scholarship {
  final int id;
  final String title;
  final String description;
  final String imageLink;

  Scholarship({
    required this.id,
    required this.title,
    required this.description,
    required this.imageLink,
  });

  // Function to fetch scholarships from the PHP API
  static Future<List<Scholarship>> fetchScholarships() async {
    final response = await http
        .get(Uri.parse('http://169.254.131.90/students/get_scholarships.php'));

    if (response.statusCode == 200) {
      List<dynamic> jsonData = jsonDecode(response.body);
      List<Scholarship> scholarships = jsonData
          .map((data) => Scholarship(
                id: int.parse(data['id'].toString()), // Parse id as int
                title: data['title'],
                description: data['description'],
                imageLink: data['imageLink'],
              ))
          .toList();
      return scholarships;
    } else {
      throw Exception('Failed to load scholarships');
    }
  }
}

class ScholarshipListScreen extends StatefulWidget {
  @override
  _ScholarshipListScreenState createState() => _ScholarshipListScreenState();
}

class _ScholarshipListScreenState extends State<ScholarshipListScreen> {
  late Future<List<Scholarship>> _futureScholarships;

  @override
  void initState() {
    super.initState();
    _futureScholarships = Scholarship.fetchScholarships();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scholarships'),
      ),
      body: FutureBuilder<List<Scholarship>>(
        future: _futureScholarships,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            List<Scholarship> scholarships = snapshot.data!;
            return Center(
              child: ListView.builder(
                itemCount: scholarships.length,
                itemBuilder: (context, index) {
                  var scholarship = scholarships[index];
                  return Center(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0, 2),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScholarshipDetailScreen(
                                        scholarship: scholarship,
                                      )));
                        },
                        leading: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(scholarship.imageLink),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          scholarship.title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(scholarship.description),
                      ),
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}

class ScholarshipDetailScreen extends StatelessWidget {
  final Scholarship scholarship;

  ScholarshipDetailScreen({required this.scholarship});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scholarship Details'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(scholarship.imageLink),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              scholarship.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            SizedBox(height: 8),
            Text(scholarship.description),
            ElevatedButton(
                onPressed: () {
                  Get.to(TransfterData());
                },
                child: Text("Apply"))
          ],
        ),
      ),
    );
  }
}
