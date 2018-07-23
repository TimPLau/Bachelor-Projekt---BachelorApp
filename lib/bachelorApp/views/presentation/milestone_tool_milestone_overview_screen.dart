import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/milestone_tool_milestone_details.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/navigation_widget.dart';
import 'package:project_bachelorapplication/bachelorApp/models/milestone_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/milestone_tool_milestone_detail_screen.dart';

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
                milestones[index].description,
                softWrap: true,
              ),
              trailing: new Text(this.milestones[index].tasks.length > 0
                  ? "${this.milestones[index]
                  .getCompletedTasks()
                  .length}/${this.milestones[index].tasks.length}"
                  : ""),
              leading: Container(
                child: Icon(
                  Icons.local_play,
                  color: Colors.black54,
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
