import 'package:collectify/screens/card_sell_screen.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Kart Detayları"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (context) => CardSellPage(),
            );
            //* showModalBottomSheet(context: context, builder: buildBottomSheet());
          },
          isExtended: true,
          backgroundColor: Colors.lightBlueAccent,
          child: Text('Sell'),
        ),
        body: Center(
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Card(
                  color: Colors.purple,
                  elevation: 2,
                  shadowColor: Colors.amberAccent,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.asset(
                              'images/seb.jpeg', // Kartın resmi
                              height: 400,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("Kartın ismi"),
                          Text("Kart Özellikleri"),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Card(
                  elevation: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.add),
                      Icon(Icons.home),
                      Icon(Icons.sports_football),
                      Icon(Icons.sports_basketball),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
