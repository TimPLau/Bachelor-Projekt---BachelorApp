import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/navigation_widget.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';

class MilestoneOverviewScreen extends StatelessWidget {
  final String title;

  MilestoneOverviewScreen(this.title);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      builder: (BuildContext context, _ViewModel vm) {
        List<Milestone> children = StoreProvider
            .of<AppState>(context)
            .state
            .taskManager
            .milestones
            .values
            .toList();

        return new Scaffold(
            drawer: NavigatorWidget(),
            appBar: new AppBar(
              backgroundColor: Colors.red,
              title: new Text(this.title),
            ),
            floatingActionButton: new FloatingActionButton(
                child: new Icon(Icons.add),
                onPressed: () {
                  Navigator.pushNamed(
                      context, "/milestoneOverview/AddingMilestones");
                }),
            body: new Container(
                child: new ListView.builder(
                    itemCount: children.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                          title: new Text(children[index].title),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainTaskScreen(children[index]))
                            );
                          });
                    })));
      },
      converter: _ViewModel.fromStore,
    );
  }
}

class AddingMilestoneScreen extends StatelessWidget {
  static final GlobalKey<FormFieldState<String>> _nameInputField = GlobalKey<FormFieldState<String>>();
  static final GlobalKey<FormFieldState<String>> _descriptionInputField = GlobalKey<FormFieldState<String>>();

  AddingMilestoneScreen();

  @override
  Widget build(BuildContext context) {
        print("Cool");
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
                      return v.trim().isEmpty ? "Bitte bennene deinen Meilenstein" : null;
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

class MainTaskScreen extends StatelessWidget {
  final Milestone milestone;
  MainTaskScreen(this.milestone);

  @override
  Widget build(BuildContext context) {
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
                  Navigator.pushNamed(
                      context, "/milestoneOverview/AddingMilestones");
                }),
            body: new Container(
                child: new ListView.builder(
                    itemCount: milestone.activeTasks.length,
                    itemBuilder: (context, index) {
                      return new ListTile(
                          title: new Text(milestone.activeTasks[index].title),
                          );
                    })));
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
