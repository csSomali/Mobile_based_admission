import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:project/screens/authentication/signup_screen.dart';

import '../home.dart';
import 'forget_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool visible = false;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  Future userLogin() async {
    setState(() {
      visible = true;
    });

    String email = emailController.text;
    String password = passwordController.text;

    var url = 'http://169.254.131.90/students/user_login.php';

    var data = {'email': email, 'password': password};

    var response = await http.post(Uri.parse(url), body: json.encode(data));

    var message = jsonDecode(response.body);

    if (message == 'Login Matched') {
      setState(() {
        visible = false;
      });

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    profilemail: email,
                    profilepassword: password,
                  )));
    } else {
      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text(message),
            actions: <Widget>[
              OutlinedButton(
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
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email", icon: Icon(Icons.person)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: InputDecoration(
                        hintText: "Password", icon: Icon(Icons.lock)),
                  ),
                ),
                InkWell(
                  onTap: () {
                    userLogin();
                  },
                  child: Container(
                    height: 65,
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Text(
                      "Login",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                      child: CircularProgressIndicator(color: Colors.indigo),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: const Text("Don't have an Acount?")),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UpdatePasswordForm()));
                    },
                    child: const Text("forgetpassword"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
