import 'dart:convert' as JSON;
import 'package:project_bachelorapplication/models/content.dart';

class JSONReader {
  bool _fileExists = false;
  List<dynamic> _jsonContent;
  ContentManager _contentManager;

  JSONReader (jsonCode){
    _jsonContent = JSON.jsonDecode(jsonCode);
    _loadContent();
  }

  ContentManager get contentManager{
    return _contentManager;
  }

  void _loadContent(){
    this._contentManager = new ContentManager();

    for(dynamic jsonContentModule in _jsonContent){
      this._contentManager.addContent(new Content(
          jsonContentModule["type"],
          jsonContentModule["title"],
          jsonContentModule["description"],
          jsonContentModule["tags"],
          loadSubsections(jsonContentModule["subsections"])
      ));

    }
  }

  List<Content> loadSubsections(List<dynamic> subsections){
    List<Content> ret = [];

    for(dynamic subsection in subsections){
      ret.add(new Content(
          subsection["type"],
          subsection["title"],
          subsection["description"],
          subsection["tags"],
          loadSubsections(subsection["subsections"])
      ));
    }
    return ret;
  }

}