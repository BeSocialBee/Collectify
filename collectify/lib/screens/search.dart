import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<String>? _results = ['Adam', 'Addi', 'Adrey'];
  String _input = '';

  _onSearchFieldChanged(String value) async {
    setState(() {
      _input = value;
      if (value.isEmpty) {
        // null is a sentinal value that allows us more control the UI
        // for a better user experience. instead of showing 'No results for ''",
        // if this is null, it will just show nothing
        _results = null;
      }
    });

    final results = await _searchCards(value);

    setState(() {
      _results = results;
    });
  }

  Future<List<String>> _searchCards(String name) async {
    // here, we leverage Supabase's (Postgres') full text search feature
    // for super fast text searching without the need for something overkill for
    // an example like this such as ElasticSearch or Algolia
    //
    // more info on Supabase's full text search here
    // https://supabase.com/docs/guides/database/full-text-search

    // WARNING: we aren't doing proper error handling here,
    // as this is an example but typically we'd handle any exceptions via the
    // callee of this function
    // NOTE: this seaches our 'fts' (full text search column)
    // NOTE: 'limit()' will improve the performance of the call as well.
    // normally, we'd use a proper backend search index that would provide
    // us with the most relevant results, vs simply using a wildcard match
    // final result = 
    //     await Supabase.instance.client
    //     .from('names')
    //     .select('fname, lname')
    //     .textSearch('fts', "$name:*")
    //     .limit(100)
    //     .execute();

    // // WARNING: we aren't doing proper response error code handling here.
    // // normally, we're present some kind of feedback to the user if this fails
    // // and optionally report it to an external tracking system such as Sentry,
    // // Rollbar, etc
    // if (result.error != null) {
    //   print('error: ${result.error.toString()}');
    //   return [];
    // }

    final List<String> names = [];

    // convert results into a list here
    // 'result.data' is a list of Maps, where each map represents a returned
    // row in our database. each key of the map represents a table column
    // for (var v in ((result.data ?? []) as List<dynamic>)) {
    //   // NOTE: string formatting over many items can be a tad resource intensive
    //   // but since this is across a limited set of results, it should be fine.
    //   // alternatively, we can format this directly in the supabase query
    //   names.add("${v['fname']} ${v['lname']}");
    // }
    return names;
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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Text(
              'Search',
              style: FlutterFlowTheme.of(context).titleLarge.override(
                    fontFamily: 'Outfit',
                    color: Color(0xFF14181B),
                    fontSize: 28,
                    fontWeight: FontWeight.w400,
                  ),
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 0,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(16, 12, 8, 0),
                    child: TextFormField(
                      onChanged: _onSearchFieldChanged,
                      controller: TextEditingController(),
                      focusNode: FocusNode(),
                      textCapitalization: TextCapitalization.words,
                      autofocus: true,
                      obscureText: false,
                      decoration: InputDecoration(
                        labelText: 'Search for cards...',
                        labelStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        hintStyle:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Color(0xFF57636C),
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFE0E3E7),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFF4B39EF),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color(0xFFFF5963),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Color(0xFFF1F4F8),
                        contentPadding:
                            EdgeInsetsDirectional.fromSTEB(24, 24, 20, 24),
                        prefixIcon: Icon(
                          Icons.search,
                          color: Color(0xFF57636C),
                          size: 16,
                        ),
                      ),
                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                            fontFamily: 'Plus Jakarta Sans',
                            color: Color(0xFF14181B),
                            fontSize: 14,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 0),
                  child: FlutterFlowIconButton(
                    borderColor: Colors.transparent,
                    borderRadius: 30,
                    borderWidth: 1,
                    buttonSize: 50,
                    icon: Icon(
                      Icons.search_sharp,
                      color: Color(0xFF14181B),
                      size: 30,
                    ),
                    onPressed: () {
                      print('IconButton pressed ...');
                    },
                  ),
                ),
              ],
            ),
            Expanded(
              child: (_results ?? []).isNotEmpty
                  ? GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                              childAspectRatio: 0.8),
                      itemBuilder: (BuildContext context, int index) {
                        //var card = snapshot.data![index];
                        if (1 == 1) {
                        } else {}
                      },
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 200),
                      child: _results == null
                          ? Container()
                          : Center(
                              child: Text("No results for '$_input'",
                                  style: Theme.of(context).textTheme.caption),
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

