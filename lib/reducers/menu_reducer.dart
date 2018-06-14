import 'package:project_bachelorapplication/actions/menuactions.dart';
import 'package:project_bachelorapplication/models/content.dart';

List<ContentModule> menuReducer(List<ContentModule> currentMenu, action){
  if(action is FillMenuAction)
    currentMenu.replaceRange(0, currentMenu.length, action.menuContent);

  return currentMenu;
}