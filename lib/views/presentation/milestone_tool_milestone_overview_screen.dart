import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/views/containers/milestone_tool_milestone_details.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/main.dart';
import 'package:project_bachelorapplication/views/widgets/navigation_widget.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/views/presentation/milestone_tool_milestone_detail_screen.dart';

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
        title: new Text("Deine Meilensteine"),
      ),
      floatingActionButton: new FloatingActionButton(
        backgroundColor: Colors.red,
        child: new Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/milestoneOverview/AddingMilestones");
        },
      ),
      body: new Container(
        child: new ListView.builder(
          itemCount: milestones.length,
          itemBuilder: (context, index) {
            return new ListTile(
              title: new Text(milestones[index].title),
              subtitle: new Text(
                "${milestones[index].date.day}.${milestones[index].date.month}.${milestones[index].date.year}",
                softWrap: true,
                style: TextStyle(color: this.milestones[index].getColorState()),
              ),
              trailing: new Text(this.milestones[index].tasks.length > 0
                  ? "${this.milestones[index]
                  .getCompletedTasks()
                  .length}/${this.milestones[index].tasks.length}"
                  : "keine Aufgaben", style: TextStyle(color: this.milestones[index].getColorState()),),
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
            );
          },
        ),
      ),
    );
  }
}
