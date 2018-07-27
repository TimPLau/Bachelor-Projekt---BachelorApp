import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/views/containers/milestone_tool_edit_milestone.dart';
import 'package:project_bachelorapplication/views/widgets/general_widgets.dart';
import 'package:intl/intl.dart';

class MilestoneDetailScreen extends StatelessWidget {
  final Milestone milestone;
  final Function(Task, Milestone) onAdd;
  final Function(Task, String, Milestone) onEdit;
  final Function(Task, Milestone) onChangeState;
  final Function(Task, Milestone) onRemoveTask;
  final Function(Milestone) onRemoveMilestone;

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
                  onRemoveMilestone(this.milestone);
                })
          ],
        ),
        body: new Container(
          padding: EdgeInsets.all(20.0),
          child: new ListView(
              children: itemListOf(context, this.milestone, onAdd,
                  onChangeState, onEdit, onRemoveTask)),
        ));
  }
}

Container buildInfoSectionElement(IconData iconData, String information) {
  return new Container(
    //padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
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

List<Widget> itemListOf(
    BuildContext context,
    Milestone milestone,
    Function onAdd,
    Function onChangeState,
    Function onEdit,
    Function onRemoveTask) {
  List<Widget> ret = [];

  List<Widget> taskTiles = [
    new Container(
      padding: EdgeInsets.only(top: 25.0),
    )
  ];
  milestone.tasks.forEach((s, t) => taskTiles
      .add(toListTaskTile(t, onChangeState, onEdit, onRemoveTask, milestone)));

  ret.addAll([
    new InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => EditMilestone(milestone)));
      },
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

              buildHeading("Informationen"),
              buildInfoSectionElement(Icons.local_play, milestone.title),
              milestone.description.isEmpty
                  ? new Text("")
                  : buildInfoSectionElement(
                      Icons.description, milestone.description),
              buildInfoSectionElement(
                  Icons.date_range,
                  "${DateFormat.d().format(
                    milestone.date)}.${DateFormat.M().format(
                    milestone.date)}.${DateFormat.y().format(
                    milestone.date)}"),


        ],
      ),
    ),
    new Container(
      padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: new Divider(),
    ),
    new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
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
          onFieldSubmitted: (input) {
            onAdd(new Task(input, TaskState.notCompleted), milestone);
          },
        ),
        new ExpansionTile(
          title: new Text("Aufgaben"),
          children: taskTiles,
        ),
      ],
    )
  ]);

  return ret;
}

Container toListTaskTile(Task t, Function onChangeState, Function onEdit,
    Function onRemoveTask, Milestone milestone) {
  return new Container(
    child: new Row(
      children: <Widget>[
        new Checkbox(
          value: t.taskState == TaskState.completed,
          onChanged: (bool value) {
            onChangeState(t, milestone);
          },
        ),
        new Expanded(
          child: Container(
            child: new TextFormField(
              controller: new TextEditingController(text: t.title),
              onFieldSubmitted: (input) {
                onEdit(t, input, milestone);
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
              onRemoveTask(t, milestone);
            },
          ),
        )
      ],
    ),
  );
}
