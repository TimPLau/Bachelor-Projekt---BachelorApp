import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';

class AchievementDetailsOverviewScreen extends StatelessWidget {
  final List<Achievement> achievements;
  final String title;

  AchievementDetailsOverviewScreen(this.achievements, this.title);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        //bottomNavigationBar: NavigatorWidget(),
        appBar: new AppBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text(title.toUpperCase()),
        ),
        body: new Container(
          padding: EdgeInsets.only(top: 10.0),
          child: new ListView.builder(
            itemCount: this.achievements.length,
            itemBuilder: (context, index) {
              return new Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                child: new Card(
                  elevation: 5.0,
                  child: new ListTile(
                    leading: getImageState(achievements[index]),
                    title: new Text(
                      (achievements[index].completed == false)
                          ? "???"
                          : this.achievements[index].title,
                      softWrap: true,
                      style: TextStyle(
                          color: achievements[index].completed
                              ? null
                              : Colors.grey),
                    ),
                  ),
                ),
              );
            },
          ),
        ));
  }

}

Image getImageState(Achievement achievement) {
  String path = "";

  if (achievement.completed) {
    switch (achievement.type) {
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
        return null;
        break;
    }
    return new Image.asset(
      path,
      width: 40.0,
    );
  }
  return new Image.asset(
    'assets/files/AppAchievementBadge.png',
    color: Colors.grey,
    width: 40.0,
  );
}