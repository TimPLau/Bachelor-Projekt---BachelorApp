import 'package:flutter/cupertino.dart';

import 'package:project_bachelorapplication/models/milestone_tool.dart';

import 'package:charts_flutter/flutter.dart' as charts;



class TimeSeriesRangeAnnotationChart extends StatelessWidget {

  List<charts.Series> seriesList;

  Milestone selectedMilestone;

  final Function(Milestone) onSelectedMilestone;

  final DateTime begin;

  final DateTime end;

  final Map<String, Milestone> milestones;



  TimeSeriesRangeAnnotationChart(

      {this.milestones, this.onSelectedMilestone, this.begin, this.end, this.selectedMilestone}) {

    this.seriesList = new List<charts.Series<Milestone, DateTime>>();

  }



  factory TimeSeriesRangeAnnotationChart.fromData(

      Map<String, Milestone> milestones,

      Function(Milestone) onSelectedMilestone,

      Milestone selectedMilestone,

      DateTime begin,

      DateTime end) {

    return new TimeSeriesRangeAnnotationChart(

      selectedMilestone: selectedMilestone,

      milestones: milestones,

      onSelectedMilestone: onSelectedMilestone,

      begin: begin,

      end: end,

    );

  }



  onSelectionChanged(charts.SelectionModel<DateTime> model) {

    if (model.hasDatumSelection) {

      onSelectedMilestone(model.selectedDatum.first.datum);

    }

  }



  @override

  Widget build(BuildContext context) {



    final children = <Widget>[

      new Expanded(

        child: new charts.TimeSeriesChart(

          buildSeries(),

          animate: true,

          primaryMeasureAxis: new charts.NumericAxisSpec(

              renderSpec: new charts.NoneRenderSpec()),

          domainAxis: new charts.DateTimeAxisSpec(

            tickProviderSpec: new charts.AutoDateTimeTickProviderSpec(

              includeTime: false,

            ),

            tickFormatterSpec: new charts.AutoDateTimeTickFormatterSpec(

              day: new charts.TimeFormatterSpec(

                  format: 'dd/MM', transitionFormat: 'dd/MM'),

              month: new charts.TimeFormatterSpec(

                  noonFormat: 'MM', format: 'dd/MM', transitionFormat: 'dd/MM'),

              year: new charts.TimeFormatterSpec(

                  format: 'dd/MM/yyyy', transitionFormat: 'dd/MM/yyyy'),

            ),

          ),



          behaviors: [

            new charts.RangeAnnotation(

              buildRangeAnotation(milestones.values.toList()),

            ),

          ],

          selectionModels: [

            new charts.SelectionModelConfig(

              listener: onSelectionChanged,

            ),

          ],

          defaultRenderer: new charts.LineRendererConfig(

            includePoints: true,

            includeLine: false,



          ),



          //defaultRenderer: new charts.LineRendererConfig(includePoints: true)

        ),

      )

    ];



    return new Column(

      children: children,

    );

  }



  List<charts.Series<Milestone, DateTime>> buildSeries() {

    List<charts.Series<Milestone, DateTime>> ret = [];



    if (milestones.isNotEmpty) {

      ret.add(new charts.Series<Milestone, DateTime>(

        id: "Milestones",

        colorFn:  (milestone, _) => charts.MaterialPalette.gray.shadeDefault,

        radiusPxFn: (milestone, _) => milestone.id == selectedMilestone.id ? 5.0 : 0.0,

        domainFn: (milestone, _) => milestone.date,

        measureFn: (milestone, _) => 0,

        data: this.milestones.values.toList(),

      ));

    }

    return ret;

  }



  List<charts.RangeAnnotationSegment> buildRangeAnotation(

      List<Milestone> milestones) {

    DateTime startOfRange = this.begin;



    if (milestones.isNotEmpty) {

      startOfRange =

      this.milestones.values.toList().first.date.millisecondsSinceEpoch <=

          this.begin.millisecondsSinceEpoch

          ? milestones.first.date

          : this.begin;

    }



    List<charts.RangeAnnotationSegment> ret = [

      new charts.RangeAnnotationSegment(

        startOfRange,

        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),

        charts.RangeAnnotationAxisType.domain,

        color: charts.MaterialPalette.blue.makeShades(200)[150],

      ),



      new charts.RangeAnnotationSegment(

          this.begin,

          DateTime(this.begin.year, this.begin.month, this.begin.day + 1),

          charts.RangeAnnotationAxisType.domain,

          color: charts.MaterialPalette.black),



      new charts.RangeAnnotationSegment(

          this.end,

          DateTime(this.end.year, this.end.month, this.end.day + 1),

          charts.RangeAnnotationAxisType.domain,

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



  charts.Color _getColorState(Milestone m) {

    if (m.tasks.isEmpty)

      return charts.MaterialPalette.gray.shadeDefault;

    else if (m.tasks.isNotEmpty && m.getNotCompletedTasks().isEmpty)

      return charts.MaterialPalette.green.shadeDefault;

    else if (m.tasks.isNotEmpty && m.date.isBefore(DateTime.now()))

      return charts.MaterialPalette.red.shadeDefault;

    else

      return charts.MaterialPalette.yellow.shadeDefault;

  }

}