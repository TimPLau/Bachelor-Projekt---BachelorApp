import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/views/presentation/achievement_tool_achievement_overview_screen.dart';
import 'package:project_bachelorapplication/views/presentation/achievement_tool_challenges_overview_screen.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/views/presentation/milestone_tool_add_edit_milestone_screen.dart';

class AchievementOverview extends StatelessWidget {
  AchievementOverview();

  @override
  Widget build(BuildContext context) {
    return new StoreConnector(
      converter: (Store<AppState> store) {
        return _ViewModel.fromStore(store);
      },
      builder: (BuildContext context, _ViewModel vm) {
        return AchievementOverviewScreen(
            vm.achievements);
      },
    );
  }
}

class _ViewModel {
  List<Achievement> achievements;

  _ViewModel({this.achievements});

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
      achievements: store.state.achievementManager.achievements.values.toList()
    );
  }
}
