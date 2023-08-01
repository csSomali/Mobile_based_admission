import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool visible = false;

  // Getting value from TextField widget.
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future userRegistration() async {
    // Showing CircularProgressIndicator.
    setState(() {
      visible = true;
    });

    // Getting value from Controller
    String name = nameController.text;
    String email = emailController.text;
    String password = passwordController.text;

    // SERVER API URL
    var url = 'http://169.254.131.90/students/user_register.php';

    // Store all data with Param Name.
    var data = {'name': name, 'email': email, 'password': password};

    // Starting Web API Call.
    var response = await http.post(Uri.parse(url), body: json.encode(data));

    // Getting Server response into variable.
    var message = jsonDecode(response.body);

    // If Web call Success than Hide the CircularProgressIndicator.
    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });
    }

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
                    controller: nameController,
                    decoration: InputDecoration(
                        hintText: "Name", icon: Icon(Icons.person)),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Email", icon: Icon(Icons.email)),
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
                    userRegistration();
                  },
                  child: Container(
                    height: 65,
                    width: MediaQuery.sizeOf(context).width * 0.7,
                    decoration: BoxDecoration(
                        color: Colors.indigo,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(
                        child: Text(
                      "Register",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )),
                  ),
                ),
                Visibility(
                    visible: visible,
                    child: Container(
                      child: CircularProgressIndicator(
                        color: Colors.indigo,
                      ),
                    )),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("I have an Acount?"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
