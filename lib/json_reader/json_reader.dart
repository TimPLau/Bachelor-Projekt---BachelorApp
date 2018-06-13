import 'dart:convert' as JSON;
import 'package:project_bachelorapplication/content/content.dart';

class JSONReader {
  bool _fileExists = false;
  List<dynamic> jsonContent;
  List<ContentModule> _content;
  ContentManager contentManager;

  JSONReader (jsonCode){
    jsonContent = JSON.jsonDecode(jsonCode);
    _content = new List<ContentModule>();
    loadContent();
  }

  List<ContentModule> get content{
    return this._content;
  }

  void loadContent(){
    contentManager = new ContentManager();

    for(dynamic jsonContentModule in jsonContent){
      contentManager.addContentModule(new ContentModule(
          jsonContentModule["title"],
          jsonContentModule["description"],
          jsonContentModule["tags"], loadSubsections(
          jsonContentModule["subsections"])
      ));

    }
  }

  List<ContentSection> loadSubsections(List<dynamic> subsections){
    List<ContentSection> ret = [];

    for(dynamic subsection in subsections){
      ret.add(new ContentSection(
          subsection["title"],
          subsection["description"],
          subsection["tags"],
          loadSubsections(subsection["subsections"])
      ));

    }
    return ret;
  }

}