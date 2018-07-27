import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/views/containers/bachelor_application_edit_begin_end_date.dart';
import 'package:project_bachelorapplication/views/presentation/bachelor_application_dashboard_timechart.dart';
import 'package:project_bachelorapplication/views/widgets/general_widgets.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';

import 'package:project_bachelorapplication/views/presentation/milestone_tool_milestone_detail_screen.dart';

OverlayVisualizer ov;

class DashboardScreen extends StatelessWidget {
  final Map<String, Milestone> milestones;
  bool rebuild = false;
  int taskAmount = 0;
  final Function(Task, Milestone) onAdd;
  final Function(Task, String, Milestone) onEdit;
  final Function(Task, Milestone) onChangeState;
  final Function(Task, Milestone) onRemoveTask;
  final Function(Milestone) onRemoveMilestone;
  final DateTime begin;
  final DateTime end;

  DashboardScreen(
    this.milestones,
    this.onAdd,
    this.onEdit,
    this.onChangeState,
    this.onRemoveTask,
    this.onRemoveMilestone,
    this.begin,
    this.end,
  );

  @override
  Widget build(BuildContext context) {
    Milestone activeMilestone =
        getActiveMilestone(this.milestones.values.toList());

    return new Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: NavigatorWidget(),
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text("Dashboard"),
        ),
        body: new Container(
          child: ListView(
            children: <Widget>[
              //width: 50.0,
              new Column(
                children: <Widget>[
                  new InkWell(
                    highlightColor: Colors.red,
                    child: new Container(
                      padding:
                          EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      child: new Card(
                        elevation: 5.0,
                        child: getTimeRangeChart(context,
                            this.milestones, activeMilestone, begin, end),
                      ),
                    ),
                    onTap: () {
                      ;
                    },
                  ),
                  new Container(
                    padding:
                        EdgeInsets.all(20.0),
                    child: new Card(
                      elevation: 5.0,
                      child: getActiveMilestoneDetails(context, activeMilestone,
                          onAdd, onChangeState, onEdit, onRemoveTask),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

Container getActiveMilestoneDetails(
    BuildContext context,
    Milestone activeMilestone,
    Function onAdd,
    Function onChangeState,
    Function onEdit,
    Function onRemoveTask) {
  return new Container(
    padding: EdgeInsets.all(10.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(
          "Dein nächster Meilenstein",
          softWrap: true,
          style: TextStyle(
            fontSize: 20.0,
            decorationStyle: TextDecorationStyle.wavy,
          ),
        ),
        new Divider(),
        activeMilestone == null
            ? new Container(
                padding: EdgeInsets.all(10.0),
                child: new Center(
                  child: new Text(
                      "Du hast zurzeit keine zukünftigen Meilensteine. Erstelle einen Meilenstein, um dir die Informationen anzeigen zu lassen"),
                ))
            : new Column(
                children: itemListOf(context, activeMilestone, onAdd,
                    onChangeState, onEdit, onRemoveTask),
              )
      ],
    ),
  );
}

Container getTimeRangeChart(BuildContext context, Map<String, Milestone> milestones,
    Milestone activeMilestone, DateTime begin, DateTime end) {
  TimeSeriesRangeAnnotationChart chart =
      new TimeSeriesRangeAnnotationChart.fromDatas(
          milestones.values.toList(), begin, end);

  return new Container(
    padding: EdgeInsets.all(10.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Row(
          children: <Widget>[
            new Expanded(
              child: new Text(
                "Zeitstrahl",
                softWrap: true,
                style: TextStyle(
                  fontSize: 20.0,
                  decorationStyle: TextDecorationStyle.wavy,
                ),
              ),
            ),
            new IconButton(icon: Icon(Icons.edit),onPressed: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditBeginEndDate()));
            },),
          ],
        ),
        new Divider(),
        new Container(
          height: 130.0,
          child: chart,
        ),
        new Container(
          padding: EdgeInsets.only(top: 15.0),
          child: new ExpansionTile(
            title: new Text("Legende"),
            children: <Widget>[
              new Container(
                padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
                child: new Column(
                  children: <Widget>[
                    getLabelDescription(Icons.label, Colors.green,
                        "Abgeschlossener Meilenstein"),
                    getLabelDescription(Icons.label, Colors.yellow,
                        "Meilensteine mit offenen Aufgaben"),
                    getLabelDescription(Icons.label, Colors.red,
                        "Abgelaufener Meilenstein mit offenen Aufgaben"),
                    getLabelDescription(
                        Icons.label, Colors.grey, "Meilenstein ohne Aufgaben"),
                    getLabelDescription(Icons.label, Colors.black,
                        "Start- und Endtermin der Bachelorarbeit"),
                  ],
                ),
              )
            ],
          ),
        )
      ],
    ),
  );
}

Milestone getActiveMilestone(List<Milestone> milestones) {
  Milestone ret;

  for (Milestone milestone in milestones) {
    if (milestone.date.compareTo(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day)) >=
        0) {
      return milestone;
    }
  }

  return ret;
}

/// Sample time series data type.

class OverlayVisualizer {
  BuildContext context;

  OverlayVisualizer(this.context);

  showAchievementOverlay() {
    Navigator.pushNamed(context, '/achievementOverlay');
  }
}

Row getLabelDescription(IconData icon, Color iconColor, String description) {
  return new Row(
    children: <Widget>[
      new Icon(icon, color: iconColor, size: 15.0),
      new Container(
          padding: EdgeInsets.only(left: 10.0),
          child: new Text(
            description,
            softWrap: true,
          )),
    ],
  );
}
