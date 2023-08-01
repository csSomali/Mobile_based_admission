import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:project/screens/authentication/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: Scaffold(
        drawer: Container(
          width: MediaQuery.of(context).size.width * 0.5, //<-- SEE HERE
          child: Drawer(),
        ),
        body: Center(
          child: LoginScreen(),
        ),
      ),
    );
  }
}
