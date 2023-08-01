import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChangeEmail extends StatefulWidget {
  @override
  _ChangeEmailState createState() => _ChangeEmailState();
}

class _ChangeEmailState extends State<ChangeEmail> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _newemailController = TextEditingController();
  bool visible = false;
  Future<void> _updatePassword() async {
    setState(() {
      visible = true;
    });
    final String url = 'http://169.254.131.90/students/email_update.php';
    final response = await http.post(
      Uri.parse(url),
      body: {
        'email': _emailController.text,
        'email': _newemailController.text,
      },
    );
    var msg = jsonDecode(response.body);
    String message = msg.toString();

    if (response.statusCode == 200) {
      setState(() {
        visible = false;
      });

      // Handle the success response here
    } else {
      // Handle the error response here
    }
    // ignore: use_build_context_synchronously
    showDialog(
      context: context,
      builder: (context) {
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
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration:
                  InputDecoration(labelText: 'Email', icon: Icon(Icons.email)),
            ),
            TextField(
              controller: _newemailController,
              decoration: InputDecoration(
                  labelText: 'New Password', icon: Icon(Icons.lock)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 65,
              width: MediaQuery.sizeOf(context).width * 0.7,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: ElevatedButton(
                onPressed: _updatePassword,
                child: Text('Update Email'),
              ),
            ),
            Visibility(
              visible: visible,
              child: CircularProgressIndicator(
                color: Colors.indigo,
              ),
            )
          ],
        ),
      ),
    );
  }
}
