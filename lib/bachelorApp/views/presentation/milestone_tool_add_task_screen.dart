/*
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';

class AddTaskScreen extends StatefulWidget {

  //final Task task;
  final Function(String, String) addTask;


  AddTaskScreen(this.addTask);

  @override
  AddTaskScreenForm createState() => new AddTaskScreenForm();
}
class AddTaskScreenForm extends State<AddTaskScreen>{

  static final GlobalKey<FormFieldState<String>> _nameInputField =
  GlobalKey<FormFieldState<String>>();

  static final GlobalKey<FormFieldState<String>> _descriptionInputField =
  GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          actions: <Widget>[
            new FlatButton(
                onPressed: () {
                  submit(context);
                },
                child: new Text(
                  "HINZUFÜGEN",
                  style: TextStyle(color: Colors.white),
                ))
          ],
          backgroundColor: Colors.red,
          title: new Text("Aufgabe hinzufügen"),
        ),
        body: new Container(
          padding: EdgeInsets.all(30.0),
          child: new ListView(
            children: <Widget>[
              new Container(
                child: new TextFormField(
                  autofocus: true,
                  key: _nameInputField,
                  keyboardType: TextInputType.text,
                  decoration: new InputDecoration(
                      hintText: 'Titel der Aufgabe',
                      labelText: 'Aufgabenname'),
                  validator: (v) {
                    return v.trim().isEmpty
                        ? "Bitte bennene deinen neue Aufgabe"
                        : null;
                  },
                ),
              ),
              new Container(
                padding: EdgeInsets.only(top: 40.0),
                child: new TextFormField(
                  key: _descriptionInputField,
                  keyboardType: TextInputType.multiline,
                  decoration: new InputDecoration(
                      hintText: 'Beschreibung',
                      labelText: 'Beschreibung (optional)'),
                ),
              ),
            ],
          ),
        ));

  }

  void submit(context) {
    if (_nameInputField.currentState.validate()) {
      widget.addTask(_nameInputField.currentState.value,
          _descriptionInputField.currentState.value);
      Navigator.pop(context);
    }
  }


}
*/
