import 'package:project_bachelorapplication/bachelorApp/models/InformationTool/information_tool.dart';

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