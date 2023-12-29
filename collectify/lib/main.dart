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
import 'package:fancy_bottom_navigation_plus/fancy_bottom_navigation_plus.dart';
import 'package:collectify/screens/market.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0;

  
  Widget? _getpage(int _currentIndex) {
    switch (_currentIndex) {
      case 0:
        return Home();
      case 1:
        return Market();
      case 2:
        return 
        Center(
          child: Text("Welcome to ${_currentIndex} page"),
        );
      case 3:
        return ProfilePageWidget();
      default:
        return Center(
          child: Text("Welcome to ${_currentIndex} page"),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: _getpage(_currentIndex),
        bottomNavigationBar: BottomNavyBar(
          selectedIndex: _currentIndex,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: (index) => setState(() => _currentIndex = index),
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: Icon(Icons.apps),
              title: Text('Home'),
              activeColor: Colors.red,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.people),
              title: Text('Users'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.message),
              title: Text(
                'Messages test for mes teset test test ',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.settings),
              title: Text('Settings'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
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
