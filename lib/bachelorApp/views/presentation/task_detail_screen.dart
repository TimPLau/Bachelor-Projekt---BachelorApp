import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/general_widgets.dart';

class TaskDetailScreen extends StatelessWidget {
  final Task task;
  final Function(Task) onAdd;
  final Function(Task, String) onEdit;
  final Function(Task) onChangeState;
  final Function(Task) onRemove;

  TaskDetailScreen(
      {this.task, this.onAdd, this.onEdit, this.onChangeState, this.onRemove});

  @override
  Widget build(BuildContext context) {
    List<Task> children = task.subTasks.values.toList();
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(this.task.title),
      ),
      body: new Container(
        padding: EdgeInsets.all(20.0),
        child: new Column(
          children: <Widget>[
            buildDescriptionContainer("Beschreibung", this.task.description),
            new TextFormField(
              controller: new TextEditingController(text: ""),
              autofocus: true,
              keyboardType: TextInputType.text,
              decoration: new InputDecoration(
                  hintText: 'Aufgabentitel',
                  labelText: 'Neue Teilaufgabe hinzufügen...'),
              validator: (v) {
                return v.trim().isEmpty ? '' : null;
              },
              onFieldSubmitted: (input) {
                onAdd(new Task(input, TaskState.notCompleted));
              },
            ),
            new Expanded(
              child: new ListView.builder(
                itemCount: children.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: EdgeInsets.only(
                        top: 15.0, bottom: 10.0, left: 5.0, right: 5.0),
                    child: new Row(
                      children: <Widget>[
                        new Checkbox(
                          value:
                              children[index].taskState == TaskState.completed,
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
                                hintText: "asd",
                              ),
                            ),
                          ),
                        ),
                        new Container(
                          child: new IconButton(
                            icon: new Icon(Icons.delete),
                            onPressed: () {
                              onRemove(children[index]);
                            },
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
