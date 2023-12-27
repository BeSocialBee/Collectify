import 'package:collectify/features/card_gallery.dart';
import 'package:collectify/screens/achievements..dart';
import 'package:collectify/screens/card_details.dart';
import 'package:collectify/screens/card_in_auction.dart';
import 'package:collectify/screens/card_info_screen.dart';
import 'package:collectify/screens/card_sell_screen.dart';
import 'package:collectify/screens/lb.dart';
import 'package:collectify/screens/leaderboard.dart';
import 'package:collectify/screens/login.dart';
import 'package:collectify/screens/home.dart';
import 'package:collectify/screens/market.dart';
import 'package:collectify/screens/my_account.dart';
import 'package:collectify/screens/my_collections.dart';
import 'package:collectify/screens/sign_up.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
  // ! runApp(CardGallery());
  // ! runApp(CardDetailsPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //home: LoginScreen(), //! Burayı değiştirebilirsiniz
      //* home: RegistrationScreen()
      //home: Market(),
      //home: LeaderBoardScreen(),
      //home:MainPage(),
      home: Home(),
      routes: {
        // MainPage.id: (context) => MainPage(),
        // Market.id: (context) => Market(),
        // MyCollection.id: (context) => MyCollection(),
        // CardDetailsPage.id: (context) => CardDetailsPage(),
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
        //bottomNavigationBar: myBottomNavigationBar(),
      ),
      // initialRoute: MainPage.id,
      routes: {
        // MainPage.id: (context) => MainPage(),
        // Market.id: (context) => Market(),
        // MyCollection.id: (context) => MyCollection(),
      },
    );
  }
}
