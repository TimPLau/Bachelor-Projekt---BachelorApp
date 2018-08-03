import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';

class AchievementDetailsOverviewScreen extends StatelessWidget {
  final List<Achievement> achievements;

  AchievementDetailsOverviewScreen(this.achievements);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigatorWidget(),
      //bottomNavigationBar: NavigatorWidget(),
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text("Deine Achievements"),
      ),
      body: new ListView.builder(
        itemCount: this.achievements.length,
        itemBuilder: (context, index) {
          return new Container(
            padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
            child: new Card(
              elevation: 5.0,
              child: new ListTile(
                leading: ((this.achievements[index].completed)
                    ? Icon(Icons.star,
                        color:
                            getAchievementTypeColor(this.achievements[index]))
                    : Icon(
                        Icons.star_border,
                        color:
                            getAchievementTypeColor(this.achievements[index]),
                      )),
                title: new Text(
                  this.achievements[index].title,
                  softWrap: true,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
