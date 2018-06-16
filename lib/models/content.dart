import 'package:flutter/material.dart';
import 'package:project_bachelorapplication/pages/screen.dart';

class ContentManager{
  List<Content> _content;
  List<Screen> _screens;

  List<Screen> get screens{
    return this._screens;
  }
  ContentManager(){
    _content = <Content>[];
  }

  List<Content> get content{
    return this._content;
  }

  void addContent(Content contentModule){
    _content.add(contentModule);
  }

  List<String> getRoutes(){
    List<String> ret = [];
    List<Content> content = _content;

    ret.addAll(_getRoutes(content, ""));

    return ret;
  }

  List<String> _getRoutes(List<Content> content, String parent){
    List<String> ret = [];

    for(Content c in content) {
      ret.add(parent + "/" + c.title);
      c._path = parent + "/" + c.title;

      if (c.subsections.isNotEmpty)
        ret.addAll(_getRoutes(c.subsections, parent + "/" + c.title));

    }

    return ret;
  }

  @override
  String toString() {
    String ret = "";

    for(Content  content in _content){
      ret = ret + content.toString();
    }

    return ret;
  }
}

class Content{
  String type;
  String title;
  String description;
  List tags;
  List <Content> subsections;
  String _path;

  Content(this.type, this.title, this.description, this.tags, this.subsections);

  set path(String path) {
    this._path = path;
  }

  String get path{
    return this._path;
  }

  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description\nTags: $tags\n";

    for(Content subsection in subsections){
      ret = ret + "\n" + subsection.toString();
    }

    return ret;
  }
}


