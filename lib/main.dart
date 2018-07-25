import 'dart:async';

import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';
import 'package:project_bachelorapplication/challenge_tool_data.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appContentLoader.dart';
import 'package:project_bachelorapplication/views/containers/achievement_tool_achievement_overview.dart';
import 'package:project_bachelorapplication/views/containers/achievement_tool_challenges.dart';
import 'package:project_bachelorapplication/views/containers/content_tool_content_guide.dart';
import 'package:project_bachelorapplication/views/containers/milestone_tool_milestones_overview.dart';
import 'package:project_bachelorapplication/views/presentation/achievement_overlay_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/information_tool.dart';
import 'package:project_bachelorapplication/views/presentation/bachelor_application_dashboard_screen.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'views/containers/milestone_tool_add_milestone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

var initializationSettingsAndroid;
var initializationSettingsIOS;
var initializationSettings;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

AppContentLoader contentLoader;
//TaskManager taskManager = new TaskManager();
AchievementHandler achievementHandler;
InformationToolContentBuilder informationToolContentBuilder =
    new InformationToolContentBuilder();
Map<String, Map<String, Achievement>> achievedAchievements = {"Recognized":{}, "NotRecognized":{}, "Achieved":{}, "AllAchievements":AchievementLookUp.achievements,};

init() async {
  initializationSettingsAndroid = new AndroidInitializationSettings("@mipmap/ic_launcher");
  initializationSettingsIOS = new IOSInitializationSettings();
  initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(
      initializationSettings);

  contentLoader = new AppContentLoader(
      "https://api.github.com/repos/TimPLau/BachelorAppRepository/contents/appContent/information-tool");
  //await contentLoader.loadDataFromInternet();
  informationToolContentBuilder
      .generateContent(await contentLoader.getFileContent("guide.json"));

  Map<String, Achievement> achievements;

  achievementHandler = new AchievementHandler(
      AchievementLookUp.properties, AchievementLookUp.achievements);
}

main() async{
  await init();

  runApp(BachelorApp());
}

class BachelorApp extends StatelessWidget {
  final store = new Store<AppState>(
    appReducer,
    initialState: new AppState(informationToolContentBuilder.rootContent,
        new Map<String, Milestone>(), AchievementLookUp.properties,  achievedAchievements, ChallengesLookUp.challenges),

  );

  BachelorApp(){

  }

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
          '/': (context) => DashboardScreen(),
          '/guide': (context) => ContentGuide(),
          '/milestoneOverview': (context) => MilestoneOverview(),
          '/milestoneOverview/AddingMilestones': (context) => AddMilestone(),
          '/achievementOverview': (context) => AchievementOverview(),
          '/challengeOverview': (context) => ChallengesOverview(),
        },
        //routes: new Map.fromIterables(contentManager.getRoutes(), contentManager.screens.map((f) => ((context) => f))),
      ),
    );
  }

}

Future showNotification(String achievementName, String achievementDescription) async {
  var androidPlatformChannelSpecifics = new AndroidNotificationDetails(
      'your channel id', 'your channel name', 'your channel description',
      importance: Importance.Max, priority: Priority.High);
  var iOSPlatformChannelSpecifics = new IOSNotificationDetails();
  var platformChannelSpecifics = new NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  await flutterLocalNotificationsPlugin
      .show(0, achievementName, achievementDescription, platformChannelSpecifics, payload: 'item x');
}