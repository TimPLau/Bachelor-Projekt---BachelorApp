import 'package:project_bachelorapplication/bachelorApp/actions/menuactions.dart';
import 'package:project_bachelorapplication/bachelorApp/models/content.dart';

String updateScreenTitle(String current, action){
  if(action is UpdateScreenTitleAction)
    return action.screenTitle;

  return current;
}

Content updatePreviousContent(Content current, action){
  if(action is UpdatePreviousContentAction)
    return action.previousContent;

  return current;
}

Content updateActualContent (Content current, action){
  if(action is UpdateActualContentAction)
    return action.actualContent;

  return current;
}
