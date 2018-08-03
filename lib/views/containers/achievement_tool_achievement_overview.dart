import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:path/path.dart';
import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/models/milestone_tool.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/notifications.dart';
import 'package:project_bachelorapplication/views/presentation/achievement_overlay_screen.dart';
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
        return vm.achievedAchievements.isEmpty ? AchievementOverviewScreen(
            vm.categoryAchievements) : AchievementOverlayScreen(
            vm.achievedAchievements, vm.onRecognized);
      },
    );
  }
}

class _ViewModel {
  final List<Achievement> activeAchievements;
  final List<Achievement> achievedAchievements;
  final Function onRecognized;
  Map<AchievementType, List<Achievement>> categoryAchievements;

  _ViewModel(
      {this.activeAchievements, this.achievedAchievements, this.onRecognized}){
   this.categoryAchievements = getAchievementCategories();
  }

  factory _ViewModel.fromStore(Store<AppState> store) {
    return _ViewModel(
        activeAchievements: store.state.achievedAchievements["AllAchievements"].values.toList(),
        achievedAchievements: store.state.achievedAchievements["NotRecognized"].values.toList(),
        onRecognized: () {
            store.dispatch(new ClearAchievedAchievementsAction());
            checkNotification(context);
        },
    );
  }

  Map<AchievementType, List<Achievement>> getAchievementCategories(){
    Map<AchievementType, List<Achievement>> ret = {
      AchievementType.prePhase : [],
      AchievementType.beginningPhase : [],
      AchievementType.processingPhase : [],
      AchievementType.conclusionPhase : [],
      AchievementType.special : [],
    };

    for(Achievement achievement in this.activeAchievements){
      switch(achievement.type){
        case AchievementType.prePhase: ret[AchievementType.prePhase].add(achievement); break;
        case AchievementType.beginningPhase: ret[AchievementType.beginningPhase].add(achievement); break;
        case AchievementType.processingPhase: ret[AchievementType.processingPhase].add(achievement); break;
        case AchievementType.conclusionPhase: ret[AchievementType.conclusionPhase].add(achievement); break;
        case AchievementType.special: ret[AchievementType.special].add(achievement); break;
        default: break;
      }
    }

    return ret;
  }
}
