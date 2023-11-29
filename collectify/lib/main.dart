import 'package:collectify/features/card_gallery.dart';
import 'package:collectify/screens/card_details.dart';
import 'package:collectify/screens/card_info_screen.dart';
import 'package:collectify/screens/lb.dart';
import 'package:collectify/screens/leaderboard.dart';
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
  // ! runApp(CardGallery());
  // ! runApp(CardDetailsPage());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
<<<<<<< HEAD
      //home: LoginScreen(), //! Burayı değiştirebilirsiniz
=======
      home: MainPage(), //! Burayı değiştirebilirsiniz
>>>>>>> 93b90c67e46c1ff83699dcf20534ac2c1e8a31d7
      //* home: RegistrationScreen()
      home: LeaderBoardScreen1(),
      //home: LeaderBoardScreen(),
      //home:MainPage(),
      routes: {
        MyAccount.id: (context) => MyAccount(),
        MainPage.id: (context) => MainPage(),
        Market.id: (context) => Market(),
        MyCollection.id: (context) => MyCollection(),
        CardDetailsPage.id: (context) => CardDetailsPage(),
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
