import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/views/widgets/general_widgets.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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


  DashboardScreen(this.milestones,
  this.onAdd,
  this.onEdit,
  this.onChangeState,
  this.onRemoveTask,
  this.onRemoveMilestone,);

  @override
  Widget build(BuildContext context) {


    TimeSeriesRangeAnnotationChart chart =
        new TimeSeriesRangeAnnotationChart.fromDatas(
            milestones.values.toList());

    Milestone active = getActiveMilestone(this.milestones.values.toList());
    print(active);

    return new Scaffold(
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
                  active == null ? new Text("") : new Container(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                      child: new Card(
                        child: new Container(
                          padding: EdgeInsets.all(10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            new Text(
                              "Zeitstrahl",
                              softWrap: true,
                              style: TextStyle(
                                fontSize: 22.0,
                                decorationStyle: TextDecorationStyle.wavy,
                              ),
                            ),
                            new Container(
                              height: 200.0,

                              child: milestones.isEmpty
                                  ? new Text("Erstelle einen Meilenstein")
                                  : chart,
                            ),
                            new Container(
                              child: new Text(
                                  "Dein nächster Meilenstein trägt die Bezeichnung ${active.title
                                  .toUpperCase()} und du hast bisher ${ (active
                                  .tasks) }"),
                            )
                          ],
                        ),
                        ),
                      ),

                  ),

                  new Container(
                    padding: EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
                    child: new Card(
                      child: new Container(
                        padding: EdgeInsets.all(10.0),
                        child: new Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            active != null ? Column(children:itemListOf(context, active, onAdd, onChangeState, onEdit, onRemoveTask),) : new Text("")
                          ],
                        ),
                      ),
                    ),

                  ),
                ],
              ),

            ],
          ),
        ));
  }
}


Milestone getActiveMilestone(List<Milestone> milestones) {
  Milestone ret;

  for (Milestone milestone in milestones) {
    if (!milestone.date.difference(DateTime.now()).isNegative) {
      return milestone;
    }
  }

  return ret;
}

class TimeSeriesRangeAnnotationChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;
  int taskAmount;
  int completedTaskAmount;

  final List<Milestone> milestones;

  Map<Milestone, int> cumulatedTaskAmounts;
  Map<Milestone, int> completedTaskAmounts;

  TimeSeriesRangeAnnotationChart({this.milestones}) {
    this.cumulatedTaskAmounts = _getCumulatedTaskAmounts(milestones);
    this.completedTaskAmounts = _getCompletedCumulatedTaskAmounts(milestones);

    this.taskAmount = this.cumulatedTaskAmounts.isNotEmpty
        ? this
            .cumulatedTaskAmounts
            .values
            .toList()[cumulatedTaskAmounts.length - 1]
        : 0;
    this.completedTaskAmount = this.completedTaskAmounts.isNotEmpty
        ? this
            .completedTaskAmounts
            .values
            .toList()[completedTaskAmounts.length - 1]
        : 0;
    this.seriesList = new List<charts.Series<Milestone, DateTime>>();
  }

  factory TimeSeriesRangeAnnotationChart.fromDatas(List<Milestone> milestones) {
    return new TimeSeriesRangeAnnotationChart(
      milestones: milestones,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,

      behaviors: [
        new charts.RangeAnnotation(
          buildRangeAnotation(milestones),
        ),
      ],
      //defaultRenderer: new charts.LineRendererConfig(includePoints: true)
    );
  }

  List<charts.RangeAnnotationSegment> buildRangeAnotation(
      List<Milestone> milestones) {
    List<charts.RangeAnnotationSegment> ret = [
      new charts.RangeAnnotationSegment(
        DateTime(2018, 5, 24),
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        charts.RangeAnnotationAxisType.domain,
        color: charts.MaterialPalette.green.makeShades(200)[100],
      ),
      new charts.RangeAnnotationSegment(DateTime(2018, 8, 24),
          DateTime(2018, 8, 24 + 1), charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.black),
      new charts.RangeAnnotationSegment(DateTime(2018, 5, 24),
          DateTime(2018, 5, 24 + 1), charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.black),
      new charts.RangeAnnotationSegment(
          DateTime(DateTime.now().year, DateTime.now().month,
              DateTime.now().day - 1),
          DateTime(
              DateTime.now().year, DateTime.now().month, DateTime.now().day),
          charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.green.shadeDefault),
    ];

    for (Milestone m in milestones)
      ret.add(new charts.RangeAnnotationSegment(
          DateTime(m.date.year, m.date.month, m.date.day - 1),
          DateTime(m.date.year, m.date.month, m.date.day),
          charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.red.shadeDefault));

    return ret;
  }

  Map<Milestone, int> _getCumulatedTaskAmounts(List<Milestone> milestones) {
    Map<Milestone, int> cumulatedTaskAmounts = {};
    int taskAmount = 0;

    milestones.sort((Milestone m1, Milestone m2) => m1.date.compareTo(m2.date));

    for (Milestone m in milestones) {
      taskAmount += m.tasks.length;
      cumulatedTaskAmounts[m] = taskAmount;
    }

    return cumulatedTaskAmounts;
  }

  Map<Milestone, int> _getCompletedCumulatedTaskAmounts(
      List<Milestone> milestones) {
    Map<Milestone, int> cumulatedTaskAmounts = {};
    int taskAmount = 0;
    int completed = 0;
    milestones.sort((Milestone m1, Milestone m2) => m1.date.compareTo(m2.date));

    for (Milestone m in milestones) {
      for (Task t in m.tasks.values.toList()) {
        completed += t.isCompleted() ? 1 : 0;
      }

      cumulatedTaskAmounts[m] = completed;
    }

    return cumulatedTaskAmounts;
  }
}

/// Sample time series data type.

class OverlayVisualizer {
  BuildContext context;

  OverlayVisualizer(this.context);

  showAchievementOverlay() {
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
