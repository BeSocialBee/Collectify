import 'package:collectify/screens/card_info_screen.dart';
import 'package:collectify/screens/login_screen.dart';
import 'package:collectify/screens/main_page.dart';
import 'package:collectify/screens/market.dart';
import 'package:collectify/screens/my_account.dart';
import 'package:collectify/screens/my_collections.dart';
import 'package:collectify/screens/registration_screen.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationScreen(), //! Burayı değiştirebilirsiniz
      //* home: RegistrationScreen() 
      //* home: CardDetailsPage()
      //* home: MainPage()
      routes: {
        MyAccount.id: (context) => MyAccount(),
        MainPage.id: (context) => MainPage(),
        Market.id: (context) => Market(),
        MyCollection.id: (context) => MyCollection(),
      },
    );
  }
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        bottomNavigationBar: myBottomNavigationBar(),
      ),
      initialRoute: MainPage.id,
      routes: {
        MyAccount.id: (context) => MyAccount(),
        MainPage.id: (context) => MainPage(),
        Market.id: (context) => Market(),
        MyCollection.id: (context) => MyCollection(),
      },
    );
  }
}
