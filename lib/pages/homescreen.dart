import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/containers/content_list_widget.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:project_bachelorapplication/containers/content_extensionpanel_widget.dart';
import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/containers/content_buttonlist_widget.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';
import 'package:project_bachelorapplication/pages/screen.dart';
import 'package:project_bachelorapplication/models/content.dart';

class HomeScreen extends StatelessWidget{
  //List<Content> content;
  List<Content> content;
  String title;

  HomeScreen(this.title, this.content);

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
              child: new ContentButtonListWidget(content),
            ),
        ]
      )
      )
    );
  }

}