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
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
            child: new Card(
              child: new ListTile(
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
                  achievements[type].length > 0
                      ? "${getCompletedAchievementCount(
                      achievements[type])}/${achievements[type].length}"
                      : "",
                ),
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

  String getTitle(AchievementType type) {
    switch (type) {
      case AchievementType.prePhase:
        return "DUMMY";
        break;
      case AchievementType.beginningPhase:
        return "Beginner Achievemnts";
        break;
      case AchievementType.processingPhase:
        return "Performer Achievemnts";
        break;
      case AchievementType.conclusionPhase:
        return "Workaholic Achievemnts";
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
