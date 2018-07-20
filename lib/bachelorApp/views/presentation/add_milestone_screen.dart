import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/widgets/navigation_widget.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/task_details.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';

class AddingMilestoneScreen extends StatelessWidget {
  static final GlobalKey<FormFieldState<String>> _nameInputField = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _descriptionInputField = GlobalKey<FormFieldState<String>>();

  AddingMilestoneScreen();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text("Meilenstein hinzufügen"),
        ),
        body: new Container(
          padding: new EdgeInsets.all(20.0),
          child: new Form(
            //key: _formKey,
              child: new ListView(
                children: <Widget>[
                  new TextFormField(
                    autofocus: true,
                    key: _nameInputField,
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                        hintText: 'Name des Meilenteins',
                        labelText: 'Meilensteinname'),
                    validator: (v){
                      return v.trim().isEmpty ? "Bitte bennene deinen neuen Meilenstein" : null;
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
                      )
                  ),
                ],
              )),
        ));
  }


  void submit(context) {
    if (_nameInputField.currentState.validate()) {
      StoreProvider
          .of<AppState>(context)
          .dispatch(new AddMilestoneAction(new Milestone(_nameInputField.currentState.value, _descriptionInputField.currentState.value)));
      Navigator.pop(context);
    }
  }
}