import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/app_content_loader.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/containers/achievement_tool_achievement_overview.dart';
import 'package:project_bachelorapplication/containers/achievement_tool_challenges.dart';
import 'package:project_bachelorapplication/containers/bachelor_application_dashboard.dart';
import 'package:project_bachelorapplication/containers/bachelorguide_tool_content_guide.dart';
import 'package:project_bachelorapplication/containers/milestone_tool_milestones_overview.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/bachelorguide_tool_content.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:redux_persist/redux_persist.dart';
import 'package:project_bachelorapplication/containers/milestone_tool_add_milestone.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:project_bachelorapplication/middleware/notificationMiddleware.dart';
import 'package:redux_persist_flutter/redux_persist_flutter.dart';

const String RECOGNIZED       = "RECOGNIZED";
const String NOT_RECOGNIZED   = "NOT_RECOGNIZED";
const String ACHIEVED         = "ACHIEVED";
const String ALL_ACHIEVEMENTS = "ALL_ACHIEVEMENTS";

AppContentLoader contentLoader = new AppContentLoader("https://api.github.com/repos/TimPLau/BachelorAppRepository/contents/appContent/information-tool");
InformationToolContentBuilder informationToolContentBuilder =
new InformationToolContentBuilder();

Map<String, Map<String, Achievement>> achievedAchievements = {
  RECOGNIZED : {},
  NOT_RECOGNIZED : {},
  ACHIEVED : {},
  ALL_ACHIEVEMENTS: achievements,
};

init() async {

  initializationSettingsAndroid = new AndroidInitializationSettings("@mipmap/ic_launcher");
  initializationSettingsIOS = new IOSInitializationSettings();
  initializationSettings = new InitializationSettings(initializationSettingsAndroid, initializationSettingsIOS);
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  await contentLoader.loadDataFromInternet();
  await contentLoader.saveDataOnDevice();
  await informationToolContentBuilder.generateContent(await contentLoader.getFileContent("guide.json"));

  globalAppContent = await informationToolContentBuilder.rootContent;

}

main() async {
  await init();
  await runApp(BachelorApp());
}

class BachelorApp extends StatelessWidget {
  Persistor<AppState> persistor;
  Store<AppState> store;

  BachelorApp() {
    persistor = new Persistor<AppState>(
      storage: new FlutterStorage("AppStateStorage"),

      decoder: AppState.fromJsonDecoder
    );

    store = new Store<AppState>(
      appReducer,
      initialState: new AppState(
          informationToolContent:  informationToolContentBuilder.rootContent,
          currentMilestones:  new SplayTreeMap<String, Milestone>(),
          properties:  properties,
          achievedAchievements:  achievedAchievements,
          challenges:  challenges,
          begin:  null,
          end:  null),
      middleware: [notificationMiddleware, persistor.createMiddleware()],
    );

    persistor.start(store);
  }

  @override
  Widget build(BuildContext context) {
    return new PersistorGate(
      persistor: persistor,
      builder: (context) => new StoreProvider(
        store: store,
        child: new MaterialApp(
          theme: new ThemeData(
              bottomAppBarColor: Colors.red, backgroundColor: Colors.white),
          title: "BachelorApp",
          initialRoute: '/',
          routes: {
            '/': (context) => Dashboard(),
            '/guide': (context) => ContentGuide(),
            '/milestoneOverview': (context) => MilestoneOverview(),
            '/milestoneOverview/AddingMilestones': (context) => AddMilestone(),
            '/achievementOverview': (context) => AchievementOverview(),
            '/challengeOverview': (context) => ChallengesOverview(),
          },
          //routes: new Map.fromIterables(contentManager.getRoutes(), contentManager.screens.map((f) => ((context) => f))),
        ),
    )

    );
  }
}
