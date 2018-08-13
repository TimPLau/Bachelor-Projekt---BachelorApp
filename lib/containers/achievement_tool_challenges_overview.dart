import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/presentation/achievement_tool_challenges_overview_screen.dart';
import 'package:redux/redux.dart';

class ChallengesOverview extends StatelessWidget {
  ChallengesOverview();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, context);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return ChallengesOverviewScreen(vm.challenges);
      },
    );
  }
}

class _ViewModel {
  List<Challenge> challenges;

  _ViewModel({this.challenges});

  factory _ViewModel.fromStore(Store<AppState> store, context) {
    return _ViewModel(
      challenges: store.state.challenges.values.toList(),
    );
  }
}
