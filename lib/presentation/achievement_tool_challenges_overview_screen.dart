import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/achievement_tool_challenges_details.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class ChallengesOverviewScreen extends StatelessWidget {
  final List<Challenge> challenges;

  ChallengesOverviewScreen(this.challenges);

  @override
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: NavigatorWidget(),
        //bottomNavigationBar: NavigatorWidget(),
        appBar: new AppBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text("Herausforderungen".toUpperCase()),
        ),
        body: new Container(
          padding: EdgeInsets.only(top: 10.0),
          child: new ListView(
            children: buildTiles(challenges, context),
          ),
        ));
  }

  List<Container> buildTiles(
      List<Challenge> challenges,
      BuildContext context) {
    List<Container> listTiles = [];

    Map<ChallengeType, List<Challenge>> challengeCategories = getChallenges(challenges);

    for (ChallengeType type in challengeCategories.keys.toList()) {
      if (challengeCategories[type].isNotEmpty) {
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
                              ChallengesDetails(
                                  title, challengeCategories[type])));
                },
                trailing: new Text(
                  challengeCategories[type].length > 0
                      ? "${getCompletedChallengesCount(
                      challengeCategories[type])}/${challengeCategories[type].length}"
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

  int getCompletedChallengesCount(List<Challenge> challenges) {
    int completeAchievements = 0;

    for (Challenge challenge in challenges) {
      if (challenge.completed) completeAchievements++;
    }

    return completeAchievements;
  }

  String getTitle(ChallengeType type) {
    switch (type) {
      case ChallengeType.beginningPhase:
        return "Anfangsphase";
        break;
      case ChallengeType.processingPhase:
        return "Bearbeitungsphase";
        break;
      case ChallengeType.conclusionPhase:
        return "Abschlussphase";
        break;
      default:
        return null;
        break;
    }
  }

  Map<ChallengeType, List<Challenge>> getChallenges(List<Challenge> challenges){
    Map<ChallengeType, List<Challenge>> challengeCategories = {};

    for(Challenge challenge in challenges){

      if(!challengeCategories.keys.toList().contains(challenge.type)) {
        challengeCategories[challenge.type] = [challenge];
      } else {
        challengeCategories[challenge.type].add(challenge);
      }

    }

    return challengeCategories;

  }

}
