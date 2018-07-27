import 'package:flutter/cupertino.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class TimeSeriesRangeAnnotationChart extends StatelessWidget {
  List<charts.Series> seriesList;
  bool animate;
  int taskAmount;
  int completedTaskAmount;

  final DateTime begin;
  final DateTime end;
  final List<Milestone> milestones;

  Map<Milestone, int> cumulatedTaskAmounts;
  Map<Milestone, int> completedTaskAmounts;

  TimeSeriesRangeAnnotationChart({this.milestones, this.begin, this.end}) {
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

  factory TimeSeriesRangeAnnotationChart.fromDatas(List<Milestone> milestones, DateTime begin, DateTime end) {
    return new TimeSeriesRangeAnnotationChart(
      milestones: milestones,
      begin: begin,
      end: end,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: true,

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
        this.begin,
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
        charts.RangeAnnotationAxisType.domain,
        color: charts.MaterialPalette.green.makeShades(200)[150],
      ),

      new charts.RangeAnnotationSegment(this.begin,
          DateTime(this.begin.year, this.begin.month, this.begin.day + 1), charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.black),

      new charts.RangeAnnotationSegment(this.end,
          DateTime(this.end.year, this.end.month, this.end.day + 1), charts.RangeAnnotationAxisType.domain,
          color: charts.MaterialPalette.black),

    ];

    for (Milestone m in milestones) {


      ret.add(new charts.RangeAnnotationSegment(
          DateTime(m.date.year, m.date.month, m.date.day - 1),
          DateTime(m.date.year, m.date.month, m.date.day),
          charts.RangeAnnotationAxisType.domain,
          color: _getColorState(m)));
    }

    return ret;
  }

  charts.Color _getColorState(Milestone m){

    if(m.tasks.isEmpty)
      return charts.MaterialPalette.gray.shadeDefault;
    else if(m.tasks.isNotEmpty && m.getNotCompletedTasks().isEmpty)
      return charts.MaterialPalette.green.shadeDefault;
    else if(m.tasks.isNotEmpty && m.date.isBefore(DateTime.now()))
      return charts.MaterialPalette.red.shadeDefault;
    else
      return charts.MaterialPalette.yellow.shadeDefault;

  }

  Map<Milestone, int> _getCumulatedTaskAmounts(List<Milestone> milestones) {
    Map<Milestone, int> cumulatedTaskAmounts = {};
    int taskAmount = 0;

    for (Milestone m in milestones) {
      taskAmount += m.tasks.length;
      cumulatedTaskAmounts[m] = taskAmount;
    }

    return cumulatedTaskAmounts;
  }

  Map<Milestone, int> _getCompletedCumulatedTaskAmounts(
      List<Milestone> milestones) {
    Map<Milestone, int> cumulatedTaskAmounts = {};
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