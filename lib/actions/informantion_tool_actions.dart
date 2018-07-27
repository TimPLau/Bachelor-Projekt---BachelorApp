import 'package:project_bachelorapplication/models/bachelorguide_tool_content.dart';

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