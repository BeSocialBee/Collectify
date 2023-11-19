import 'package:collectify/screens/login_screen.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyAccount extends StatefulWidget {
  static String id = 'my_account_screen';

  @override
  State<MyAccount> createState() => _MyAccountState();
}

class _MyAccountState extends State<MyAccount> {
  late Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    // Fetch user data when the widget is initialized
    userData = fetchUserData();
  }

  Future<Map<String, dynamic>> fetchUserData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:5000/userprofile'));

    if (response.statusCode == 200) {
      Map<String, dynamic> userData = json.decode(response.body);

      return userData;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception or handle the error as needed.
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: const Text('Collectify'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No user data available'));
          } else {
            Map<String, dynamic> userData = snapshot.data!; // Access data here

            return ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                Image.network(
                  userData['fileURL'][0],
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                UserInfoCard(
                  title: "Username",
                  value: userData['username'][0],
                ),
                UserInfoCard(
                  title: "E-mail",
                  value: userData['email'],
                ),
                UserInfoCard(
                  title: "Registration Date",
                  value: userData['registration_date']
                      [0], // Burayı gerçek bir tarih ile değiştirin
                ),
                const SizedBox(
                    height:
                        16), // Add some spacing between the user info and the button
                ElevatedButton(
                  onPressed: () {
                    // You can use Navigator.pop(context) to close the current screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: const Text('Exit'),
                ),
              ],
            );
          }
        },
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
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(value),
      ),
    );
  }
}
