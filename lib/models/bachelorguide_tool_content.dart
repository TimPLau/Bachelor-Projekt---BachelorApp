import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'bachelorguide_tool_content.g.dart';

class InformationToolContentBuilder {
  Map<String, Content> content;

  InformationToolContentBuilder();

  generateContent(String jsonFile) {

    Content initContent = new Content("INIT_ID", "", "INIT", "", []);
    this.content = {initContent.id : initContent};

    if(jsonFile != null) {
      for (dynamic jsonContentModule in json.decode(jsonFile)) {

        Content c = new Content(
            jsonContentModule["id"],
            jsonContentModule["type"],
            jsonContentModule["title"],
            jsonContentModule["description"],
            jsonContentModule["subsections"].cast<String>()
        );

        if(jsonContentModule["id"].toString().contains("ROOT_"))
          initContent.subsections.add(c.id);

        content[c.id] = c;
      }
    }

  }


/* List<Content> _loadInformation(List<dynamic> subsections) {
    List<Content> ret = [];

    for (dynamic subsection in subsections) {
      Content content = new Content(
        subsection["id"],
        subsection["type"],
        subsection["title"],
        subsection["description"],
        _loadInformation(subsection["subsections"]),
      );
      ret.add(content);
    }

    return ret;
  }*/
}

@JsonSerializable()
class Content extends Object with _$ContentSerializerMixin{
  String id;
  String type;
  String title;
  String description;
  List<String> subsections = [];

  Content(this.id, this.type, this.title, this.description, this.subsections);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

}
