import 'package:collectify/widgets/card.dart';
import 'package:flutter/material.dart';



class CardDetailsPage extends StatelessWidget {
  final CardData card;

  CardDetailsPage(this.card);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kart Detayları"),
      ),
      body: Center(
        child: Column(
          children: [
            Image.asset(
              'images/seb.jpeg', // Kartın resmi
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Text("Kart ${card.index} Özellikleri"), // Kartın özellikleri
          ],
        ),
      ),
    );
  }
}




