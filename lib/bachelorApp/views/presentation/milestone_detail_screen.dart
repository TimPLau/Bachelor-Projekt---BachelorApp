import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/navigation_widget.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/task_details.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/add_task.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/general_widgets.dart';

class MilestoneDetailScreen extends StatelessWidget {
  final Milestone milestone;

  MilestoneDetailScreen(this.milestone);

  @override
  Widget build(BuildContext context) {
    List<Task> children = milestone.tasks.values.toList();

    return new Scaffold(
      drawer: NavigatorWidget(),
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(this.milestone.title),
      ),
      floatingActionButton: new FloatingActionButton(
          child: new Icon(Icons.add),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddTask(this.milestone)),
            );
          }),
      body: new Container(
          padding: EdgeInsets.all(20.0),
          child: new Column(
        children: <Widget>[
          buildDescriptionContainer("Beschreibung", this.milestone.description),
          new Expanded(child: ListView.builder(
            itemCount: milestone.tasks.length,
            itemBuilder: (context, index) {
              return new ListTile(
                title: new Text(children[index].title),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            TaskDetails(milestone, children[index])),
                  );
                },
              );
            },
          ),
          ),
        ],
      )),
    );
  }
}
