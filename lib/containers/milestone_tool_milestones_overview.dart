import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/presentation/milestone_tool_milestone_overview_screen.dart';
import 'package:redux/redux.dart';

class MilestoneOverview extends StatelessWidget {
  MilestoneOverview();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return MilestoneOverviewScreen(
          vm.currentMilestones,
        );
      },
    );
  }
}

class _ViewModel {
  final List<Milestone> currentMilestones;

  _ViewModel({this.currentMilestones});

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      currentMilestones: store.state.currentMilestones.values.toList(),
    );
  }
}
