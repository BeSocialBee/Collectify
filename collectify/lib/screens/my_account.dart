import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class MyAccount extends StatefulWidget {
  static String id = 'my_account_screen';

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Collectify'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          UserInfoCard(
            title: "Kullanıcı Adı",
            value: "Seyfullah",
          ),
          UserInfoCard(
            title: "E-posta",
            value: "sahin@gmail.com",
          ),
          UserInfoCard(
            title: "Kayıt Tarihi",
            value: "21/08/2023", // Burayı gerçek bir tarih ile değiştirin
          ),
        ],
      ),
      backgroundColor: Colors.grey,
      bottomNavigationBar: myBottomNavigationBar(),
    );
  }
}

class UserInfoCard extends StatelessWidget {
  final String title;
  final String value;

  UserInfoCard({
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Kenarları yuvarlatma
      ),
      elevation: 4, // Gölge efekti
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}