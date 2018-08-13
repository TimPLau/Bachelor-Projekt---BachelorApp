import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/presentation/milestone_tool_add_edit_milestone_screen.dart';
import 'package:redux/redux.dart';

class AddMilestone extends StatelessWidget {
  AddMilestone();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, context);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return AddEditMilestoneScreen(
            vm.addMilestone, vm.currentMilestones, vm.initialDate, false);
      },
    );
  }
}

class _ViewModel {
  final Function(String, DateTime, String) addMilestone;
  final List<Milestone> currentMilestones;
  List<String> currentMilestonesDates;
  DateTime initialDate;
  final BuildContext context;

  _ViewModel({this.addMilestone, this.currentMilestones, this.context}) {
    this.currentMilestonesDates = getMilestoneDates(this.currentMilestones);
    this.initialDate = getInitialDate(currentMilestonesDates);
  }

  factory _ViewModel.fromStore(Store<AppState> store, BuildContext context) {
    return _ViewModel(
      addMilestone: (String title, DateTime date, String description) {
        store.dispatch(new AddMilestoneAction(title, description, date));
        checkAchievementNotification(context);
      },
      currentMilestones: store.state.currentMilestones.values.toList(),
      context: context,
    );
  }
}

List<String> getMilestoneDates(List<Milestone> milestones) {
  List<String> retDates = [];

  for (Milestone m in milestones) retDates.add(m.date.toIso8601String());

  return retDates;
}

DateTime getInitialDate(List<String> milestonesDates) {
  DateTime ret =
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
  milestonesDates.sort();
  for (String date in milestonesDates) {
    if (date == ret.toIso8601String()) {
      ret = DateTime(ret.year, ret.month, ret.day + 1);
    }
  }

  return ret;
}
