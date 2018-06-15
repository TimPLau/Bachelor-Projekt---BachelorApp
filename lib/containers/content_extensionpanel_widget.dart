import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:project_bachelorapplication/models/appstate.dart';
import 'package:project_bachelorapplication/models/content.dart';
import 'package:redux/redux.dart';
import 'package:project_bachelorapplication/actions/menuactions.dart';

class ContentExtensionPanelWidget extends StatelessWidget{
  String title;
  String description;
  List<Content> content;

  ContentExtensionPanelWidget(this.content){
    print(content);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: content.length,
        itemBuilder: (BuildContext context, int index) {
          return new ExpansionTile(
            title: new Text(content[index].title),
            children: <Widget>[
              new Text(content[index].description),
            ],
          );
        }
    );
  }
}
