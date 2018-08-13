import 'package:project_bachelorapplication/actions/achievement_tool_actions.dart';
import 'package:project_bachelorapplication/models/achievement_tool.dart';

Map<String, Challenge> updateChallenges(Map<String, Challenge> current, action) {

  if (action is ChangeStateChallengeAction) {
    current[action.challenge.title] = new Challenge(action.challenge.title, action.challenge.type, current[action.challenge.title].completed == false ? true : false);
    return current;
  }

  return current;
}
