import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/presentation/achievement_tool_challenges_details_screen.dart';
import 'package:redux/redux.dart';

class ChallengesDetails extends StatelessWidget {
  final String title;
  final List<Challenge> challenges;

  ChallengesDetails(this.title, this.challenges);

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store, context, this.challenges);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return ChallengesDetailsScreen(
            this.title, vm.challenges, vm.changeChallengeState);
      },
    );
  }
}

class _ViewModel {
  Function changeChallengeState;
  List<Challenge> challenges;

  _ViewModel({this.changeChallengeState, this.challenges});

  factory _ViewModel.fromStore(
      Store<AppState> store, context, List<Challenge> categoryChallenges) {
    return _ViewModel(
      challenges: _filterChallenges(store.state.challenges, categoryChallenges),
      changeChallengeState: (Challenge challenge) {
        store.dispatch(new ChangeStateChallengeAction(challenge));
        checkAchievementNotification(context);
      },
    );
  }
}

List<Challenge> _filterChallenges(
    Map<String, Challenge> storeChallenges, List<Challenge> currentChallenges) {
  List<Challenge> ret = [];

  for (Challenge challenge in currentChallenges) {
    if (storeChallenges.keys.toList().contains(challenge.title))
      ret.add(storeChallenges[challenge.title]);
  }

  return ret;
}
