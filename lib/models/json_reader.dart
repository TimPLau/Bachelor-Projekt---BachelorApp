import 'dart:convert' as JSON;
import 'package:project_bachelorapplication/models/content.dart';

class JSONReader {
  //bool _fileExists = false;
  List<dynamic> _jsonContent;
  ContentManager _contentManager;
  //Content initContent;

  JSONReader (jsonCode){
    _jsonContent = JSON.jsonDecode(jsonCode);

    //print(initContent.subsections);

    //this.contentManager.addContent(initContent);
  }



}