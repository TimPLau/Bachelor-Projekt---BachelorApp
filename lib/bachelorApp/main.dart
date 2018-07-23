import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/challenge_tool_data.dart';
import 'package:project_bachelorapplication/bachelorApp/models/achievement_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/achievement_tool_datas.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/achievement_tool_achievement_overview.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/achievement_tool_challenges.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/content_tool_content_guide.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/milestone_tool_milestones_overview.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/achievement_tool_challenges_overview_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/reducers/app_reducer.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/models/information_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/bachelor_application_dashboard_screen.dart';
import 'package:project_bachelorapplication/bachelorApp/models/milestone_tool.dart';
import 'views/containers/milestone_tool_add_milestone.dart';

ContentBuilder informationToolBuilder;
TaskManager taskManager;
AchievementManager achievementManager;

  main() async{

    achievementManager = new AchievementManager(AchievementLookUp.properties, AchievementLookUp.achievements);

    informationToolBuilder = new ContentBuilder("https://api.github.com/repos/TimPLau/BachelorAppRepository/contents/appContent/information-tool");
    await informationToolBuilder.init("informationToolContent.json");
    taskManager = await new  TaskManager();

    Milestone m1 = new Milestone("Meilenstein", DateTime(2018, 7, 21), "Beschreibung eines Meilensteins");
    taskManager.addMilestone(m1);
    m1.addTask(new Task("Task", TaskState.notCompleted));

    Milestone m2 = new Milestone("Meilenstein", DateTime(2018, 7, 21), "Richtig lange Beschreibung eines Meilensteins Richtig lange Beschreibung eines Meilensteins Richtig lange Beschreibung eines Meilensteins");
    taskManager.addMilestone(m2);
    m2.addTask(new Task("Task", TaskState.notCompleted));



    runApp(BachelorApp());
  }

  class BachelorApp extends StatelessWidget{
    final store = new Store<AppState>(
      appReducer,
      initialState: new AppState(informationToolBuilder.initContent, taskManager, achievementManager, ChallengesLookUp.challenges),
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