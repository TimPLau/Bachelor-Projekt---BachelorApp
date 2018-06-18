import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/content.dart';
import 'package:project_bachelorapplication/bachelorApp/pages/screen.dart';

final String path = 'assets/data/';
final String contentFilename = 'content.json';
String localPath;
ContentBuilder contentBuilder;

Future<String> get _localPath async {
  return rootBundle.loadString(path + contentFilename);
}

  init()async{
    localPath = await _localPath;
  }

  void main() async{
    await init();

    contentBuilder = new ContentBuilder(localPath);
    runApp(BachelorApp());
  }

  class BachelorApp extends StatelessWidget{

    final store = new Store(
      appReducer,
      initialState: new AppState(contentBuilder.initContent ,contentBuilder.content[0]),
    );

  @override
  Widget build(BuildContext context) {
      return StoreProvider(
        store: store,
        child: new MaterialApp(
          theme: new ThemeData(
            bottomAppBarColor: Colors.red,
          ),
          title: "BachelorApp",
          home: new Screen("Guide"),
          //routes: new Map.fromIterables(contentManager.getRoutes(), contentManager.screens.map((f) => ((context) => f))),
        ),
      );
    }
  }