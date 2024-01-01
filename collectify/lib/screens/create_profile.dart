import 'dart:math';
import '/flutter_flow/flutter_flow_animations.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:fluttermoji/fluttermoji.dart';

class CreateProfile extends StatefulWidget {
  CreateProfile({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              FlutterFlowTheme.of(context).tertiary,
              FlutterFlowTheme.of(context).tertiary
            ],
            stops: [0, 1],
            begin: AlignmentDirectional(0.87, -1),
            end: AlignmentDirectional(-0.87, 1),
          ),
          shape: BoxShape.rectangle,
        ),
        alignment: AlignmentDirectional(0, -1),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 70, 0, 32),
                child: Container(
                  width: 220,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  alignment: AlignmentDirectional(0, 0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                        child: Icon(
                          Icons.flourescent_rounded,
                          color: FlutterFlowTheme.of(context).info,
                          size: 44,
                        ),
                      ),
                      Text(
                        'Collectify',
                        style:
                            FlutterFlowTheme.of(context).displaySmall.override(
                                  fontFamily: 'Outfit',
                                  color: FlutterFlowTheme.of(context).info,
                                ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(padding: EdgeInsets.all(16),
              child: Container(
                width: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 570,
                    ),
                    decoration: BoxDecoration(
                      color: FlutterFlowTheme.of(context).secondaryBackground,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 4,
                          color: Color(0x33000000),
                          offset: Offset(0, 2),
                        )
                      ],
                      borderRadius: BorderRadius.circular(12),
                    ),
              child: Align(
                child: Padding(padding: EdgeInsets.all(8),
                child: Column(children: [SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Create your avatar",
                  style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 25,
              ),
              FluttermojiCircleAvatar(
                backgroundColor: Colors.grey[200],
                radius: 100,
              ),
              SizedBox(
                height: 25,
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Spacer(flex: 2),
                  Expanded(
                    flex: 3,
                    child: Container(
                      height: 35,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.edit),
                        label: Text("Customize"),
                        onPressed: () => Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => NewPage())),
                      ),
                    ),
                  ),
                  Spacer(flex: 2),
                ],
              ),
              SizedBox(
                height: 100,
              ),],),),
              ),),),



              
            ],
          ),
        ),
      ),
    );
  }
}

class NewPage extends StatelessWidget {
  const NewPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: FluttermojiCircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.grey[200],
                ),
              ),
              SizedBox(
                width: min(600, _width * 0.85),
                child: Row(
                  children: [
                    Text(
                      "Customize:",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Spacer(),
                    FluttermojiSaveWidget(),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 30),
                child: FluttermojiCustomizer(
                  scaffoldWidth: min(600, _width * 0.85),
                  autosave: false,
                  theme: FluttermojiThemeData(
                      boxDecoration: BoxDecoration(boxShadow: [BoxShadow()])),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
