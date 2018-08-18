import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/presentation/achievement_tool_achievement_details_overview_screen.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class AchievementOverviewScreen extends StatelessWidget {
  final Map<AchievementType, List<Achievement>> achievements;

  AchievementOverviewScreen(this.achievements);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: NavigatorWidget(),
        //bottomNavigationBar: NavigatorWidget(),
        appBar: new AppBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text("Achievements".toUpperCase()),
        ),
        body: new Container(
          padding: EdgeInsets.only(top: 10.0),
          child: new ListView(
            children: buildTiles(achievements, context),
          ),
        ));
  }

  List<Container> buildTiles(
      Map<AchievementType, List<Achievement>> achievements,
      BuildContext context) {
    List<Container> listTiles = [];

    for (AchievementType type in achievements.keys.toList()) {
      if (achievements[type].isNotEmpty) {
        String title = getTitle(type);
        listTiles.add(
          new Container(
            height: 100.0,
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
            child: new Card(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new ListTile(
                    leading: getImage(type),
                    title: new Text(
                      title,
                      softWrap: true,
                    ),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AchievementDetailsOverviewScreen(
                                      achievements[type], title)));
                    },
                    trailing: new Text(
                      "${getCompletedAchievementCount(
                          achievements[type])}/${achievements[type].length}",
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }

    return listTiles;
  }

  int getCompletedAchievementCount(List<Achievement> achievements) {
    int completeAchievements = 0;

    for (Achievement achievement in achievements) {
      if (achievement.completed) completeAchievements++;
    }

    return completeAchievements;
  }

  Image getImage(AchievementType type) {
    String path = "";

    switch (type) {
      case AchievementType.prePhase:
        path = 'assets/files/LowAchievementBadge.png';
        break;
      case AchievementType.beginningPhase:
        path = 'assets/files/LowAchievementBadge.png';
        break;
      case AchievementType.processingPhase:
        path = 'assets/files/MedAchievementBadge.png';
        break;
      case AchievementType.conclusionPhase:
        path = 'assets/files/HighAchievementBadge.png';
        break;
      case AchievementType.special:
        path = 'assets/files/AppAchievementBadge.png';
        break;
      default:
        return new Image.asset(
          'assets/files/AppAchievementBadge.png',
          color: Colors.grey,
          width: 40.0,
        );
        break;
    }

    return new Image.asset(
      path,
      width: 60.0,
    );
  }

  String getTitle(AchievementType type) {
    switch (type) {
      case AchievementType.prePhase:
        return "DUMMY";
        break;
      case AchievementType.beginningPhase:
        return "Planner Achievements";
        break;
      case AchievementType.processingPhase:
        return "Goal-Hunter Achievements";
        break;
      case AchievementType.conclusionPhase:
        return "High-Level Achievements";
        break;
      case AchievementType.special:
        return "App Achievements";
        break;
      default:
        return null;
        break;
    }
  }
}
