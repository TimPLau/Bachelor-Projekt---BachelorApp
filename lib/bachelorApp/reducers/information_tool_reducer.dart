import 'package:project_bachelorapplication/bachelorApp/actions/informantion_tool_actions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';


Content updateActualContent (Content current, action){
  if(action is UpdateActualContentAction)
    return action.actualContent;

  return current;
}
