import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/navigation_widget.dart';
import 'package:redux/redux.dart';

class MainTaskScreen extends StatelessWidget {
  final Milestone milestone;

  MainTaskScreen(this.milestone);

  @override
  Widget build(BuildContext context) {
    List<Task> children = StoreProvider
        .of<AppState>(context)
        .state
        .taskManager
        .milestones[milestone.id]
        .tasks
        .values
        .toList();

    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {
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
                  MaterialPageRoute(
                      builder: (context) => AddingTaskScreen(this.milestone)),
                );
              }),
          body: new Container(
            child: new ListView.builder(
              itemCount: milestone.tasks.length,
              itemBuilder: (context, index) {
                return new ListTile(
                  title: new Text(children[index].title),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DetailTaskScreen(
                              this.milestone, children[index])),
                    );
                  },
                );
              },
            ),
          ),
        );
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class AddingTaskScreen extends StatelessWidget {
  static final GlobalKey<FormFieldState<String>> _titleInputField =
      GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _descriptionInputField =
      GlobalKey<FormFieldState<String>>();
  final Milestone milestone;

  AddingTaskScreen(this.milestone);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text("Aufgabe hinzufügen"),
      ),
      body: new Container(
        padding: new EdgeInsets.all(20.0),
        child: new Form(
          //key: _formKey,
          child: new ListView(
            children: <Widget>[
              new TextFormField(
                autofocus: true,
                key: _titleInputField,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                    hintText: 'Titel der Aufgabe', labelText: 'Aufgabentitel'),
                validator: (v) {
                  return v.trim().isEmpty
                      ? "Bitte bennene deine neue Aufgabe"
                      : null;
                },
              ),
              new TextFormField(
                key: _descriptionInputField,
                keyboardType: TextInputType.multiline,
                decoration: new InputDecoration(
                    hintText: 'Beschreibung',
                    labelText: 'Beschreibung (optional)'),
              ),
              new FittedBox(
                fit: BoxFit.contain,
                child: new ButtonBar(
                  children: <Widget>[
                    new RaisedButton(
                      child: new Text("Abbrechen"),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    new RaisedButton(
                      child: new Text("Annehmen"),
                      onPressed: () {
                        submit(context);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void submit(context) {
    if (_titleInputField.currentState.validate()) {
      StoreProvider.of<AppState>(context).dispatch(new AddTaskAction(
          this.milestone,
          new Task(_titleInputField.currentState.value, TaskState.notCompleted,
              _descriptionInputField.currentState.value)));
      Navigator.pop(context);
    }
  }
}

TaskState state = TaskState.notCompleted;

class DetailTaskScreen extends StatelessWidget {
  final Task task;
  final Milestone milestone;

  DetailTaskScreen(this.milestone, this.task);



  @override
  Widget build(BuildContext context) {

    return new StoreConnector(
        builder: (BuildContext context, _ViewModel vm) {

    List<Task> children = StoreProvider
        .of<AppState>(context)
        .state
        .taskManager
        .milestones[milestone.id]
        .tasks[task.id]
        .tasks
        .toList();

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text(this.task.title),
        ),
        body: new Container(
          padding: EdgeInsets.all(12.0),
          child: new Column(
            children: <Widget>[
              new Text(this.task.description),
              new TextFormField(
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: new InputDecoration(
                    hintText: 'Titel der Aufgabe', labelText: 'Aufgabentitel'),
                validator: (v) {
                  return v.trim().isEmpty ? '' : null;
                },
                onFieldSubmitted: (input) {
                  StoreProvider.of<AppState>(context).dispatch(
                      new AddSubTaskAction(this.milestone, this.task,
                          new Task(input, TaskState.notCompleted)));
                },
              ),
              new Expanded(
                child: new ListView.builder(
                  itemCount: children.length,
                  itemBuilder: (context, index) {
                    return new CheckboxListTile(

                      value: state == TaskState.completed,

                      onChanged: (bool value) {
                        StoreProvider.of<AppState>(context).dispatch(
                            new ChangeStateAction(this.milestone, this.task,
                                this.task.tasks[index]));

                        state = StoreProvider
                            .of<AppState>(context)
                            .state
                            .taskManager
                            .milestones[milestone.id]
                            .tasks[task.id]
                            .tasks[index]
                            .taskState;
                      },
                      title: new Text(children[index].title),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  },
      converter: _ViewModel.fromStore,
    );

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
