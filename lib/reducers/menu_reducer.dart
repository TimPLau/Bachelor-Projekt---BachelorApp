import 'package:project_bachelorapplication/actions/menuactions.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

String updateScreenTitle(String current, UpdateScreenTitleAction action){
  if(action is UpdateScreenTitleAction)
    return action.screenTitle;

  return current;
}

String updateScreenPath(String current, UpdateScreenPathAction action){
  if(action is UpdateScreenPathAction)
    return action.screenPath;

  return current;
}

List<Content> updateScreenContent(List<Content> current, UpdateScreenContentAction action){
  if(action is UpdateScreenContentAction)
    return action.screenContent;

  return current;
}