import 'package:collectify/flutter_flow/flutter_flow_icon_button.dart';
import 'package:collectify/screens/card_in_quickBuy.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProductDetailsWidget extends StatefulWidget {
  const ProductDetailsWidget({Key? key}) : super(key: key);

  @override
  _ProductDetailsWidgetState createState() => _ProductDetailsWidgetState();
}

class _ProductDetailsWidgetState extends State<ProductDetailsWidget> {
  double highestBid = 10;
  //double remainingTime;
  int hours = 1;
  int minutes = 0;
  int seconds = 0;
  late Timer _timer;
  late double currentBid = highestBid;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void makeABid() {
    highestBid += 10.0;
  }

  void updateHighestBid() {
    //  database'den gelen değer = highestBid
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSecond,
      (timer) {
        setState(() {
          if (hours == 0 && minutes == 0 && seconds == 0) {
            _timer.cancel();
          } else if (minutes == 0 && seconds == 0) {
            hours--;
            minutes = 59;
            seconds = 59;
          } else if (seconds == 0) {
            minutes--;
            seconds = 59;
          } else {
            seconds--;
          }
        });
      },
    );
  }

  String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: FlutterFlowIconButton(
            borderColor: Colors.transparent,
            borderRadius: 30,
            borderWidth: 1,
            buttonSize: 60,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Color(0xFF14181B),
              size: 30,
            ),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
          backgroundColor: Color(0xFF61ADFE),
          automaticallyImplyLeading: false,
          title: Text(
            'Make A Bid',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Outfit',
              color: Colors.white,
              fontSize: 22,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 2,
        ),
        body: SafeArea(
          top: true,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: 375,
                    height: 375,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: FlipCard(
                      fill: Fill.fillBack,
                      direction: FlipDirection.HORIZONTAL,
                      speed: 400,
                      front: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            'https://picsum.photos/seed/64/600',
                            width: 300,
                            height: 200,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      back: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.yellow,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                              child: Text(
                                'Card Name',
                                style: TextStyle(
                                  fontFamily: 'Outfit',
                                  fontSize: 30,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                              child: Text(
                                'Bu kısımda kart açıklaması yer alacaktır.',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: 370,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFF7D4DEF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Current Bid: ',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        ),
                        Text(
                          '${highestBid.toStringAsFixed(1)}',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 26,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: Material(
                  color: Colors.transparent,
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                  ),
                  child: Container(
                    width: 370,
                    height: 55,
                    decoration: BoxDecoration(
                      color: Color(0xFF7D4DEF),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Closing in:',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                        Text(
                          '${twoDigits(hours)}:${twoDigits(minutes)}:${twoDigits(seconds)}',
                          style: TextStyle(
                            fontFamily: 'Outfit',
                            color: Colors.white,
                            fontSize: 30,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Slider(
                      value: currentBid,
                      min: highestBid,
                      max: highestBid + 1000,
                      onChanged: (value) {
                        setState(() {
                          currentBid = value;
                        });
                      },
                    ),
                    SizedBox(height: 10),
                    Text(
                      '${currentBid.toStringAsFixed(1)}',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 10, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (currentBid < highestBid) {
                      print("uyarı");
                    } else {
                      highestBid = currentBid;
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7D4DEF),
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
        ),
      ),
    );
  }
}
