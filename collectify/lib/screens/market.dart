import 'package:collectify/widgets/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:collectify/widgets/card.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:collectify/constants.dart';

class Market extends StatefulWidget {
  static String id = 'market_screen';
  @override
  State<Market> createState() => _MarketState();
}

class _MarketState extends State<Market> {
  late Future<Map<String, dynamic>> auctionData;
  late Future<Map<String, dynamic>> fixedPriceData;

  final List<bool> _selections = [
    true,
    false
  ]; // İlk seçenek açık arttırma, ikinci seçenek sabit fiyat

  @override
  void initState() {
    super.initState();
    // Fetch image URLs when the widget is initialized
    if (_selections[0]) {
      auctionData = fetchAuctionData();
    }
  }

  Future<Map<String, dynamic>> fetchAuctionData() async {
    String apiUrlAuction = 'http://127.0.0.1:5000/flutter_auctionData';

    final auctionResponse = await http.get(Uri.parse(apiUrlAuction));

    if (auctionResponse.statusCode == 200) {
      Map<String, dynamic> auctionData = json.decode(auctionResponse.body);
      return auctionData;
    } else {
      // Handle error cases
      throw Exception('Failed to fetch image URL');
    }
  }

  Future<Map<String, dynamic>> fetchFixedData() async {
    String apiUrlFixedPrice = 'http://127.0.0.1:5000/flutter_fixedPriceData';

    final fixedPriceResponse = await http.get(Uri.parse(apiUrlFixedPrice));

    if (fixedPriceResponse.statusCode == 200) {
      Map<String, dynamic> fixedPriceData =
          json.decode(fixedPriceResponse.body);
      return fixedPriceData;
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
              constraints: const BoxConstraints(
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
                const Text("Açık Arttırma"),
                const Text("Sabit Fiyat"),
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
                    auctionData = fetchAuctionData();
                  } else {
                    fixedPriceData = fetchFixedData();
                  }
                });
              },
            ),
          ),
          if (_selections[0])
            Expanded(
              flex: 8,
              child: AuctionCardsList(auctionData),
            )
          else
            Expanded(
              flex: 8,
              child: FixedPriceCardsList(fixedPriceData),
            )
        ],
      ),
    );
  }
}

class AuctionCardsList extends StatelessWidget {
  final Future<Map<String, dynamic>> auctionData;
  const AuctionCardsList(this.auctionData);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: auctionData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        } else {
          Map<String, dynamic> data = snapshot.data!;
          List<dynamic> urls = data['auction_image_urls'] ?? [];
          List<dynamic> prices = data['price'] ?? [];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: urls.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Show card information when card is tapped
                  _showAuctionInfo(context, urls[index]);
                },
                child: Column(
                  children: [
                    Image.network(
                      urls[index],
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                    Text('Price: ${prices[index]}'),
                  ],
                ),
              ); //CardWidget(CardData(index), data[index]);
            },
          );
        }
      },
    );
  }
}

class FixedPriceCardsList extends StatelessWidget {
  final Future<Map<String, dynamic>> fixedPriceData;
  const FixedPriceCardsList(this.fixedPriceData);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: fixedPriceData,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Loading indicator while waiting
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData) {
          return const Text('No data available');
        } else {
          Map<String, dynamic> data = snapshot.data!;
          List<dynamic> urls = data['fixed_price_image_urls'] ?? [];
          List<dynamic> prices = data['price'] ?? [];

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 8.0,
              crossAxisSpacing: 8.0,
            ),
            itemCount: urls.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Show card information when card is tapped
                  _showFixedPriceInfo(context, urls[index]);
                },
                child: Column(
                  children: [
                    Image.network(
                      urls[index],
                      height: 200,
                      width: 200,
                      fit: BoxFit.fill,
                    ),
                    Text('Price: ${prices[index]}'),
                  ],
                ),
              ); //CardWidget(CardData(index), data[index]);
            },
          );
        }
      },
    );
  }
}

void _showAuctionInfo(BuildContext context, String imageUrl) async {
  double bidAmount = 0.0;
  print(imageUrl);

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<Map<String, dynamic>>(
        future: fetchCardData(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to fetch card data: ${snapshot.error}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return AlertDialog(
              title: const Text('No Data'),
              content: const Text('No card data available.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          } else {
            // Parse Card Information
            Map<String, dynamic> cardData = snapshot.data!;

            // Display Card Information
            return AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cardData['collectionName']} : ${cardData['title']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    imageUrl,
                    height: 250,
                    width: 250,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text('${cardData['description']}'),
                  const SizedBox(height: 10),
                  Text('Price: ${cardData['price']}'),
                  Text('Rarity: ${cardData['rarity']}'),
                  const SizedBox(height: 10),
                  TextField(
                      onChanged: (value) {
                        bidAmount = double.parse(value);
                      },
                      decoration: kTextFieldDecoration.copyWith(
                        hintText: 'Enter your bid',
                      )),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your purchase logic here
                    _purchaseAuctionCard(context, imageUrl, bidAmount);
                  },
                  child: const Text('Continue'),
                ),
              ],
            );
          }
        },
      );
    },
  );
}

Future<Map<String, dynamic>> fetchCardData(String imageUrl) async {
  // Implement your logic to fetch card data based on the imageUrl
  String url = 'http://127.0.0.1:5000/flutter_showauctioncardinfo';

  final response = await http.post(
    Uri.parse(url),
    body: {'imageUrl': imageUrl},
  );

  if (response.statusCode == 200) {
    return json.decode(response.body);
  } else {
    // Handle error cases
    throw Exception('Failed to fetch card data!');
  }
}

void _showFixedPriceInfo(BuildContext context, String imageUrl) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FutureBuilder<Map<String, dynamic>>(
        // Replace this with your asynchronous operation to get card data
        future: fetchCardData(imageUrl),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to fetch card data: ${snapshot.error}'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          } else if (!snapshot.hasData) {
            return AlertDialog(
              title: const Text('No Data'),
              content: const Text('No card data available.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
              ],
            );
          } else {
            // Parse Card Information
            Map<String, dynamic> cardData = snapshot.data!;

            // Display Card Information
            return AlertDialog(
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${cardData['collectionName']} : ${cardData['title']}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    imageUrl,
                    height: 250,
                    width: 250,
                    fit: BoxFit.fill,
                  ),
                  const SizedBox(height: 10),
                  Text('${cardData['description']}'),
                  const SizedBox(height: 10),
                  Text('Price: ${cardData['price']}'),
                  Text('Rarity: ${cardData['rarity']}'),
                  // Add more fields as needed
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Close'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Add your purchase logic here
                    _purchaseFixedPriceCard(context, imageUrl);
                  },
                  child: const Text('Purchase'),
                ),
              ],
            );
          }
        },
      );
    },
  );
}

// Auction Logic Yap
void _purchaseAuctionCard(
    BuildContext context, String imageUrl, double _bidAmount) async {
  // Add your purchase logic here
  // For example, you can show a confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm'),
        content: Text(
            'You are about to place a bid of \$${_bidAmount.toStringAsFixed(2)}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            // Add your purchase confirmation logic here
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}

// Auction Logic Yap
void _purchaseFixedPriceCard(BuildContext context, String imageUrl) async {
  // Add your purchase logic here
  // For example, you can show a confirmation dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Purchase'),
        content: const Text('Do you want to purchase this card?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('No'),
          ),
          TextButton(
            // Add your purchase confirmation logic here
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Yes'),
          ),
        ],
      );
    },
  );
}
