import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuctionScreenWidget extends StatefulWidget {
  final String documentID;

  const AuctionScreenWidget({Key? key, required this.documentID})
      : super(key: key);

  @override
  _AuctionScreenWidgetState createState() => _AuctionScreenWidgetState();
}

class _AuctionScreenWidgetState extends State<AuctionScreenWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static late String documentID;
  double highestBid = 10.0;
  late double currentBid = 10.0;

  late StreamController<num> _countdownStreamController;
  late Future<Map<String, dynamic>> auctionCard;

  void initState() {
    super.initState();
    documentID = widget.documentID;
    _countdownStreamController = StreamController<num>();

    auctionCard = getAuctionCardbyID(documentID);

    print(
        "--------------------------------------------------------------------------------------");
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
    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }

    return GestureDetector(
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        appBar: AppBar(
          backgroundColor: Color(0xFF61ADFE),
          automaticallyImplyLeading: false,
          title: Text(
            'Make A Bid',
            textAlign: TextAlign.center,
            style: FlutterFlowTheme.of(context).headlineMedium.override(
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
                          height: 493,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10),
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(12),
                                bottomRight: Radius.circular(12),
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12),
                              ),
                            ),
                            child: Container(
                              width: 100,
                              height: 502,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).tertiary,
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(12),
                                  bottomRight: Radius.circular(12),
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                border: Border.all(
                                  color: FlutterFlowTheme.of(context).tertiary,
                                  width: 12,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Text(
                                    'Card Name',
                                    style: FlutterFlowTheme.of(context)
                                        .bodyMedium
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          fontSize: 36,
                                        ),
                                  ),
                                  FlipCard(
                                    fill: Fill.fillBack,
                                    direction: FlipDirection.HORIZONTAL,
                                    speed: 400,
                                    front: Stack(
                                      children: [
                                        Padding(
                                          padding:
                                              EdgeInsetsDirectional.fromSTEB(
                                                  0, 10, 0, 10),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: Image.network(
                                              'https://picsum.photos/seed/90/600',
                                              width: 330,
                                              height: 330,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    back: Container(
                                      width: 330,
                                      height: 330,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .tertiary,
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
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 10, 0, 0),
                                            child: Text(
                                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur consequat nulla ac magna pharetra fringilla. Vestibulum venenatis at massa vel blandit. Aliquam in elementum felis. Donec est ligula, hendrerit a est at, vulputate posuere elit. Morbi varius consequat mollis. Aenean venenatis hendrerit diam. Suspendisse suscipit vel leo a vestibulum. Integer venenatis sit amet ex at tempor. Quisque orci dui, vestibulum et mollis in, sodales quis est. Praesent rhoncus mattis ligula vel pretium. Nunc laoreet erat ut volutpat venenatis. Phasellus massa nibh, feugiat nec metus ut, rutrum tincidunt ex. Integer suscipit lacus sed auctor gravida.\n',
                                              style:
                                                  FlutterFlowTheme.of(context)
                                                      .bodyMedium
                                                      .override(
                                                        fontFamily: 'Outfit',
                                                        fontSize: 18,
                                                      ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 0, 6, 0),
                                        child: Icon(
                                          Icons.star,
                                          color: FlutterFlowTheme.of(context)
                                              .primaryBtnText,
                                          size: 24,
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            6, 0, 0, 0),
                                        child: Text(
                                          'Common',
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                fontFamily: 'Outfit',
                                                fontSize: 24,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ListTile(
                                    title: Text(
                                      'Collection Name: ',
                                      style: FlutterFlowTheme.of(context)
                                          .titleLarge
                                          .override(
                                            fontFamily: 'Outfit',
                                            color: FlutterFlowTheme.of(context)
                                                .primaryBtnText,
                                          ),
                                    ),
                                    trailing: Icon(
                                      Icons.arrow_forward_ios,
                                      color: FlutterFlowTheme.of(context)
                                          .primaryBtnText,
                                      size: 20,
                                    ),
                                    tileColor: FlutterFlowTheme.of(context)
                                        .secondaryBackground,
                                    dense: false,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: 345,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
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
                                'Auction Ends in:',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      fontSize: 24,
                                    ),
                              ),
                              Text(
                                '06:17',
                                style: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      fontSize: 24,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 0),
                      child: Material(
                        color: Colors.transparent,
                        elevation: 15,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                          ),
                        ),
                        child: Container(
                          width: 345,
                          height: 60,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context).tertiary,
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
                              Expanded(
                                child: FFButtonWidget(
                                  onPressed: () async {
                                    await showModalBottomSheet(
                                      isScrollControlled: true,
                                      backgroundColor: Colors.transparent,
                                      enableDrag: false,
                                      context: context,
                                      builder: (context) {
                                        return GestureDetector(
                                          child: Padding(
                                            padding: MediaQuery.viewInsetsOf(
                                                context),
                                            child: Container(
                                              height: 250,
                                              child: SellInAuctionWidget(),
                                            ),
                                          ),
                                        );
                                      },
                                    ).then((value) => safeSetState(() {}));
                                  },
                                  text: 'Button',
                                  options: FFButtonOptions(
                                    width: 150,
                                    height: double.infinity,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 0, 24, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color:
                                        FlutterFlowTheme.of(context).tertiary,
                                    textStyle: FlutterFlowTheme.of(context)
                                        .titleSmall
                                        .override(
                                          fontFamily: 'Outfit',
                                          color: Colors.white,
                                          fontSize: 32,
                                        ),
                                    elevation: 3,
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
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

Future<void> bidAuction(documentID, currentBid) async {
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

class SellInAuctionWidget extends StatefulWidget {
  const SellInAuctionWidget({Key? key}) : super(key: key);

  @override
  _SellInAuctionWidgetState createState() => _SellInAuctionWidgetState();
}

class _SellInAuctionWidgetState extends State<SellInAuctionWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  double sliderValue = 10;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
            child: Text(
              'Determine the amount you want to bid',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).bodyMedium.override(
                    fontFamily: 'Outfit',
                    fontSize: 24,
                  ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 20),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                  child: Text(
                    'Bid:',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 32,
                        ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                    child: Container(
                      width: 175,
                      child: Slider(
                        activeColor: FlutterFlowTheme.of(context).primary,
                        inactiveColor: FlutterFlowTheme.of(context).alternate,
                        min: 0,
                        max: 100,
                        value: sliderValue,
                        onChanged: (newValue) {
                          newValue = double.parse(newValue.toStringAsFixed(2));
                          setState(() => sliderValue = newValue);
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),
                  child: Text(
                    '123',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 34,
                        ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 0, 0),
                  child: FaIcon(
                    FontAwesomeIcons.coins,
                    color: Color(0xFFEDDA2B),
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 15, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                Navigator.pop(context);
              },
              text: 'Confirm',
              options: FFButtonOptions(
                height: 40,
                padding: EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Outfit',
                      color: Colors.white,
                    ),
                elevation: 3,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
