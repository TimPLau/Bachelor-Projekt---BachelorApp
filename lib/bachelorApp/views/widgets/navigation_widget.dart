import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:redux/redux.dart';



class NavigatorWidget extends StatelessWidget {
  NavigatorWidget();



  @override
  Widget build(BuildContext context) {
   /* return new BottomNavigationBar(
      onTap: Navigator.of(context).pushNamed(pagesRouteFactories.keys.toList()[routeName]),
      fixedColor: Colors.red,
      items: [
        new BottomNavigationBarItem(
          icon: Icon(Icons.dashboard),
          title: new Text("Dashboard"),
        ),

        new BottomNavigationBarItem(
          icon: Icon(Icons.help),
          title: new Text("Guide"),
        ),

        new BottomNavigationBarItem(
          icon: Icon(Icons.local_play),
          title: new Text("Aufgabenplanung"),
        ),

        new BottomNavigationBarItem(
          icon: Icon(Icons.star),
          title: new Text("Herausforderungen"),
        ),
      ],
    );*/


    return Drawer(
          child: new ListView(
          children: <Widget>[
            new ListTile(
                title: new Text("Dashboard"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                }
            ),
            new ListTile(
                title: new Text("Meilensteinplanung"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/milestoneOverview');
                }
            ),
            new ListTile(
                title: new Text("Bachelorarbeit Guide"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/guide');
                }
            ),
            new ListTile(
                title: new Text("Herausforderungen"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/challenges');
                }
            ),
            new ListTile(
                title: new Text("Achievements"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/achievements');
                }
            ),
            new ListTile(
                title: new Text("Einstellungen"),
                onTap: () {
                  Navigator.pushNamedAndRemoveUntil(context, '/', ModalRoute.withName('/'));
                  Navigator.pushNamed(context, '/settings');
                }
            ),
          ],
        ),
        );
  }
}
