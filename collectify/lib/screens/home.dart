// Her kartın nadirliğini belirten bir değer -> Integer olabilir, mesela sıradan=1, nadir=2, destansı=3, efsanevi=4 ===== Başka bir şey de olabilir.
// Kullanıcı adı
// 



import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final scaffoldKey = GlobalKey<ScaffoldState>();

  
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
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 6, 16, 6),
                        child: Container(
                          width: 53,
                          height: 53,
                          decoration: BoxDecoration(
                            color: Color(0x4D9489F5),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Color(0xFF6F61EF),
                              width: 2,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(2),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.network(
                                'https://picsum.photos/seed/626/600',
                                width: 300,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Welcome, Seyfullah',
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                fontFamily: 'Outfit',
                                color: Color(0xFF15161E),
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
                        child: FlutterFlowIconButton(
                          borderColor: Colors.transparent,
                          borderRadius: 20,
                          buttonSize: 40,
                          icon: Icon(
                            Icons.notifications_none,
                            color: Color(0xFF15161E),
                            size: 24,
                          ),
                          onPressed: () {
                            print('IconButton pressed ...');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                StickyHeader(
                  overlapHeaders: false,
                  header: Container(
                    width: double.infinity,
                    height: 80,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0x9AFFFFFF)],
                        stops: [0, 1],
                        begin: AlignmentDirectional(0, -1),
                        end: AlignmentDirectional(0, 1),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 8, 16, 12),
                      child: Container(
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 3,
                              color: Color(0x33000000),
                              offset: Offset(0, 1),
                            )
                          ],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Color(0xFFE5E7EB),
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 8, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.search_rounded,
                                color: Color(0xFF606A85),
                                size: 24,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 0, 0, 0),
                                  child: Container(
                                    width: 200,
                                    child: TextFormField(
                                      controller: TextEditingController(),
                                      focusNode: FocusNode(),
                                      obscureText: false,
                                      decoration: InputDecoration(
                                        labelText: 'Search listings...',
                                        labelStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF606A85),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        hintStyle: FlutterFlowTheme.of(context)
                                            .labelMedium
                                            .override(
                                              fontFamily: 'Outfit',
                                              color: Color(0xFF606A85),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                            ),
                                        enabledBorder: InputBorder.none,
                                        focusedBorder: InputBorder.none,
                                        errorBorder: InputBorder.none,
                                        focusedErrorBorder: InputBorder.none,
                                        filled: true,
                                        fillColor: Colors.white,
                                      ),
                                      style: FlutterFlowTheme.of(context)
                                          .bodyMedium
                                          .override(
                                            fontFamily: 'Plus Jakarta Sans',
                                            color: Color(0xFF15161E),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                      cursorColor: Color(0xFF6F61EF),
                                    ),
                                  ),
                                ),
                              ),
                              FlutterFlowIconButton(
                                borderColor: Color(0xFFE5E7EB),
                                borderRadius: 10,
                                borderWidth: 1,
                                buttonSize: 40,
                                fillColor: Colors.white,
                                icon: Icon(
                                  Icons.tune_rounded,
                                  color: Color(0xFF15161E),
                                  size: 24,
                                ),
                                onPressed: () {
                                  print('IconButton pressed ...');
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  content: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                        child: Text(
                          'New Listings',
                          style:
                              FlutterFlowTheme.of(context).labelMedium.override(
                                    fontFamily: 'Outfit',
                                    color: Color(0xFF606A85),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 4),
                        child: Container(
                          width: double.infinity,
                          height: 270,
                          decoration: BoxDecoration(),
                          child: ListView(
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            scrollDirection: Axis.horizontal,
                            children: [
                              NewListingCard(),
                              NewListingCard(),
                              NewListingCard(),
                            ].divide(SizedBox(width: 16)),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Color(0xFFF1F4F8),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(16, 16, 0, 12),
                              child: Text(
                                'Most Viewed',
                                style: FlutterFlowTheme.of(context)
                                    .labelMedium
                                    .override(
                                      fontFamily: 'Outfit',
                                      color: Color(0xFF606A85),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                            Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(0, 0, 0, 44),
                              child: ListView(
                                padding: EdgeInsets.zero,
                                primary: false,
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                children: [
                                  MostViewedCard(),
                                  MostViewedCard(),
                                  MostViewedCard(),
                                ].divide(SizedBox(height: 12)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
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

class MostViewedCard extends StatelessWidget {
  const MostViewedCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          16, 0, 16, 0),
      child: Container(
        width: 220,
        height: 240,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              color: Color(0x33000000),
              offset: Offset(0, 2),
            )
          ],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFE5E7EB),
            width: 1,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(
                              8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1597475681177-809cfdc76cd2?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MXx8YmVhY2hob3VzZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=900&q=60',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment:
                          AlignmentDirectional(
                              1, -1),
                      child: Padding(
                        padding:
                            EdgeInsetsDirectional
                                .fromSTEB(
                                    0, 8, 8, 0),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius
                                  .circular(12),
                          child: BackdropFilter(
                            filter:
                                ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 2,
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize
                                      .min,
                              children: [
                                Container(
                                  height: 32,
                                  decoration:
                                      BoxDecoration(
                                    color: Color(
                                        0x9AFFFFFF),
                                    borderRadius:
                                        BorderRadius
                                            .circular(
                                                12),
                                    border: Border
                                        .all(
                                      color: Color(
                                          0xFFE5E7EB),
                                      width: 2,
                                    ),
                                  ),
                                  alignment:
                                      AlignmentDirectional(
                                          0, 0),
                                  child: Padding(
                                    padding: EdgeInsetsDirectional
                                        .fromSTEB(
                                            8,
                                            0,
                                            8,
                                            0),
                                    child: Text(
                                      'Legendary',
                                      style: FlutterFlowTheme.of(
                                              context)
                                          .bodyMedium
                                          .override(
                                            fontFamily:
                                                'Plus Jakarta Sans',
                                            color:
                                                Color(0xFF15161E),
                                            fontSize:
                                                14,
                                            fontWeight:
                                                FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional
                    .fromSTEB(0, 8, 0, 0),
                child: Text(
                  'Card Name',
                  style:
                      FlutterFlowTheme.of(context)
                          .titleLarge
                          .override(
                            fontFamily: 'Outfit',
                            color:
                                Color(0xFF15161E),
                            fontSize: 22,
                            fontWeight:
                                FontWeight.w500,
                          ),
                ),
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment:
                    MainAxisAlignment
                        .spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional
                        .fromSTEB(0, 4, 0, 8),
                    child: RichText(
                      textScaleFactor:
                          MediaQuery.of(context)
                              .textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '\$210',
                            style: TextStyle(
                              color: Color(
                                  0xFF6F61EF),
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                            style: FlutterFlowTheme
                                    .of(context)
                                .labelSmall
                                .override(
                                  fontFamily:
                                      'Outfit',
                                  color: Color(
                                      0xFF606A85),
                                  fontSize: 12,
                                  fontWeight:
                                      FontWeight
                                          .w500,
                                ),
                          )
                        ],
                        style: FlutterFlowTheme
                                .of(context)
                            .labelMedium
                            .override(
                              fontFamily:
                                  'Outfit',
                              color: Color(
                                  0xFF606A85),
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsetsDirectional
                        .fromSTEB(0, 4, 0, 8),
                    child: RichText(
                      textScaleFactor:
                          MediaQuery.of(context)
                              .textScaleFactor,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '',
                            style: TextStyle(),
                          )
                        ],
                        style: FlutterFlowTheme
                                .of(context)
                            .labelMedium
                            .override(
                              fontFamily:
                                  'Outfit',
                              color: Color(
                                  0xFF606A85),
                              fontSize: 14,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewListingCard extends StatelessWidget {
  const NewListingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0, 12, 0, 12),
      child: Container(
        width: 220,
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Color(0xFFE5E7EB),
            width: 2,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(8),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1519046904884-53103b34b206?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8YmVhY2h8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=900&q=60',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Align(
                      alignment:
                          AlignmentDirectional(1, -1),
                      child: Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(0, 8, 8, 0),
                        child: ClipRRect(
                          borderRadius:
                              BorderRadius.circular(
                                  12),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(
                              sigmaX: 5,
                              sigmaY: 2,
                            ),
                            child: Row(
                              mainAxisSize:
                                  MainAxisSize.min,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsetsDirectional
                                          .fromSTEB(
                                              16,
                                              0,
                                              0,
                                              0),
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration:
                                        BoxDecoration(
                                      color: Color(
                                          0x9AFFFFFF),
                                      borderRadius:
                                          BorderRadius
                                              .circular(
                                                  12),
                                      border:
                                          Border.all(
                                        color: Color(
                                            0xFFE5E7EB),
                                        width: 2,
                                      ),
                                    ),
                                    alignment:
                                        AlignmentDirectional(
                                            0, 0),
                                    child: Padding(
                                      padding:
                                          EdgeInsets
                                              .all(2),
                                      child: Icon(
                                        Icons
                                            .favorite_border,
                                        color: Color(
                                            0xFF15161E),
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(
                        0, 8, 0, 0),
                child: Text(
                  'Card Name',
                  style: FlutterFlowTheme.of(context)
                      .titleLarge
                      .override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF15161E),
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsetsDirectional.fromSTEB(
                        0, 4, 0, 8),
                child: RichText(
                  textScaleFactor:
                      MediaQuery.of(context)
                          .textScaleFactor,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '\$421',
                        style: TextStyle(
                          color: Color(0xFF6F61EF),
                        ),
                      ),
                      TextSpan(
                        text: ' ',
                        style: FlutterFlowTheme.of(
                                context)
                            .labelSmall
                            .override(
                              fontFamily: 'Outfit',
                              color:
                                  Color(0xFF606A85),
                              fontSize: 12,
                              fontWeight:
                                  FontWeight.w500,
                            ),
                      )
                    ],
                    style: FlutterFlowTheme.of(
                            context)
                        .labelMedium
                        .override(
                          fontFamily: 'Outfit',
                          color: Color(0xFF606A85),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
