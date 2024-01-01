import 'package:collectify/screens/card_details.dart';
import 'package:line_icons/line_icon.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:line_icons/line_icons.dart';

//import 'package:collectify/sharedpref_util.dart';

class CollectionScreen extends StatefulWidget {
  //String collectionName;

  CollectionScreen({
    Key? key,
    //required this.collectionName
  }) : super(key: key);

  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  late Future<List<dynamic>> auctionCards;
  late Future<List<dynamic>> fixedPriceCards;

  @override
  void initState() {
    super.initState();
    fixedPriceCards = getFixedMarket();
    auctionCards = getAuctionMarket();
  }

  // Define the getUserInfo function
  Future<List<dynamic>> getFixedMarket() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userFixedMarketCards';
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        // Decode the response body as a Map
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Access the "cardsData" key to get the array of cards
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ?? [];

        // Optional: You might want to convert each item in the list to a strongly typed object
        //final List<Map<String, dynamic>> cardList = jsonArray.map((item) => item as Map<String, dynamic>).toList();
        //print(jsonArray);
        return jsonArray;
      } else {
        // Request failed, handle the error

        throw Exception('Failed to fetch cards.');
      }
    } catch (e, stackTrace) {
      print('Failed to fetch cards fixedd. Error: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Failed to fetch cards fixedd. Error: $e');
    }
  }

// Define the getUserInfo function
  Future<List<dynamic>> getAuctionMarket() async {
    try {
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/getAllAuctions';
      var response = await http.get(
        Uri.parse(apiUrl),
      );

      if (response.statusCode == 200) {
        // Decode the response body as a Map
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Access the "cardsData" key to get the array of cards
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ?? [];

        // Optional: You might want to convert each item in the list to a strongly typed object
        //final List<Map<String, dynamic>> cardList = jsonArray.map((item) => item as Map<String, dynamic>).toList();
        print(jsonArray);
        return jsonArray;
      } else {
        // Request failed, handle the error

        throw Exception('Failed to fetch cards.');
      }
    } catch (e) {
      throw Exception('Failed to fetch cards auctionn.');
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
    late TabController tabController = TabController(length: 2, vsync: this);
    @override
    void initState() {
      super.initState();
      tabController = TabController(length: 2, vsync: this);
    }

    @override
    void dispose() {
      tabController.dispose();
      super.dispose();
    }

    return GestureDetector(
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Collection name',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF14181B),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          centerTitle: true,
          elevation: 2,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment(0, 0),
                  ),
                  Expanded(
                    child: FutureBuilder<List<dynamic>>(
                      future: fixedPriceCards,
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
                            padding: const EdgeInsets.only(top: 8),
                            child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 4,
                                      crossAxisSpacing: 4,
                                      childAspectRatio: 0.8),
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                var card = snapshot.data![index];
                                return CollectionScreenCardWidget(
                                  cardPrice: card['cardPrice'],
                                  cardUrl: card['cardURL'],
                                  cardId: card['cardID'],
                                );
                              },
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CollectionScreenCardWidget extends StatelessWidget {
  final String? cardUrl;
  int cardPrice = 0;
  final String? cardId;

  CollectionScreenCardWidget({
    required this.cardPrice,
    required this.cardUrl,
    required this.cardId, // Pass cardId in the constructor
    super.key,
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 600,
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: FlutterFlowTheme.of(context).secondaryBackground,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: EdgeInsets.all(3),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 9,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Image.network(
                      '${cardUrl}',
                      width: double.infinity,
                      height: 190,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
