import 'package:project_bachelorapplication/actions/informantion_tool_actions.dart';
import 'package:project_bachelorapplication/models/information_tool.dart';


Content updateActualContent (Content current, action){
  if(action is UpdateActualContentAction)
    return action.actualContent;

  return current;
}