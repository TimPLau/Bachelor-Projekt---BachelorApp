import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';


class AchievementOverlayScreen extends StatelessWidget {
  final List<Achievement> achievedAchievements;
  final Function() onRecognized;

  AchievementOverlayScreen(this.achievedAchievements, this.onRecognized);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        leading: new IconButton(icon: new Icon(Icons.arrow_back), onPressed: () {
        this.onRecognized();
        Navigator.of(context).pop;
        }),
        title: new Text("Neue Achievements".toUpperCase()),
        backgroundColor: Theme.of(context).bottomAppBarColor,
      ),

      //bottomNavigationBar: NavigatorWidget(),
      body: new Flex(
        direction: Axis.vertical,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(20.0),
            child: new Column(
              children: <Widget>[
                new Text(
                  "Die folgenden Achievements hast du seit dem letzten Aufruf dieser Seite erlegdigt.\n\nGute Arbeit!\n\nTippe zweimal auf den Bildschirm um deine Achievements zu betrachten oder kehre zum letzten Bildschirm zurück",
                  softWrap: true,
                  textAlign: TextAlign.left,
                ),
                new Divider(),
              ],
            ),
          ),
          new Flexible(
            child: new GestureDetector(
              onDoubleTap: () {
                this.onRecognized();
                Navigator.pushNamed(context, '/achievementOverview');
              },
              child: new Container(
                child: new ListView.builder(
                  itemCount: this.achievedAchievements.length,
                  itemBuilder: (context, index) {
                    return new ListTile(
                      title: new Text(achievedAchievements[index].title),
                      leading: Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
