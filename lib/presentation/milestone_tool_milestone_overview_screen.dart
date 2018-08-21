import 'package:flutter/material.dart';

import 'package:project_bachelorapplication/containers/milestone_tool_milestone_details.dart';

import 'package:project_bachelorapplication/widgets/navigation_widget.dart';

import 'package:project_bachelorapplication/models/milestone_tool.dart';



class MilestoneOverviewScreen extends StatelessWidget {

  final List<Milestone> milestones;



  MilestoneOverviewScreen(this.milestones);



  @override

  Widget build(BuildContext context) {

    return new Scaffold(

      drawer: NavigatorWidget(),

      //bottomNavigationBar: NavigatorWidget(),

      appBar: new AppBar(

        backgroundColor: Theme.of(context).bottomAppBarColor,

        title: new Text("Deine Meilensteine".toUpperCase()),

      ),

      floatingActionButton: new FloatingActionButton(

        backgroundColor: Theme.of(context).bottomAppBarColor,

        child: new Icon(Icons.add),

        onPressed: () {

          Navigator.pushNamed(context, "/milestoneOverview/AddingMilestones");

        },

      ),

      body: new Container(

        padding: EdgeInsets.only(top: 10.0),

        child: new ListView.builder(

          itemCount: milestones.length,

          itemBuilder: (context, index) {

            return new Container(

              padding: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),

              child: new Card(



                child: new ListTile(

                  title: new Text(milestones[index].title,),

                  subtitle: new Text(

                    "${milestones[index].date.day}.${milestones[index].date

                        .month}.${milestones[index].date.year}",

                    softWrap: true,

                    style: TextStyle(color: getStateColor(

                        this.milestones[index].getMilestoneState())),



                  ),

                  trailing: new Text(

                    this.milestones[index].tasks.length > 0

                        ? "${this.milestones[index]

                        .getCompletedTasks()

                        .length}/${this.milestones[index].tasks.length}"

                        : "keine Aufgaben",

                    style: TextStyle(color: getStateColor(

                        this.milestones[index].getMilestoneState())),



                  ),

                  leading: Container(

                    child: Icon(

                      Icons.local_play,

                    ),

                  ),

                  onTap: () {

                    Navigator.push(

                        context,

                        MaterialPageRoute(

                            builder: (context) =>

                                MilestoneDetails(milestones[index])));

                  },

                ),

              ),

            );

          },

        ),

      ),

    );

  }

}



Color getStateColor(MilestoneState state) {

  switch (state) {

    case MilestoneState.empty:

      return Colors.grey;

      break;

    case MilestoneState.someTasksNotCompleted:

      return Colors.amber;

      break;

    case MilestoneState.allTasksCompleted:

      return Colors.green;

      break;

    case MilestoneState.outOfDateAndSomeTasksNotCompleted:

      return Colors.red;

      break;

    default: return Colors.black;

  }

}