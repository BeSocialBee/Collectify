import 'package:collectify/constants.dart';
import 'package:collectify/screens/main_page.dart';
import 'package:flutter/material.dart';
import '/components/rounded_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool showSpinner = false;


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
                buttonTitle: 'Log in',
                colour: Colors.lightBlueAccent,
                buttonCallback: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    // final user = await _auth.signInWithEmailAndPassword(
                    //     email: email!, password: password!);
                    //if (user != null) {
                      Navigator.pushReplacementNamed(context, MainPage.id);
                    //}
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (error) {}
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
