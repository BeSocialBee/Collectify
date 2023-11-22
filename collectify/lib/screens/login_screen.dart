import 'package:collectify/constants.dart';
import 'package:collectify/main.dart';
import 'package:collectify/screens/main_page.dart';
import 'package:flutter/material.dart';
import '/components/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'createUsername.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = "";
  String? password;
  bool showSpinner = false;
  bool _isLoginForm = true;

  // Function to validate email format
  bool _isEmailValid(String email) {
    // Define a regular expression for a simple email format
    // This example checks for an '@' symbol and '.com'
    RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[a-zA-Z]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void handleLogin() async {
    // Validate the email format
    if (!_isEmailValid(email)) {
      // Display an error message using an alert dialog
      showCustomDialog("Please enter a valid email address.");
      return; // Exit the function early if the email is invalid
    }

    if (password!.length < 6) {
      showCustomDialog("Password must be longer than six characters.");
    } else {
      // Add your authentication logic here
      String apiUrl = 'http://127.0.0.1:5000/flutter_auth';
      // Make a POST request to your backend with email and password
      try {
        var response = await http.post(
          Uri.parse(apiUrl),
          body: {
            'email': email,
            'password': password,
            '_isLoginForm': _isLoginForm.toString(),
          },
        );

        // Check the response status
        if (response.statusCode == 200) {
          // Successful authentication
          // Standard HTTP status code for success
          final responseData = json.decode(response.body);
          final customStatusCode = responseData['status_code'];
          final customMessage = responseData['message'];

          // Succesfful Login
          if (customStatusCode == 1) {
            // if username is null, navigate to username page (if user existed from app after signup page without choosing username)
            String apiUrl2 = 'http://127.0.0.1:5000/flutter_checkUsername';
            var request = http.MultipartRequest('GET', Uri.parse(apiUrl2));
            String hasUsername = "false";

            try {
              var response2 = await http.post(
                Uri.parse(apiUrl2),
                body: {
                  'email': email,
                },
              );

              // Check the response status
              if (response.statusCode == 200) {
                final responseData2 = json.decode(response2.body);
                hasUsername = responseData2['hasUsername'];

                if (hasUsername == "true") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MainPage()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => usernamePage()),
                  );
                }
              }
            } catch (e) {
              // Handle any network or server errors
              print('Error: $e');
            }
          } else if (customStatusCode == 2 || customStatusCode == 3) {
            // CustomCode 2 :  Email or password is incorrect, alert message
            // CustomCode 3 : Email exist in databas, alert message
            showCustomDialog(customMessage);
          }
          // Succesfful Sign Up
          else if (customStatusCode == 4) {
            // Navigate to the UsernamePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => usernamePage()),
            );
          }
        } else {
          // Handle authentication failure
          print('Authentication failed: ${response.body}');
        }
      } catch (e) {
        // Handle any network or server errors
        print('Error: $e');
      }
    }
  }

  // Function to show a custom dialog
  void showCustomDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the alert dialog
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                //* Bu widget ekrandaki logonun flexible olarak büyüyüp küçülmesini sağlar.
                child: Hero(
                  //  ! Geçiş yapılacak görsel için her iki sayfada da Hero Widget olması ve aynı 'tag' değerine sahip olmaları gerekir.
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  // textAlign: TextAlign.center,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password',
                  )),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                buttonTitle: _isLoginForm ? 'Login' : 'Signup',
                colour: Colors.lightBlueAccent,
                buttonCallback: () async {
                  handleLogin();
                  setState(() {
                    showSpinner = true;
                  });
                  //Navigator.pushReplacementNamed(context, MainPage.id);

                  try {
                    // final user = await _auth.signInWithEmailAndPassword(
                    //     email: email!, password: password!);
                    //if (user != null) {
                    //Navigator.pushReplacementNamed(context, MainPage.id);
                    //}

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (error) {}
                },
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    _isLoginForm = !_isLoginForm;
                  });
                },
                child: Text(
                  _isLoginForm
                      ? 'Create an account'
                      : 'Already have an account? Login',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
