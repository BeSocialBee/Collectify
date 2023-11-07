import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:collectify/widgets/card.dart';

class Market extends StatefulWidget {
  static String id = 'market_screen';
  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  List<bool> _selections = [
    true,
    false
  ]; // İlk seçenek açık arttırma, ikinci seçenek sabit fiyat

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow,
        title: Text('Collectify'),
      ),
      backgroundColor: Colors.red,
      bottomNavigationBar: myBottomNavigationBar(),
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: ToggleButtons(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              constraints: BoxConstraints(
                minWidth: 160,
                minHeight: 50,
              ),
              selectedColor: Colors.pink,
              disabledColor: Colors.white,
              fillColor: Colors.green,
              highlightColor: Colors.white,
              focusColor: Colors.white,
              splashColor: Colors.white,
              hoverColor: Colors.white,
              children: [
                Text("Açık Arttırma"),
                Text("Sabit Fiyat"),
              ],
              isSelected: _selections,
              onPressed: (int index) {
                setState(() {
                  for (int buttonIndex = 0;
                      buttonIndex < _selections.length;
                      buttonIndex++) {
                    if (buttonIndex == index) {
                      _selections[buttonIndex] = true;
                    } else {
                      _selections[buttonIndex] = false;
                    }
                  }
                });
              },
            ),
          ),
          if (_selections[0])
            Expanded(child: AuctionCardsList(),flex: 8,)
          else
            Expanded(child: FixedPriceCardsList(), flex: 8,)
        ],
      ),
    );
  }
}

class AuctionCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Açık arttırmada satılan kartları listeleme işlemi burada yapılır.
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // İki kart yan yana olacak
        mainAxisSpacing: 8.0, // Dikey boşluk
        crossAxisSpacing: 8.0, // Yatay boşluk
      ),
      itemCount: 20, // Listelenecek kart sayısı
      itemBuilder: (BuildContext context, int index) {
        return CardWidget(CardData(index), 'seb.jpeg'); // Her kartı CardWidget ile oluşturun
      },
    );
  }
}

class FixedPriceCardsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Sabit fiyatlı kartları listeleme işlemi burada yapılır.
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // İki kart yan yana olacak
        mainAxisSpacing: 8.0, // Dikey boşluk
        crossAxisSpacing: 8.0, // Yatay boşluk
      ),
      itemCount: 20, // Listelenecek kart sayısı
      itemBuilder: (BuildContext context, int index) {
        return CardWidget(CardData(index), 'arj.jpeg'); // Her kartı CardWidget ile oluşturun
      },
    );
  }
}
