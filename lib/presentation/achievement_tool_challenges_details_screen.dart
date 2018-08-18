import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';

class ChallengesDetailsScreen extends StatelessWidget {
  final List<Challenge> challenges;
  final String title;
  final Function changeChallengeState;

  ChallengesDetailsScreen(this.title, this.challenges, this.changeChallengeState);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text(title.toUpperCase()),
        ),
        body: new Container(
          padding: EdgeInsets.only(top: 10.0),
          child: new ListView.builder(
            itemCount: this.challenges.length,
            itemBuilder: (context, index) {
              return new Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 15.0),
                child: new Card(
                  elevation: 1.5,
                  child: new ListTile(
                    leading: ((this.challenges[index].completed)
                        ? Icon(Icons.check_box, color: Colors.green,)
                        : Icon(
                            Icons.check_box_outline_blank,
                    )),
                    title: new Text((index+1).toString() + ". \r" +
                      this.challenges[index].title,
                      softWrap: true,
                    ),
                    onTap: () {
                      this.changeChallengeState(this.challenges[index]);
                    },
                  ),
                ),
              );
            },
          ),
        ));
  }
}
