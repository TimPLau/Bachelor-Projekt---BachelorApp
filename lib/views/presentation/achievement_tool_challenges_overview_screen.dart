import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';

class ChallengesOverviewScreen extends StatelessWidget {
  final List<Challenge> challenges;
  final Function(Challenge) changeChallengeState;

  ChallengesOverviewScreen(this.challenges, this.changeChallengeState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavigatorWidget(),
      //bottomNavigationBar: NavigatorWidget(),
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text("Deine Herausforderungen"),
      ),
      body: new ListView.builder(
        itemCount: this.challenges.length,
        itemBuilder: (context, index){

          return new ListTile(
            leading: ((this.challenges[index].completed) ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank,)),
            title: new Text(this.challenges[index].title, softWrap: true,),
            onTap: () {this.changeChallengeState(this.challenges[index]);},

          );
        },
      ),
    );
  }
}
