import 'package:flutter/material.dart';

class BiddingScreen extends StatefulWidget {
  @override
  State<BiddingScreen> createState() => _BiddingScreenState();
}

class _BiddingScreenState extends State<BiddingScreen> {
  double _auctionPrice = 50.0;


  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color(0xFF7D4DEF),
        ),
        padding: EdgeInsets.all(16.0),
      ),
      Container(
        width: double.maxFinite,
        height: 200,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Amount of Bid',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                color: Colors.lightBlueAccent,
              ),
            ),
            SizedBox(height: 20),
            Slider(
              value: _auctionPrice,
              min: 0,
              max: 100,
              onChanged: (value) {
                setState(() {
                  _auctionPrice = value;
                });
              },
            ),
            SizedBox(height: 10),
            Text(
              '${_auctionPrice.toStringAsFixed(1)}',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 30),
            SizedBox(
              height: 20,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightBlueAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  elevation: 3,
                ),
                child: Text('Bid'),
              ),
            ),
          ],
        ),
      )
    ]);
  }
}
