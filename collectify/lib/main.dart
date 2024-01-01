import 'package:collectify/features/card_gallery.dart';
import 'package:collectify/screens/achievements..dart';
import 'package:collectify/screens/card_details.dart';
import 'package:collectify/screens/card_in_auction.dart';
import 'package:collectify/screens/card_info_screen.dart';
import 'package:collectify/screens/card_sell_screen.dart';
import 'package:collectify/screens/create_profile.dart';
import 'package:collectify/screens/lb.dart';
import 'package:collectify/screens/leaderboard.dart';
import 'package:collectify/screens/login.dart';
import 'package:collectify/screens/home.dart';
import 'package:collectify/screens/market.dart';
import 'package:collectify/screens/my_account.dart';
import 'package:collectify/screens/my_collections.dart';
import 'package:collectify/screens/search.dart';
import 'package:collectify/screens/sign_up.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icon.dart';
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
        return LoginScreen();
      case 1:
        return Market();
      case 2:
        return Search();
      case 3:
        return LeaderBoardScreen1();
      case 4:
        return MyCollection();
      // case 4:
      //   return MyAccount();
      default:
        return Center(
          child: Text("Welcome to ${_currentIndex} page"),
        );
    }
  }

  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        "/Login":(context) => LoginScreen(),
        "/Signup":(context) => SignUpScreen(),
        "/MyCollection":(context) => MyCollection(),
        "/Market":(context) => Market(),
        "/Leaderboard":(context) => LeaderBoardScreen1(),
        "/MyAccount":(context) => MyAccount(),

      },
      debugShowCheckedModeBanner: false,
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
              icon: LineIcon.shoppingCart(),
              title: Text('Market'),
              activeColor: Colors.purpleAccent,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.search),
              title: Text(
                'Search',
              ),
              activeColor: Colors.pink,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.leaderboard),
              title: Text('Ranks'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: Icon(Icons.card_travel),
              title: Text('My Cards'),
              activeColor: Colors.blue,
              textAlign: TextAlign.center,)
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
