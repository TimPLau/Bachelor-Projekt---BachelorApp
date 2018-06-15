import 'package:project_bachelorapplication/actions/menuactions.dart';
import 'package:project_bachelorapplication/models/content.dart';

List<Content> menuReducer(List<Content> currentMenu, action){
  print("Meep");
  if(action is UpdateContentAction) {
    print("UpdateContentAction");
    currentMenu.replaceRange(0, currentMenu.length, action.menuContent);
  }
  return currentMenu;
}