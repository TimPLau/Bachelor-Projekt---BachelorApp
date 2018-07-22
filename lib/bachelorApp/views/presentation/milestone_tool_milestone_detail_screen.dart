import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/milestone_tool_edit_milestone.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/general_widgets.dart';
import 'package:intl/intl.dart';

class MilestoneDetailScreen extends StatelessWidget {
  final Milestone milestone;
  final Function(Task) onAdd;
  final Function(Task, String) onEdit;
  final Function(Task) onChangeState;
  final Function(Task) onRemoveTask;
  final Function() onRemoveMilestone;

  MilestoneDetailScreen({
    this.milestone,
    this.onAdd,
    this.onEdit,
    this.onChangeState,
    this.onRemoveTask,
    this.onRemoveMilestone,
  });

  @override
  Widget build(BuildContext context) {
    List<Task> children = milestone.tasks.values.toList();

    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        title: new Text(this.milestone.title),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditMilestone(this.milestone)));
              }),
          new IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Navigator.of(context).pop();
                onRemoveMilestone();
              })
        ],
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Container(
              child: new InkWell(
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditMilestone(this.milestone)));
                },
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    buildHeading("Informationen"),
                    buildInfoSectionElement(
                        Icons.local_play, this.milestone.title),
                    buildInfoSectionElement(
                        Icons.description, this.milestone.description),
                    buildInfoSectionElement(
                        Icons.date_range,
                        "${DateFormat.y().format(
                          this.milestone.date)}.${DateFormat.M().format(
                          this.milestone.date)}.${DateFormat.d().format(
                          this.milestone.date)}"),
                  ],
                ),
              ),
            ),
            new Container(
              padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              child: new Divider(),
            ),
            new Container(
              child: buildHeading("Aufgaben"),
            ),
            new TextFormField(
              controller: new TextEditingController(text: ""),
              autofocus: false,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: 'Aufgabentitel',
                  labelText: 'Neue Aufgabe hinzufügen...'),
              validator: (v) {
                return v.trim().isEmpty ? '' : null;
              },
              onFieldSubmitted: (input) {
                onAdd(new Task(input, TaskState.notCompleted));
              },
            ),
            buildList(children),
          ],
        ),
      ),
    );
  }

  Expanded buildList(List<Task> children) {
    return new Expanded(
      child: new ListView.builder(
        itemCount: children.length,
        itemBuilder: (context, index) {
          return Container(
            child: new Row(
              children: <Widget>[
                new Checkbox(
                  value: children[index].taskState == TaskState.completed,
                  onChanged: (bool value) {
                    onChangeState(children[index]);
                  },
                ),
                new Expanded(
                  child: Container(
                    child: new TextFormField(
                      controller: new TextEditingController(
                          text: children[index].title),
                      onFieldSubmitted: (input) {
                        onEdit(children[index], input);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                new Container(
                  child: new IconButton(
                    icon: new Icon(Icons.delete),
                    onPressed: () {
                      onRemoveTask(children[index]);
                    },
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  Container buildInfoSectionElement(IconData iconData, String information) {
    return new Container(
      padding: EdgeInsets.only(top: 10.0, left: 10.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          new Icon(iconData),
          new Expanded(
              child: new Container(
            padding: EdgeInsets.only(left: 20.0),
            child: new Text(
              information,
              softWrap: true,
            ),
          ))
        ],
      ),
    );
  }
}
