import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

class AddTaskScreen extends StatelessWidget {
  static final GlobalKey<FormFieldState<String>> _titleInputField =
  GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _descriptionInputField =
  GlobalKey<FormFieldState<String>>();

  final Milestone milestone;
  final Function(String, String) addTask;

  AddTaskScreen(this.milestone, this.addTask);

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
      this.addTask(_titleInputField.currentState.value, _descriptionInputField.currentState.value);
      Navigator.pop(context);
    }
  }
}