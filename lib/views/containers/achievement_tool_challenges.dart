import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/views/presentation/achievement_tool_achievement_overview_screen.dart';
import 'package:project_bachelorapplication/views/presentation/achievement_tool_challenges_overview_screen.dart';
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
        return ChallengesOverviewScreen(vm.challenges, vm.changeChallengeState);
      },
    );
  }
}

class _ViewModel {
  List<Challenge> challenges;
  Function changeChallengeState;
  BuildContext context;

  _ViewModel({this.challenges, this.changeChallengeState});

  factory _ViewModel.fromStore(Store<AppState> store, context) {
    return _ViewModel(
      challenges: store.state.challenges.values.toList(),
      changeChallengeState: (Challenge challenge) {
        store.dispatch(new ChangeStateChallengeAction(challenge));
        checkNotification(context);
      },
    );
  }
}
