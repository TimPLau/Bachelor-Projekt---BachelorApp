import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/informationToolScreen.dart';
import 'package:project_bachelorapplication/bachelorApp/views/dashboardScreen.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/task_manager_tool/milestoneScreen.dart';

InformationToolManager informationToolBuilder;
TaskManager taskManager;

  main() async{
    informationToolBuilder = new InformationToolManager("https://api.github.com/repos/TimPLau/BachelorAppRepository/contents/appContent/information-tool");
    await informationToolBuilder.init("informationToolContent.json");
    taskManager = await new  TaskManager();

    Milestone m = new Milestone("Meilenstein");
    taskManager.addMilestone(m);
    m.addTask(new Task("Task", TaskState.notCompleted));

    runApp(BachelorApp());
  }

  class BachelorApp extends StatelessWidget{
    final store = new Store<AppState>(
      appReducer,
      initialState: new AppState(informationToolBuilder.initContent, taskManager),
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
          initialRoute: '/milestoneOverview',
          routes: {
            '/': (context) => DashboardScreen("Dashboard"),
            '/guide': (context) => InformationToolScreen("Bachelorarbeit Guide"),
            '/milestoneOverview': (context) => MilestoneOverviewScreen("Deine Meilensteine"),
            '/milestoneOverview/AddingMilestones': (context) => AddingMilestoneScreen(),
          },
          //routes: new Map.fromIterables(contentManager.getRoutes(), contentManager.screens.map((f) => ((context) => f))),
        ),
      );
    }
  }