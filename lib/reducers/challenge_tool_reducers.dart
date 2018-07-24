import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/actions/milestone_tool_actions.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';
import 'package:project_bachelorapplication/achievement_tool_datas.dart';

Map<String, Challenge> updateChallenges(Map<String, Challenge> current, action) {

  if (action is ChangeStateChallengeAction) {
    current[action.challenge.title].changeState();
    return current;
  }

  return current;
}
