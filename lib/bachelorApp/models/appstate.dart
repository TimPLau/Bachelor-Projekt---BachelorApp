import 'package:project_bachelorapplication/bachelorApp/models/content.dart';

class AppState {
  Content previousContent;
  Content actualContent;

  AppState(this.previousContent, this.actualContent);

  @override
  String toString() {
    String ret = "";

    if(previousContent != null){
      ret += "Previous : " + previousContent.title + "\n";
    }

    for(Content c in actualContent.subsections){
      ret += "Actual : " + c.title + "\n";
    }

    return ret;
  }

}