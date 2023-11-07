import 'package:collectify/screens/main_page.dart';
import 'package:collectify/screens/market.dart';
import 'package:collectify/screens/my_account.dart';
import 'package:collectify/screens/my_collections.dart';
import 'package:flutter/material.dart';

class myBottomNavigationBar extends StatefulWidget {
  @override
  _myBottomNavigationBarState createState() => _myBottomNavigationBarState();
}

class _myBottomNavigationBarState extends State<myBottomNavigationBar> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    switch (index) {
      case 0:
        Navigator.pushNamed(context, MainPage.id);
        break;
      case 1:
        Navigator.pushNamed(context, MyCollection.id);
        break;
      case 2:
        Navigator.pushNamed(context, Market.id);
        break;
      case 3:
        Navigator.pushNamed(context, MyAccount.id);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.brown,
            ),
            label: 'Main'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.card_membership,
              color: Colors.brown,
            ),
            label: 'Collections'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.shop,
              color: Colors.brown,
            ),
            label: 'Market'),
        BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.brown,
            ),
            label: 'Account'),
      ],
      unselectedLabelStyle:
          const TextStyle(color: Colors.red), // Seçili olmayan yazıların rengi
      selectedLabelStyle: const TextStyle(color: Colors.blue),
      backgroundColor: Colors.green,
      currentIndex: _selectedIndex,
      onTap: _onItemTapped,
    );
  }
}
