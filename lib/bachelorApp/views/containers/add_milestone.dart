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
        return AddMilestoneScreen(vm.addMilestone, vm.currentMilestones, vm.initialDate);
      },
    );
  }
}

class _ViewModel {
  final Function(String, DateTime, String) addMilestone;
  final List<Milestone> currentMilestones;
  final List<String> currentMilestonesDates;
  DateTime initialDate;

  _ViewModel(
      {this.addMilestone, this.currentMilestones, this.currentMilestonesDates}){
    this.initialDate = getInitialDate();
  }

  factory _ViewModel.fromStore(
      Store<AppState> store) {
    return _ViewModel(
        addMilestone: (String title, DateTime date, String description) => store.dispatch(new AddMilestoneAction(new Milestone(title, date, description))),
        currentMilestones: store.state.taskManager.milestones.values.toList(),
        currentMilestonesDates: store.state.taskManager.getMilestoneDates(),
    );
  }


  DateTime getInitialDate(){
    DateTime ret = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    this.currentMilestonesDates.sort();
    for(String date in this.currentMilestonesDates)
      if(date == ret.toIso8601String()){
        ret = DateTime(ret.year, ret.month, ret.day+1);
      }
    return ret;

    }
}