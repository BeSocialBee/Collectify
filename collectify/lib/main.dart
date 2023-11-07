import 'package:collectify/screens/main_page.dart';
import 'package:collectify/screens/market.dart';
import 'package:collectify/screens/my_account.dart';
import 'package:collectify/screens/my_collections.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
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
