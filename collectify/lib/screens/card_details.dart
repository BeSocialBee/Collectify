import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:collectify/utils/sharedpref_util.dart';
import 'dart:convert';

class CardDetails extends StatefulWidget {
  final String cardId;

  const CardDetails({Key? key, required this.cardId}) : super(key: key);

  @override
  _CardDetailsState createState() => _CardDetailsState();
}

class _CardDetailsState extends State<CardDetails> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static late String cardId;

  late Future<Map<String, dynamic>> cardData;
  late Future<Map<String, dynamic>> userData;

  @override
  void initState() {
    super.initState();
    cardId = widget.cardId;
    cardData = getCardbyID(cardId);
    userData = getUserInfo();
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
            'Card Details',
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
              future: cardData,
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
                            width: double.infinity,
                            height: 406,
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
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
                                  color: FlutterFlowTheme.of(context).tertiary,
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
                                    '${card['cardURL']}',
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
                                  color: FlutterFlowTheme.of(context).tertiary,
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
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 10, 0, 0),
                                      child: Text(
                                        '${card['cardTitle']}',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium
                                            .override(
                                              fontFamily: 'Outfit',
                                              fontSize: 30,
                                            ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          0, 20, 0, 0),
                                      child: Text(
                                        '',
                                        style: FlutterFlowTheme.of(context)
                                            .bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      FutureBuilder(
                        future: userData,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (!snapshot.hasData ||
                              snapshot.data!.isEmpty) {
                            return Center(
                              child: Text('No data available.'),
                            );
                          } else {
                            return Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(20, 20, 20, 0),
                              child: Container(
                                width: double.infinity,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.cyanAccent,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    FFButtonWidget(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              // onTap: () => _model.unfocusNode.canRequestFocus
                                              //     ? FocusScope.of(context)
                                              //         .requestFocus(_model.unfocusNode)
                                              //     : FocusScope.of(context).unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 150,
                                                  child: QuickSellWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      text: 'Quick Sell',
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
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
                                    FFButtonWidget(
                                      onPressed: () async {
                                        await showModalBottomSheet(
                                          isScrollControlled: true,
                                          backgroundColor: Colors.transparent,
                                          enableDrag: false,
                                          context: context,
                                          builder: (context) {
                                            return GestureDetector(
                                              // onTap: () => _model.unfocusNode.canRequestFocus
                                              //     ? FocusScope.of(context)
                                              //         .requestFocus(_model.unfocusNode)
                                              //     : FocusScope.of(context).unfocus(),
                                              child: Padding(
                                                padding:
                                                    MediaQuery.viewInsetsOf(
                                                        context),
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 300,
                                                  child: SellInAuctionWidget(),
                                                ),
                                              ),
                                            );
                                          },
                                        ).then((value) => safeSetState(() {}));
                                      },
                                      text: 'Auction',
                                      options: FFButtonOptions(
                                        height: 40,
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            24, 0, 24, 0),
                                        iconPadding:
                                            EdgeInsetsDirectional.fromSTEB(
                                                0, 0, 0, 0),
                                        color: FlutterFlowTheme.of(context)
                                            .primary,
                                        textStyle: FlutterFlowTheme.of(context)
                                            .titleSmall
                                            .override(
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
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  );
                }
              },
            )),
      ),
    );
  }
}

class SellInAuctionWidget extends StatefulWidget {
  const SellInAuctionWidget({Key? key}) : super(key: key);

  @override
  _SellInAuctionWidgetState createState() => _SellInAuctionWidgetState();
}

class _SellInAuctionWidgetState extends State<SellInAuctionWidget> {
  double sliderValue = 0;
  int hour = 0;
  int minute = 1;
  late Future<Map<String, dynamic>> cardData;
  late Future<Map<String, dynamic>> userData;
  late Future<Map<String, dynamic>> makeAuctionData;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 275,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(25, 0, 0, 0),
                  child: Text(
                    'Start Price: ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 20,
                        ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: Container(
                    width: 150,
                    child: Slider(
                      activeColor: FlutterFlowTheme.of(context).primary,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      min:
                          0, // ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> BURAYA KARTIN FİYATINDAN 10 FALAN FAZLA YAZABİLİRSİN
                      max:
                          100, // ->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> BURASI user.balance OLCAK YUKARDA USER BİLGİLERİNİ ALDIM
                      value: sliderValue, // _model.sliderValue ??= 5,
                      onChanged: (newValue) {
                        newValue = double.parse(newValue.toStringAsFixed(2));
                        setState(() => sliderValue = newValue);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),
                  child: Text(
                    '$sliderValue',
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
            padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Duration in Hours: ',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(23, 0, 10, 0),
                  child: FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 45,
                    fillColor: FlutterFlowTheme.of(context).accent3,
                    icon: FaIcon(
                      FontAwesomeIcons.minus,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        if (hour == 0) {
                        } else {
                          hour--;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                      child: Text(
                        '$hour',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              fontSize: 32,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 45,
                    fillColor: FlutterFlowTheme.of(context).accent3,
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        hour++;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(25, 10, 0, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Duration in Minutes: ',
                  style: FlutterFlowTheme.of(context).bodyMedium.override(
                        fontFamily: 'Outfit',
                        fontSize: 20,
                      ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(6, 0, 10, 0),
                  child: FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 45,
                    fillColor: FlutterFlowTheme.of(context).accent3,
                    icon: FaIcon(
                      FontAwesomeIcons.minus,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        if (minute == 1) {
                        } else {
                          minute--;
                        }
                      });
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(5, 0, 5, 0),
                  child: Container(
                    width: 80,
                    height: 50,
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                      border: Border.all(
                        color: Colors.grey,
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 2, 0, 0),
                      child: Text(
                        '$minute',
                        textAlign: TextAlign.center,
                        style: FlutterFlowTheme.of(context).bodyMedium.override(
                              fontFamily: 'Outfit',
                              fontSize: 32,
                            ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
                  child: FlutterFlowIconButton(
                    borderColor: FlutterFlowTheme.of(context).primary,
                    borderRadius: 20,
                    borderWidth: 1,
                    buttonSize: 45,
                    fillColor: FlutterFlowTheme.of(context).accent3,
                    icon: Icon(
                      Icons.add,
                      color: FlutterFlowTheme.of(context).primaryText,
                      size: 24,
                    ),
                    onPressed: () {
                      setState(() {
                        if (minute == 59) {
                        } else {
                          minute++;
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 25, 0, 0),
            child: FFButtonWidget(
              onPressed: () async {
                makeAuctionData = MakeAuction(
                    _CardDetailsState.cardId, hour, minute, sliderValue);

                Navigator.pop(context);
              },
              text: 'Ok',
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

class QuickSellWidget extends StatefulWidget {
  const QuickSellWidget({Key? key}) : super(key: key);

  @override
  _QuickSellWidgetState createState() => _QuickSellWidgetState();
}

class _QuickSellWidgetState extends State<QuickSellWidget> {
  double sliderValue = 0;
  late Future<Map<String, dynamic>> cardData;
  late Future<Map<String, dynamic>> userData;
  late Future<Map<String, dynamic>> quickSellData;


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 200,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 20, 0, 10),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(30, 0, 0, 0),
                  child: Text(
                    'Price: ',
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Outfit',
                          fontSize: 24,
                        ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(),
                  child: Container(
                    width: 175,
                    child: Slider(
                      activeColor: FlutterFlowTheme.of(context).primary,
                      inactiveColor: FlutterFlowTheme.of(context).alternate,
                      min: 0,
                      max: 110,
                      value: sliderValue, //_model.sliderValue ??= 5,
                      onChanged: (newValue) {
                        newValue = double.parse(newValue.toStringAsFixed(2));
                        setState(() => sliderValue = newValue);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(10, 0, 5, 0),
                  child: Text(
                    '$sliderValue',
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
                quickSellData = QuickSell(_CardDetailsState.cardId, sliderValue);
                Navigator.pop(context);
              },
              text: 'Sell',
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

Future<Map<String, dynamic>> getCardbyID(uniquecardId) async {
  try {
    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getCardByIdMyCollection';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'uniquecardId': uniquecardId,
      },
    );

    // Check the response status
    if (response.statusCode == 200) {
      //print(response.body);
      // Request successful, you can handle the response data here
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body); // Decode the response body as a Map
      final Map<String, dynamic> jsonArray = jsonResponse['cardData'] ??
          []; // Access the "cardsData" key to get the array of cards
      return jsonArray;
    } else {
      // Request failed, handle the error
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    // Handle errors, such as invalid credentials
    print('Errorloading profile: $e');
    throw Exception('Failed to get card data');
  }
}

Future<Map<String, dynamic>> MakeAuction(
    cardId, hour, minute, bidAmount) async {
  try {
      //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";
      
      print(userID);
      print(cardId);
      print(hour);
      print(minute);
      print(bidAmount);

      String apiUrl = 'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/AddNewAuction';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userID': userID,
          'uniquecardId': cardId,
          'hour' : hour.toString(),
          'minute' : minute.toString(),
          'bidAmount' : bidAmount.toString(),
        },
      );
      // Check the response status
      if (response.statusCode == 200) {
        print(response.body);
        return {'success': true}; // Modify this based on your actual response 
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to get card data');
      }
    } catch (e) {
      // Handle errors, such as invalid credentials
      print('Error making auction : $e');
      throw Exception('Failed to get card data');
    }
}

Future<Map<String, dynamic>> getUserInfo() async {
  try {
    //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
    var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";

    String apiUrl =
        'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userProfileInfo';
    var response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'userID': userID,
      },
    );

    // Check the response status
    if (response.statusCode == 200) {
      //print(response.body);
      // Request successful, you can handle the response data here
      final Map<String, dynamic> jsonResponse =
          jsonDecode(response.body); // Decode the response body as a Map
      final Map<String, dynamic> jsonArray = jsonResponse['usersData'] ??
          []; // Access the "cardsData" key to get the array of cards
      return jsonArray;
    } else {
      // Request failed, handle the error
      print('Error response: ${response.statusCode}');
      throw Exception('Failed to get card data');
    }
  } catch (e) {
    // Handle errors, such as invalid credentials
    print('Errorloading profile: $e');
    throw Exception('Failed to get card data');
  }
}


Future<Map<String, dynamic>> QuickSell(
    cardId, newPrice) async {
  try {
      //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";
      
      print(userID);
      print(cardId);
      print(newPrice);

      String apiUrl = 'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userSellInPazar';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userID': userID,
          'cardId': cardId,
          'newPrice': newPrice,
        },
      );
      // Check the response status
      if (response.statusCode == 200) {
        print(response.body);
        return {'success': true}; // Modify this based on your actual response 
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to get card data');
      }
    } catch (e) {
      // Handle errors, such as invalid credentials
      print('Error making auction : $e');
      throw Exception('Failed to get card data');
    }
}