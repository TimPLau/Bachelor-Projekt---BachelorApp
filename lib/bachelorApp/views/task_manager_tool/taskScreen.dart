import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/navigation_widget.dart';
import 'package:redux/redux.dart';

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
                      context, "/milestoneOverview/AddingTask");
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