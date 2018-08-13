import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/bachelor_application_edit_begin_end_date.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/presentation/bachelor_application_dashboard_timechart.dart';
import 'package:project_bachelorapplication/presentation/milestone_tool_milestone_detail_screen.dart';
import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

class DashboardScreen extends StatelessWidget {
  final Map<String, Milestone> milestones;
  final Milestone selectedMilestone;
  final Function(String, Milestone) onAdd;
  final Function(Task, String, Milestone) onEdit;
  final Function(Task, Milestone) onChangeState;
  final Function(Task, Milestone) onRemoveTask;
  final Function(Milestone) onRemoveMilestone;
  final Function(Milestone) onSelectedMilestone;
  final DateTime begin;
  final DateTime end;
  TimeSeriesRangeAnnotationChart chart;

  DashboardScreen(
    this.milestones,
    this.selectedMilestone,
    this.onAdd,
    this.onEdit,
    this.onChangeState,
    this.onRemoveTask,
    this.onRemoveMilestone,
    this.onSelectedMilestone,
    this.begin,
    this.end,
  );

  @override
  Widget build(BuildContext context) {
    Milestone activeMilestone;

    if (selectedMilestone != null) {
      activeMilestone = milestones[selectedMilestone.id] != null
          ? milestones[selectedMilestone.id]
          : getActiveMilestone(this.milestones.values.toList());
    } else {
      activeMilestone = getActiveMilestone(this.milestones.values.toList());
    }
    return new Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        drawer: NavigatorWidget(),
        appBar: new AppBar(
          //backgroundColor: Colors.red,
          backgroundColor: Theme.of(context).bottomAppBarColor,
          title: new Text("Dashboard".toUpperCase()),
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
                        child: getTimeRangeChart(context, this.milestones,
                            activeMilestone, onSelectedMilestone, begin, end),
                      ),
                    ),
                  ),
                  new Container(
                    padding: EdgeInsets.all(20.0),
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

  Container getActiveMilestoneDetails(
      BuildContext context,
      Milestone activeMilestone,
      Function onAdd,
      Function onChangeState,
      Function onEdit,
      Function onRemoveTask) {
    return new Container(
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          new Container(
            padding: EdgeInsets.all(10.0),
            child: activeMilestone != null
                ? new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      new Container(
                          child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          new IconButton(
                              icon: new Icon(Icons.chevron_left),
                              onPressed: () {
                                onSelectedMilestone(getPreviousMilestone(
                                    this.milestones, activeMilestone));
                              }),
                          new Expanded(
                            child: new Text(
                              "Dein Meilenstein",
                              softWrap: true,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 20.0,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                            ),
                          ),
                          new IconButton(
                              icon: new Icon(Icons.chevron_right),
                              onPressed: () {
                                onSelectedMilestone(getNextMilestone(
                                    this.milestones, activeMilestone));
                              }),
                        ],
                      )),
                      new Divider(),
                      new Column(
                        children: itemListOf(context, activeMilestone, onAdd,
                            onChangeState, onEdit, onRemoveTask),
                      )
                      //getMilestoneTasks(onAdd, onChangeState, onEdit,
                      //onRemoveTask, activeMilestone)
                    ],
                  )
                : new Text(
                    "Du hast zurzeit keine zukünftigen Meilensteine. Erstelle einen Meilenstein, um dir die Informationen anzeigen zu lassen"),
          ),
        ],
      ),
    );
  }

  getPreviousMilestone(
      Map<String, Milestone> milestones, Milestone currentMilestone) {
    int indexOfCurrent = milestones.keys.toList().indexOf(currentMilestone.id);

    print(currentMilestone.title);

    if (milestones.length > 1) {
      if (milestones.values.toList().first.id != currentMilestone.id) {
        return milestones.values.toList().elementAt(indexOfCurrent - 1);
      } else {
        return milestones.values.toList().last;
      }
    } else {
      return currentMilestone;
    }
  }

  getNextMilestone(
      Map<String, Milestone> milestones, Milestone currentMilestone) {
    int indexOfCurrent = milestones.keys.toList().indexOf(currentMilestone.id);

    print(currentMilestone.title);

    if (milestones.length > 1) {
      if (milestones.values.toList().last.id != currentMilestone.id) {
        return milestones.values.toList().elementAt(indexOfCurrent + 1);
      } else {
        return milestones.values.toList().first;
      }
    } else {
      return currentMilestone;
    }
  }

  Container getTimeRangeChart(
      BuildContext context,
      Map<String, Milestone> milestones,
      Milestone activeMilestone,
      Function(Milestone) onSelectedMilestone,
      DateTime begin,
      DateTime end) {
    this.chart = new TimeSeriesRangeAnnotationChart.fromData(
        milestones, onSelectedMilestone, activeMilestone, begin, end);

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
              new IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditBeginEndDate()));
                },
              ),
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
                  padding: EdgeInsets.only(
                      top: 10.0, left: 10.0, right: 10.0, bottom: 20.0),
                  child: new Column(
                    children: <Widget>[
                      getLabelDescription(Icons.label, Colors.green,
                          "Abgeschlossener Meilenstein"),
                      getLabelDescription(Icons.label, Colors.yellow,
                          "Zukünftiger Meilensteine mit offenen Aufgaben"),
                      getLabelDescription(Icons.label, Colors.red,
                          "Abgelaufener Meilenstein mit offenen Aufgaben"),
                      getLabelDescription(Icons.label, Colors.grey,
                          "Meilenstein ohne Aufgaben"),
                      getLabelDescription(Icons.label, Colors.black,
                          "Start- und Endtermin der Bachelorarbeit"),
                      getLabelDescription(Icons.label, Colors.blue.shade100,
                          "Abgelaufene Zeit"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Milestone getActiveMilestone(List<Milestone> milestones) {
    for (Milestone milestone in milestones) {
      if (milestone.date.compareTo(DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day)) >=
          0) {
        return milestone;
      }
    }

    return null;
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
