//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'after.dart';

class Login extends StatefulWidget {
  Login({Key? key, this.Password, this.username}) : super(key: key);
  String? username;
  String? Password;

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<Login> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final storage = FlutterSecureStorage();

  String _errorMessage = '';

  Future<void> onPressed() async {
    var url = Uri.http('10.50.6.191:5000', '/login');
    final Map<String, dynamic> jsonData = {
      'username': _usernameController.text,
      'password': _passwordController.text,
    };

    try {
      var response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(jsonData),
      );

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
        var itemCount = jsonResponse['totalItems'];
        print('Number of items: $itemCount.');

        // Store tokens
        String accessToken = jsonResponse['access_token'];
        String refreshToken = jsonResponse['refresh_token'];
        await storage.write(key: 'access_token', value: accessToken);
        await storage.write(key: 'refresh_token', value: refreshToken);

        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');

        // Clear any previous error message
        setState(() {
          _errorMessage = '';
        });

        // Navigate to the AfterPage
      } else {
        print('Request failed with status: ${response.statusCode}.');
        print('Response data: ${response.body}.');

        // Display error message for incorrect credentials
        setState(() {
          _errorMessage = 'Incorrect username or password';
        });
      }
    } catch (error) {
      print('Error sending request: $error');
    }
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => After()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        // width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('asset/image/login.jpeg'), fit: BoxFit.cover),
        ),
        child: Center(
          child: ListView(
            children: [
              const SizedBox(
                height: 150,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              const Row(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20.0, 10, 0, 0),
                    child: Text(
                      'Hey There Welcome Back!',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 60, 20, 40),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Your Email ',
                  ),
                  autofocus: true,
                  minLines: 2,
                  maxLines: 4,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 40, 20, 40),
                child: TextField(
                  style: TextStyle(fontSize: 20),
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter Your Password',
                  ),
                  autofocus: true,
                  minLines: 2,
                  maxLines: 4,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                child: ElevatedButton(
                  onPressed: onPressed,
                  style: ElevatedButton.styleFrom(
                    side: const BorderSide(color: Colors.black),
                    padding: const EdgeInsets.symmetric(
                        vertical: 13, horizontal: 10),
                    backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 30, color: Colors.black),
                  ),
                ),
              ),
              if (_errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
