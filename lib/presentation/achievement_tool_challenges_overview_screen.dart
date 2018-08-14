import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/achievement_tool_challenges_details.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class ChallengesOverviewScreen extends StatelessWidget {
  final List<Challenge> challenges;

  ChallengesOverviewScreen(this.challenges);

  @override
  Widget build(BuildContext context) {
    double screenWidth = (MediaQuery.of(context).size.width);

    return new Scaffold(
        drawer: NavigatorWidget(),
        //bottomNavigationBar: NavigatorWidget(),
        appBar: new AppBar(
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text("Herausforderungen".toUpperCase()),
        ),
        body: new Container(
            //padding: EdgeInsets.only(top: 10.0),
            child: new Stack(
          children: <Widget>[
            new Stack(
              children: <Widget>[
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    new Flexible(
                      fit: FlexFit.loose,
                      child: new Container(
                        padding: EdgeInsets.only(right: screenWidth / 2),
                        child: Container(
                          color: Colors.amber,
                          width: screenWidth * 0.065,
                         // height: 80.0 * challenges.length,
                        ),
                      ),
                    )
                  ],
                ),
                new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Flexible(
                      fit: FlexFit.loose,
                      child: new Container(
                        padding: EdgeInsets.only(right: screenWidth / 2),
                        child: Container(
                          color: Colors.red,
                          width: screenWidth * 0.05,
                          // height: 80.0 * challenges.length,
                        ),
                      ),
                    )
                  ],
                ),
                new ListView(
                  children: buildTiles(challenges, context),
                ),
              ],
            )
          ],
        )));
  }

  int getCompletedChallengesCount(List<Challenge> challenges) {
    int completeAchievements = 0;

    for (Challenge challenge in challenges) {
      if (challenge.completed) completeAchievements++;
    }

    return completeAchievements;
  }

  Map<ChallengeType, List<Challenge>> getChallenges(
      List<Challenge> challenges) {
    Map<ChallengeType, List<Challenge>> challengeCategories = {};

    for (Challenge challenge in challenges) {
      if (!challengeCategories.keys.toList().contains(challenge.type)) {
        challengeCategories[challenge.type] = [challenge];
      } else {
        challengeCategories[challenge.type].add(challenge);
      }
    }

    return challengeCategories;
  }

  List<Container> buildTiles(List<Challenge> challenges, BuildContext context) {
    List<Container> listTiles = [];

    Map<ChallengeType, List<Challenge>> challengeCategories =
        getChallenges(challenges);

    for (ChallengeType type in challengeCategories.keys.toList()) {
      if (challengeCategories[type].isNotEmpty) {
        String title = getTitle(type);

        listTiles.add(
          new Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 40.0),
              child: new Stack(
                children: <Widget>[

                  new Container(
                    //padding: EdgeInsets.only(top: 40.0),
                    child: new Card(
                      elevation: 5.0,
                      child: new ListTile(
                        title: new Text(
                          title,
                          softWrap: true,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChallengesDetails(
                                      title, challengeCategories[type])));
                        },
                        trailing: new Text(
                          challengeCategories[type].length > 0
                              ? "${getCompletedChallengesCount(
                              challengeCategories[type])}/${challengeCategories[type]
                              .length}"
                              : "",
                        ),
                      ),
                    ),
                  ),
                ],
              )),
        );
      }
    }

    return listTiles;
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
}
