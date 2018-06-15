import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/content_extensionpanel_widget.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/containers/content_buttonlist_widget.dart';

class ContentListWidget extends StatelessWidget{
  List<Content> content;

  ContentListWidget(this.content);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: content.length,
        itemBuilder: (BuildContext context, int index) {
          return new ContentButtonListWidget(content);
        }
    );
  }
}