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

class Market extends StatefulWidget {
  const Market({Key? key}) : super(key: key);

  @override
  _ListProductsWidgetState createState() => _ListProductsWidgetState();
}

class _ListProductsWidgetState extends State<Market>
    with TickerProviderStateMixin {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  static String id = 'market_screen';

  late Future<List<dynamic>> auctionCards;
  late Future<List<dynamic>> fixedPriceCards;

  // Define the signIn function
  Future<void> buy(cardId) async {
    try {
      //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      //print(userID);

      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userHandleBuy';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'cardId': cardId,
          //'userID': userID,
        },
      );

      // Check th*e response status
      if (response.statusCode == 200) {
        print('Success response: ${response.statusCode}');
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
      }
    } catch (e) {
      // Handle sign-in errors, such as invalid credentials
      print('Error signing in: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fixedPriceCards = getFixedMarket();
    auctionCards = getAuctionMarket();
    print(fixedPriceCards);

    //auctionCards = getAuctionMarket();
  }

  // Define the getUserInfo function
  Future<List<dynamic>> getFixedMarket() async {
    try {
      print("burdaa");
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
        // Request successful, you can handle the response data here
        List<dynamic> responseData = json.decode(response.body);

        print(response.statusCode);
        return responseData;
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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Market',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF14181B),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4),
              child: Row(
                children: [
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 22, right: 12),
                      child: Container(
                        height: 40,
                        child: Row(
                          children: [
                            Text(
                              '123',
                              style: FlutterFlowTheme.of(context)
                                  .titleLarge
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 22,
                                    fontWeight: FontWeight.w300,
                                  ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            LineIcon.coins(
                              color: Colors.yellow,
                              size: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                  )
                ],
              ),
            ),
          ],
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
                    child: FlutterFlowButtonTabBar(
                      useToggleButtonStyle: false,
                      isScrollable: true,
                      labelStyle:
                          FlutterFlowTheme.of(context).titleMedium.override(
                                fontFamily: 'Plus Jakarta Sans',
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                      unselectedLabelStyle: TextStyle(),
                      labelColor: Color(0xFF4B39EF),
                      unselectedLabelColor: Color(0xFF57636C),
                      backgroundColor: Color(0x4C4B39EF),
                      borderColor: Color(0xFF4B39EF),
                      borderWidth: 2,
                      borderRadius: 12,
                      elevation: 0,
                      labelPadding:
                          EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      buttonMargin:
                          EdgeInsetsDirectional.fromSTEB(0, 12, 16, 0),
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                      tabs: [
                        Tab(
                          text: 'Auction',
                        ),
                        Tab(
                          text: 'Quick Buy',
                        ),
                      ],
                      controller: tabController,
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        FutureBuilder<List<dynamic>>(
                          future: auctionCards,
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
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    var card = snapshot.data![index];
                                    return Widget1(
                                      cardPrice: card['cardPrice'],
                                      cardUrl: card['cardURL'],
                                    );
                                  },
                                ),
                              );
                            }
                          },
                        ),
                        FutureBuilder<List<dynamic>>(
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
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: GridView.builder(
                                    gridDelegate:
                                        const SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 2,
                                            mainAxisSpacing: 4,
                                            crossAxisSpacing: 4,
                                            childAspectRatio: 0.8),
                                    itemCount: snapshot.data!.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      var card = snapshot.data![index];
                                      return Widget1(
                                        cardPrice: card['cardPrice'],
                                        cardUrl: card['cardURL'],
                                      );
                                    },
                                  ),
                                );
                              }
                            })
                      ],
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

class AuctionMarketCardDetails extends StatelessWidget {
  const AuctionMarketCardDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          //context.pushNamed('null');
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF1F4F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    'https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/7c5678f4-c28d-4862-a8d9-56750f839f12/zion-1-basketball-shoes-bJ0hLJ.png',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    'burasii mii',
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF14181B),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
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

class QuickBuyMarketCardDetails extends StatelessWidget {
  final Map<String, dynamic> cardData;

  const QuickBuyMarketCardDetails({
    required this.cardData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String cardTitle = cardData['cardTitle'] ?? '';
    String cardDescription = cardData['cardDescription'] ?? '';
    String cardURL = cardData['cardURL'] ?? '';

    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 0),
      child: InkWell(
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () async {
          //context.pushNamed('null');
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xFFF1F4F8),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(8, 8, 12, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    '$cardURL',
                    width: 70,
                    height: 70,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                  child: Text(
                    cardTitle,
                    style: FlutterFlowTheme.of(context).bodyLarge.override(
                          fontFamily: 'Plus Jakarta Sans',
                          color: Color(0xFF14181B),
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
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

class Widget1 extends StatelessWidget {
  final String? cardUrl;
  int cardPrice = 0;
  //final String? cardId;

  Widget1({
    required this.cardPrice,
    required this.cardUrl,
    //required this.cardId, // Pass cardId in the constructor
    super.key,
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             ProductDetailsWidget())); // Constructer içine gerekli inputları yaz
      },
      child: Container(
        height: 800,
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
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 6, 0, 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              '\$ $cardPrice',
                              style: FlutterFlowTheme.of(context)
                                  .headlineSmall
                                  .override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF14181B),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            // await buy(this.cardId);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ProductDetailsWidget()));
                          },
                          text: 'Buy',
                          options: FFButtonOptions(
                            width: 70,
                            height: 30,
                            padding:
                                EdgeInsetsDirectional.fromSTEB(24, 0, 24, 0),
                            iconPadding:
                                EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                            color: FlutterFlowTheme.of(context).tertiary,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Outfit',
                                  color: Colors.white,
                                  fontSize: 24,
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
