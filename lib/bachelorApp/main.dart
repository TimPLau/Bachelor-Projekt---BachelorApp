import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/content.dart';
import 'package:project_bachelorapplication/bachelorApp/views/informationToolScreen.dart';
import 'package:project_bachelorapplication/bachelorApp/views/dashboardScreen.dart';

InformationToolManager informationToolBuilder;

  Future main() async {
    informationToolBuilder = new InformationToolManager("https://api.github.com/repos/TimPLau/BachelorAppRepository/contents/appContent/information-tool");
    await informationToolBuilder.init("informationToolContent.json");

    runApp(BachelorApp());
  }

  class BachelorApp extends StatelessWidget{
    final store = new Store<AppState>(
      appReducer,
      initialState: new AppState(informationToolBuilder.initContent),
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
          initialRoute: '/',
          routes: {
            '/': (context) => DashboardScreen("Dashboard"),
            '/guide': (context) => InformationToolScreen("Bachelorarbeit Guide"),
          },
          //routes: new Map.fromIterables(contentManager.getRoutes(), contentManager.screens.map((f) => ((context) => f))),
        ),
      );
    }
  }