import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';

class AchievementOverlayScreen extends StatelessWidget {
  final List<Achievement> achievedAchievements;
  final Function() onRecognized;

  AchievementOverlayScreen(this.achievedAchievements, this.onRecognized);

  @override
  Widget build(BuildContext context) {
    return new Container(
      child: new GestureDetector(
        onDoubleTap: () {
          this.onRecognized();
          Navigator.pushNamed(context, '/achievementOverview');
        },
        child: new Container(child: new ListView.builder(
          itemCount: this.achievedAchievements.length,
          itemBuilder: (context, index) {
            return new Card(
              child: new Text(achievedAchievements[index].title),
            );
          },
        ),),
      ),
    );
  }
}
