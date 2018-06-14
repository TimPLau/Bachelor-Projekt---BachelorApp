import 'package:project_bachelorapplication/containers/content_list_widget.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/containers/content_extensionpanel_widget.dart';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/content_buttonlist_widget.dart';

class HomeScreen extends StatelessWidget{
  List<ContentModule> contentModules;
  String title;

  HomeScreen(this.contentModules,
              this.title);


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text(this.title),
      ),
      body: Container(
        child: new Center(
          child: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              new ContentButtonListWidget(contentModules),
            ],
          ),
        ),
      ),
    );
  }

}