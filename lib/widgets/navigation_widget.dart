import 'package:flutter/material.dart';

class NavigatorWidget extends StatelessWidget {
  NavigatorWidget();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 50.0,
        child: new Column(
      children: <Widget>[
        new Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            new Flexible(
                fit: FlexFit.tight,
                child: new Container(
                  //decoration: BoxDecoration(image: DecorationImage(fit: BoxFit.scaleDown, image: AssetImage('assets/files/AppAchievementBadge.png'))),
                  height: 125.0,
                  color: Colors.red,
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                        padding: EdgeInsets.only(bottom: 15.0, left: 15.0),
                        child: new Text("Navigation".toUpperCase(),
                            style: TextStyle(color: Colors.white, fontSize: 26.0)),
                      ),
                    ],
                  ),
                ))
          ],
        ),
        new Expanded(
          child: new ListView(
            children: <Widget>[
              new Divider(),
              new ListTile(
                  title: new Text("Dashboard".toUpperCase()),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.pop(context);
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Meilensteinplanung".toUpperCase()),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.pop(context);

                    Navigator.pushNamed(context, '/milestoneOverview');
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Bachelorarbeit Guide".toUpperCase()),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.pop(context);

                    Navigator.pushNamed(context, '/guide');
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Achievements".toUpperCase()),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.pop(context);

                    Navigator.pushNamed(context, '/achievementOverview');
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Herausforderungen".toUpperCase()),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.pop(context);

                    Navigator.pushNamed(context, '/challengeOverview');
                  }),
              new Divider(),
              new ListTile(
                  title: new Text("Einstellungen".toUpperCase()),
                  onTap: () {
                    while (Navigator.of(context).canPop())
                      Navigator.pop(context);
                  }),
              new Divider(),
            ],
          ),
        )
      ],
    ));
  }
}
