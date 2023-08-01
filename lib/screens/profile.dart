// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'authentication/change_email.dart';
import 'authentication/forget_password.dart';

class UserProfileScreen extends StatelessWidget {
  var name;
  var email;

  UserProfileScreen({
    Key? key,
    required this.name,
    required this.email,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    theem:
    ThemeData(primarySwatch: Colors.indigo);
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage(
                  'assets/profile_picture.png'), // Replace with your image
            ),
            const SizedBox(height: 20),
            Text(
              '$email', // Replace with the user's name
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            const Text(
              'Profile', // Replace with the user's bio or profession
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            SizedBox(height: 20),
            _buildUserInfoCard('Location', 'Somalia',
                TextStyle()), // Customize additional user details here
            InkWell(
                onTap: () {
                  Get.to(ChangeEmail());
                },
                child: _buildUserInfoCard('Email', '${email}', TextStyle())),
            InkWell(
              onTap: () {
                Get.to(UpdatePasswordForm());
              },
              child: _buildUserInfoCard("Password", "....",
                  const TextStyle(fontSize: 33, fontWeight: FontWeight.bold)),
            ) // Customize additional user details here
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(String title, String value, TextStyle fonstyl) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            Text(
              value,
              style: const TextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
