import 'package:project_bachelorapplication/actions/menuactions.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

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
