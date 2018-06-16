import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:project_bachelorapplication/models/json_reader.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

final String path = 'assets/data/';
final String contentFilename = 'content.json';
String localPath;
ContentManager contentManager;
List<Screen> screens;
List<String> paths;

Future<String> get _localPath async {
  return rootBundle.loadString(path + contentFilename);
}

  init()async{
    localPath = await _localPath;
  }

  void main() async{
    await init();
    JSONReader jsonReader = new JSONReader(localPath);
    contentManager = jsonReader.contentManager;
    runApp(BachelorApp());
  }

  class BachelorApp extends StatelessWidget{

    final store = new Store(
      appReducer,
      initialState: new AppState("BachelorApp", "/", contentManager.content),
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
          home: new Screen(contentManager.content, "Home"),
          routes: new Map.fromIterables(contentManager.getRoutes(), contentManager.screens.map((f) => ((context) => f))),
        ),
      );
    }
  }