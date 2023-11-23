import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:collectify/widgets/card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Market extends StatefulWidget {
  static String id = 'market_screen';
  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  late Future<List<dynamic>> auctionImageUrls;
  late Future<List<dynamic>> fixedPriceImageUrls;

  final List<bool> _selections = [
    true,
    false
  ]; // İlk seçenek açık arttırma, ikinci seçenek sabit fiyat

  @override
  void initState() {
    super.initState();
    // Fetch image URLs when the widget is initialized
    if (_selections[0]) {
      auctionImageUrls = fetchAuctionImageUrls();
    }
  }

  Future<List<dynamic>> fetchAuctionImageUrls() async {
    String apiUrlAuction = 'http://127.0.0.1:5000/flutter_auctionImageURLS';

    final auctionResponse = await http.get(Uri.parse(apiUrlAuction));

    if (auctionResponse.statusCode == 200) {
      List<dynamic> auctionImageUrls = json.decode(auctionResponse.body);
      return auctionImageUrls;
    } else {
      // Handle error cases
      throw Exception('Failed to fetch image URL');
    }
  }

  Future<List<dynamic>> fetchFixedImageUrls() async {
    String apiUrlFixedPrice =
        'http://127.0.0.1:5000/flutter_fixedPriceImageURLS';

    final fixedPriceResponse = await http.get(Uri.parse(apiUrlFixedPrice));

    if (fixedPriceResponse.statusCode == 200) {
      List<dynamic> fixedPriceImageUrls = json.decode(fixedPriceResponse.body);
      return fixedPriceImageUrls;
    } else {
      // Handle error cases
      throw Exception('Failed to fetch image URLs');
    }
  }

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
                  if (_selections[0]) {
                    auctionImageUrls = fetchAuctionImageUrls();
                  } else {
                    fixedPriceImageUrls = fetchFixedImageUrls();
                  }
                });
              },
            ),
          ),
          if (_selections[0])
            Expanded(
              flex: 8,
              child: AuctionCardsList(auctionImageUrls),
            )
          else
            Expanded(
              flex: 8,
              child: FixedPriceCardsList(fixedPriceImageUrls),
            )
        ],
      ),
    );
  }
}

class AuctionCardsList extends StatelessWidget {
  final Future<List<dynamic>> auctionImageUrls;
  const AuctionCardsList(this.auctionImageUrls);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: auctionImageUrls,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          List<dynamic> data = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                data[index],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ); //CardWidget(CardData(index), data[index]);
            },
          );
        }
      },
    );
  }
}

class FixedPriceCardsList extends StatelessWidget {
  final Future<List<dynamic>> fixedPriceImageUrls;
  const FixedPriceCardsList(this.fixedPriceImageUrls);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: fixedPriceImageUrls,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return Text('No data available');
        } else {
          List<dynamic> data = snapshot.data!;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              return Image.network(
                data[index],
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ); //
              //CardWidget(CardData(index), data[index]);
            },
          );
        }
      },
    );
  }
}
