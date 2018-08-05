import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:redux/redux.dart';



class NavigatorWidget extends StatelessWidget {
  NavigatorWidget();



  @override
  Widget build(BuildContext context) {

    return Drawer(
          child: new ListView(
          children: <Widget>[
            new ListTile(
                title: new Text("Dashboard"),
                onTap: () {
                  while(Navigator.of(context).canPop())
                    Navigator.pop(context);

                }
            ),
            new ListTile(
                title: new Text("Meilensteinplanung"),
                onTap: () {
                  while(Navigator.of(context).canPop())
                    Navigator.pop(context);

                  Navigator.pushNamed(context, '/milestoneOverview');
                }
            ),
            new ListTile(
                title: new Text("Bachelorarbeit Guide"),
                onTap: () {
                  while(Navigator.of(context).canPop())
                    Navigator.pop(context);

                  Navigator.pushNamed(context, '/guide');
                }
            ),
            new ListTile(
                title: new Text("Achievements"),
                onTap: () {
                  while(Navigator.of(context).canPop())
                    Navigator.pop(context);

                  Navigator.pushNamed(context, '/achievementOverview');
                }
            ),
            new ListTile(
                title: new Text("Herausforderungen"),
                onTap: () {
                  while(Navigator.of(context).canPop())
                    Navigator.pop(context);

                  Navigator.pushNamed(context, '/challengeOverview');
                }
            ),
            new ListTile(
                title: new Text("Einstellungen"),
                onTap: () {
                  while(Navigator.of(context).canPop())
                    Navigator.pop(context);
                }
            ),
          ],
        ),
        );
  }
}
