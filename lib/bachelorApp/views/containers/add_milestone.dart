import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/actions/task_manager_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/add_milestone_screen.dart';


class AddMilestone extends StatelessWidget {
  AddMilestone();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return AddMilestoneScreen(vm.addMilestone);
      },
    );
  }
}

class _ViewModel {
  final Function addMilestone;

  _ViewModel(
      {this.addMilestone});

  factory _ViewModel.fromStore(
      Store<AppState> store) {
    return _ViewModel(
        addMilestone: (String title, String description) => store.dispatch(new AddMilestoneAction(new Milestone(title, description)))
    );
  }
}