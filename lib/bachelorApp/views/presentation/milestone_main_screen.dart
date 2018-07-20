import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/views/task_manager_tool/taskScreen.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:project_bachelorapplication/bachelorApp/views/containers/navigation_widget.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/milestone_detail_screen.dart';

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



class _ViewModel {
  final String actualContent;

  _ViewModel({
    @required this.actualContent,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return new _ViewModel(actualContent: "");
  }
}