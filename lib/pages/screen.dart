import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';
import 'package:project_bachelorapplication/containers/content_list_widget.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/containers/content_extensionpanel_widget.dart';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/content_buttonlist_widget.dart';
import 'package:project_bachelorapplication/models/appstate.dart';


class Screen extends StatelessWidget{
  //List<Content> contentSections;
  String title;
  List<Content> content;
  StatelessWidget widget;

  Screen(this.title, this.content){
   if(this.content[0].type == "ButtonListWidget") {
     print(this.content[0].type);
     this.widget = new ContentButtonListWidget(this.content);
   }
   if(this.content[0].type == "ExtensionPanelWidget") {
     print(this.content[0].type);
     this.widget = new ContentExtensionPanelWidget(this.content);
   }
  }

  @override
  Widget build(BuildContext context) {

    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.red,
          title: new Text(this.title),
        ),
        body: new Container(
            child: new Column(
                children: <Widget>[
                  new Flexible(
                    child: widget,
                  ),
                ]
            )
        )
    );
  }

}