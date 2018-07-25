import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';

OverlayVisualizer ov;

class DashboardScreen extends StatelessWidget {



  DashboardScreen();

  Future onSelectNotification(String payload, BuildContext context) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }

    Navigator.pushNamed(context, "/achievementOverview");
  }



  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {

        flutterLocalNotificationsPlugin.onSelectNotification = (s) => onSelectNotification(s, context);

        StoreProvider.of<AppState>(context).dispatch(new CheckForAchieveAction(StoreProvider.of<AppState>(context).state.achievedAchievements["AllAchievements"]));

        return new Scaffold(
            drawer: NavigatorWidget(),
            //bottomNavigationBar: NavigatorWidget(),
            appBar: new AppBar(
              backgroundColor: Colors.red,
              title: new Text("Dashboard"),
            ),
            body: new Container(child: new Column(children: <Widget>[])));
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class OverlayVisualizer{
  BuildContext context;

  OverlayVisualizer(this.context);

  showAchievementOverlay(){
    Navigator.pushNamed(context, '/achievementOverlay');
  }
}

class _ViewModel {
  final String actualContent;

  _ViewModel({
    @required this.actualContent,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(actualContent: "");
  }
}
