import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/views/presentation/milestone_tool_add_edit_milestone_screen.dart';


class EditMilestone extends StatelessWidget {

  final Milestone milestone;
  EditMilestone(this.milestone);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, this.milestone);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return AddEditMilestoneScreen(vm.editMilestone, vm.currentMilestones, vm.initialDate, true, milestone);
      },
    );
  }
}

class _ViewModel {
  final Milestone currentMilestone;
  final Function(String, DateTime, String) editMilestone;
  final List<Milestone> currentMilestones;
  List<String> currentMilestonesDates;
  DateTime initialDate;

  _ViewModel(
      {this.currentMilestone, this.editMilestone, this.currentMilestones, this.currentMilestonesDates}){
    this.currentMilestonesDates = getMilestoneDates(this.currentMilestones);
    this.initialDate = getInitialDate();
  }

  factory _ViewModel.fromStore(
      Store<AppState> store, currentMilestone) {
    return _ViewModel(
      editMilestone: (String title, DateTime date, String description) => store.dispatch(new EditMilestoneAction(currentMilestone, title, date, description)),
      currentMilestones: store.state.currentMilestones.values.toList(),
    );
  }

  List<String> getMilestoneDates(List<Milestone> milestones) {
    List<String> retDates;

    for (Milestone m in milestones)
      retDates.add(m.date.toIso8601String());

    return retDates;
  }


  DateTime getInitialDate(){
    DateTime ret = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    this.currentMilestonesDates.sort();
    for(String date in this.currentMilestonesDates) {
      if (date == ret.toIso8601String()) {
        ret = DateTime(ret.year, ret.month, ret.day + 1);
      }
    }
    return ret;

  }
}