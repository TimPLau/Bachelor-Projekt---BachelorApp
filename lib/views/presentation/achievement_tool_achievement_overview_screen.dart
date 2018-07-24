import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';

class AchievementOverviewScreen extends StatelessWidget {
  final List<Achievement> achievements;

  AchievementOverviewScreen(this.achievements);

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
        itemBuilder: (context, index){
          return new ListTile(
            leading: ((this.achievements[index].completed) ? Icon(Icons.star, color: Colors.amber) : Icon(Icons.star_border,)),
            title: new Text(this.achievements[index].title, softWrap: true,),
          );
        },
      ),
    );
  }
}
