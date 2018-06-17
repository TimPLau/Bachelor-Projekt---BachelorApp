import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';

class AppState {
  String actualScreenTitle;
  String actualPath;
  String prevPath;
  Content previousContent;
  Content actualContent;
  //List<Content> actualContent;

  AppState(this.actualScreenTitle, this.previousContent, this.actualContent);

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