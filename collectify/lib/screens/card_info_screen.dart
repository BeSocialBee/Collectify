import 'package:collectify/screens/card_sell_screen.dart';
import 'package:flutter/material.dart';

class CardDetailsPage extends StatelessWidget {
  static String id = 'card_details';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Card Details"),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        //bottom navigation bar on scaffold
        color: Colors.redAccent,
        shape: CircularNotchedRectangle(), //shape of notch
        notchMargin:
            5, //notche margin between floating button and bottom appbar
        child: Row(
          //children inside bottom appbar
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(
                  Icons.shop,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: IconButton(
                icon: Icon(
                  Icons.card_membership,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: IconButton(
                icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
                ),
                onPressed: () {},
              ),
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              flex: 6,
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
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black
                                .withOpacity(0.2), // Gölge rengi ve şeffaflığı
                            spreadRadius: 2, // Gölgenin yayılma miktarı
                            blurRadius: 5, // Gölgenin bulanıklık miktarı
                            offset: Offset(0, 3), // Gölge offset'i (x, y)
                          ),
                        ],
                      ),
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
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Card(
                  color: Colors.purple[100],
                  elevation: 8,
                  child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      child: Text(
                        'Aston Martin AMR22',
                        style: TextStyle(fontSize: 20),
                      ))),
            ),
            // Expanded(
            //   flex: 1,
            //   child: Card(
            //     color: Colors.purple[100],
            //     elevation: 8,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //       children: [
            //         Icon(Icons.add),
            //         Icon(Icons.home),
            //         Icon(Icons.sports_football),
            //         Icon(Icons.sports_basketball),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
