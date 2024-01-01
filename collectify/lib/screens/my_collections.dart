import 'package:collectify/screens/card_details.dart';
import 'package:collectify/widgets/bottom_navigation_bar.dart';
import '/flutter_flow/flutter_flow_button_tabbar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:line_icons/line_icon.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:collectify/widgets/card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyCollection extends StatefulWidget {
  static String id = 'my_collection_screen';
  @override
  State<MyCollection> createState() => _MyCollectionState();
}

class _MyCollectionState extends State<MyCollection> {

  late Future<List<dynamic>> userCards;

  @override
  void initState() {
    super.initState();
    userCards = getUserCards();
  }

  // Define the getUserInfo function
  Future<List<dynamic>> getUserCards() async {
    try {
      //var userID = await SharedPreferencesUtil.loadUserIdFromLocalStorage();
      var userID = "luK4dXzgq9eVH7ZL0NczLWCxe8J3";
      String apiUrl =
          'https://z725a0ie1j.execute-api.us-east-1.amazonaws.com/userStage/userCollections';
      var response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'userID': userID,
        },
      );

      // Check the response status
      if (response.statusCode == 200) {
        // Request successful, you can handle the response data here
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> jsonArray = jsonResponse['cardsData'] ?? [];
        return jsonArray;
      } else {
        // Request failed, handle the error
        print('Error response: ${response.statusCode}');
        throw Exception('Failed to fetch cards fixedd.');
      }
    } catch (e) {
      // Handle errors, such as invalid credentials
      print('Errorloading profile: $e');
      throw Exception('Failed to fetch cards fixedd. Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'My Cards',
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
              padding: const EdgeInsets.only(top: 8.0),
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
        body: FutureBuilder<List<dynamic>>(
          future: userCards,
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
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4,
                      crossAxisSpacing: 4,
                      childAspectRatio: 0.8),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var card = snapshot.data![index];
                    return Widget1(
                      cardPrice: card['cardPrice'],
                      cardUrl: card['cardURL'],
                      cardId: card['uniquecardId'],
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Widget1 extends StatelessWidget {
  final String? cardUrl;
  final int? cardPrice;
  final String? cardId;

  Widget1({
    required this.cardPrice,
    required this.cardUrl,
    required this.cardId, // Pass cardId in the constructor
    super.key,
  });

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CardDetails(
                      cardId: cardId!,
                    ))); // Constructer içine gerekli inputları yaz
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
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CardDetails(
                                          cardId: cardId!,
                                        )));
                          },
                          text: 'View',
                          options: FFButtonOptions(
                            width: 100,
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
