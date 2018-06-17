import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/pages/screen.dart';

class UpdateScreenTitleAction{
  String screenTitle;

  UpdateScreenTitleAction(this.screenTitle);
}

class UpdatePreviousContentAction{
  Content previousContent;

  UpdatePreviousContentAction(this.previousContent);
}

class UpdateActualContentAction{
  Content actualContent;

  UpdateActualContentAction(this.actualContent);
}

class UpdateScreenPathAction{
  String actualScreenPath;
  String previousScreenPath;


  UpdateScreenPathAction(this.actualScreenPath, this.previousScreenPath);
}

class UpdatePreviousScreenPathAction{
  String previousScreenPath;

  UpdatePreviousScreenPathAction(this.previousScreenPath);
}

class LoadActualContentAction{
  Content content;

  LoadActualContentAction(this.content);
}
