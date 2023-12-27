import 'package:collectify/screens/card_info_screen.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:collectify/widgets/card.dart';
import 'package:flutter/material.dart';

class MyCollection extends StatefulWidget {
  static String id = 'my_collection_screen';
  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {
  final List<CardData> cards = List.generate(20, (index) => CardData(index));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: myBottomNavigationBar(),
      appBar: AppBar(
        title: Text("My Cards"),
      ),
      body: Padding(
        padding: const EdgeInsets.only(right: 12.0, left: 12, top: 20),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // İki kart yan yana olacak
            mainAxisSpacing: 15.0, // Dikey boşluk
            crossAxisSpacing: 12.0, // Yatay boşluk
          ),
          itemCount: 20, // Listelenecek kart sayısı
          itemBuilder: (context, index) {
            // return GestureDetector(
            //   onTap: () {
            //     _navigateToCardDetails(context, cards[index]);
            //   },
              return CardWidget(cards[index], 'seb1.jpeg');
            //);
          },
        ),
      ),
    );
  }

  void _navigateToCardDetails(BuildContext context, CardData card) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return CardDetailsPage();
        },
      ),
    );
  }
}
