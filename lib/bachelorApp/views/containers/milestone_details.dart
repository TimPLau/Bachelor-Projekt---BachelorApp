import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/bachelorApp/models/TaskManagmentTool/task_tool.dart';
import 'package:project_bachelorapplication/bachelorApp/models/appstate.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/bachelorApp/views/presentation/milestone_detail_screen.dart';


class MilestoneDetails extends StatelessWidget {
  final Milestone milestone;

  MilestoneDetails(this.milestone);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, this.milestone);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return MilestoneDetailScreen(vm.actualMilestone);
      },
    );
  }
}

class _ViewModel {
  final Milestone actualMilestone;

  _ViewModel(
      {this.actualMilestone});

  factory _ViewModel.fromStore(
      Store<AppState> store, Milestone actualMilestone) {
    return _ViewModel(
      actualMilestone: actualMilestone,
    );
  }
}