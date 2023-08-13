//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
//import 'login.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  State<GetStarted> createState() {
    return _SignupScreenState();
  }
}

class _SignupScreenState extends State<GetStarted> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final storage = FlutterSecureStorage();

  //String _errorMessage = '';

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

        // Navigator.push(
        //   context,
        // );
      }
    } catch (error) {
      print('Error sending request: $error');
    }
  }

  Future<void> _signUp() async {
    final String apiUrl =
        "http://10.50.6.191:5000/signup"; // Update with your actual URL

    final Map<String, dynamic> signupData = {
      "username": _usernameController.text,
      "password": _passwordController.text,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode(signupData),
    );

    print("Signup Response:");
    print("Status Code: ${response.statusCode}");
    print("Response JSON: ${response.body}");
    onPressed();
  }

  @override
  Widget build(context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
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
              const Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  'Signup',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    //letterSpacing: 3
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(14, 0, 0, 0),
                child: Text(
                  'Hello,Enter your email to continue',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              Container(
                child: Column(children: [
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Email',
                      ),
                      autofocus: true,
                      minLines: 2,
                      maxLines: 4,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: TextField(
                      style: TextStyle(fontSize: 20),
                      controller: _passwordController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Passwordl',
                        hintText: 'Password',
                      ),
                      autofocus: false,
                      minLines: 2,
                      maxLines: 4,
                    ),
                  ),
                ]),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(40, 5, 40, 0),
                child: ElevatedButton(
                    onPressed: _signUp,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      side: const BorderSide(color: Colors.black),
                      padding: const EdgeInsets.symmetric(
                          vertical: 13, horizontal: 10),
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Signup',
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
