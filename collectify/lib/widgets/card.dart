import 'package:flutter/material.dart';

class CardData {
  final int index;

  CardData(this.index);
}

class CardWidget extends StatelessWidget {
  final CardData card;
  final String name;

  CardWidget(this.card, this.name);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: Card(
        child: Column(
          children: <Widget>[
            Image.asset(
              'images/$name', // Örnek bir görsel URL
              height: 100,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text("Kart ${card.index} İsmi"),
              trailing: Icon(Icons.star), // Sağ üst köşede yıldız ikonu
            ),
          ],
        ),
      ),
    );
  }
}
