import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuctionScreenWidget extends StatefulWidget {
  final String documentID;

  const AuctionScreenWidget({Key? key, required this.documentID}) : super(key: key);

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<AuctionScreenWidget> {
  static late String documentID;
  double highestBid = 10.0;
  late double currentBid = 10.0;

  late StreamController<num> _countdownStreamController;
  late Future<Map<String, dynamic>> auctionCard;

  @override
  void initState() {
    super.initState();
    documentID = widget.documentID;
    _countdownStreamController = StreamController<num>();

    auctionCard = getAuctionCardbyID(documentID);

    print("--------------------------------------------------------------------------------------");
    print(auctionCard.toString());

    _init(auctionCard);
  }

Future<void> _init(auctionCard) async {
  try {
    Map<String, dynamic> card = await auctionCard;

    

    await calculateRemainingTime(card);
  } catch (e) {
    // Handle errors
    print('Error: $e');
  }
}
   

  @override
  void dispose() {
    // Close the stream controller when the widget is disposed
    _countdownStreamController.close();
    super.dispose();
  }

  Future<void> calculateRemainingTime(card) async {
  try {
    String endingTimeString = card['endingTime'];

    highestBid = card['currentBid'].toDouble();
    currentBid = card['currentBid'].toDouble();

    List<String> dateTimeParts = endingTimeString.split('T');
    List<String> dateParts = dateTimeParts[0].split('.');
    List<String> timeParts = dateTimeParts[1].split(':');
    int year = int.parse(dateParts[2]);
    int month = int.parse(dateParts[1]);
    int day = int.parse(dateParts[0]);
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    int second = int.parse(timeParts[2]);
    DateTime endingTime = DateTime(year, month, day, hour, minute, second);
    Duration remainingTime = endingTime.difference(DateTime.now());
    final Timer timer = Timer.periodic(Duration(seconds: 1), (timer) {
      num secondsRemaining = remainingTime.inSeconds;

      // Check if the stream is closed before adding an event
      if (!_countdownStreamController.isClosed) {
        // If the countdown is finished, close the stream
        if (secondsRemaining <= 0.0) {
          _countdownStreamController.close();
          timer.cancel();
          endAuction(documentID);
        } else {
          // Update the UI with the remaining time
          _countdownStreamController.add(secondsRemaining);
          remainingTime = remainingTime - Duration(seconds: 1);
        }
      } else {
        // Stream is closed, cancel the timer
        timer.cancel();
      }
    });
  } catch (e) {
    // Handle errors
    print('Error eeeeeeeee: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: SafeArea(
        top: true,
        child: FutureBuilder(
          future: auctionCard,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No data available.'),
              );
            } else {
              var card = snapshot.data!;

              return Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Image.network(
                      '${card['cardURL']}',
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      '${card['cardTitle']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Current Bid: ${highestBid.toStringAsFixed(1)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      'Description: ${card['cardDescription']}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Text('Closing in: ', style: TextStyle(fontSize: 18)),
                        StreamBuilder<num>(
                          stream: _countdownStreamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              num secondsRemaining = snapshot.data!;
                              num hours = secondsRemaining ~/ 3600;
                              num minutes = (secondsRemaining % 3600) ~/ 60;
                              num seconds = secondsRemaining % 60;

                              return Text(
                                '$hours:${twoDigits(minutes)}:${twoDigits(seconds)}',
                                style: TextStyle(fontSize: 18),
                              );
                            } else {
                              return Container(); // Placeholder widget
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Slider(
                          value: currentBid,
                          min: highestBid,
                          max: card['balance'].toDouble(),
                          onChanged: (value) {
                            setState(() {
                              currentBid = value;
                            });
                          },
                        ),
                        SizedBox(width: 10),
                        Text(
                          '${currentBid.toStringAsFixed(1)}',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: ElevatedButton(
                      onPressed: () {
                        bidAuction(card['documentID'],currentBid);
                      },
                      child: Text('Place Bid'),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  String twoDigits(num n) {
    return n >= 10 ? "$n" : "0$n";
  }
}

Future<Map<String, dynamic>> getAuctionCardbyID(documentID) async {
  try {

    print("docum");

    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getAuctionCardById';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final Map<String, dynamic> jsonArray = jsonResponse['cardData'] ?? {};
      return jsonArray;
    } else {
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    print('Error loading profile: $e');
    throw Exception('Failed to get card data');
  }
}


Future<void> bidAuction(documentID,currentBid) async {
  try { 
    //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
    var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";
    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/bidAuction';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
        'userID': userID,
        'currentBid': currentBid.toString(),
      },
    );

    if (response.statusCode == 200) {
      print('Bid is successful');
      

    } else {
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    print('Error loading profile: $e');
    throw Exception('Failed to get card data');
  }
}


Future<void> endAuction(documentID) async {
  try { 
    //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
    var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";
    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/endAuction';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'documentID': documentID,
        'userID': userID,
      },
    );

    if (response.statusCode == 200) {
      print('Auction is finished');
    } else {
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    print('Error loading profile: $e');
    throw Exception('Failed to get card data');
  }
}