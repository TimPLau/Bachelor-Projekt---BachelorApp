import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'bachelorguide_tool_content.g.dart';

class InformationToolContentBuilder {
  Content rootContent;

  InformationToolContentBuilder();

  generateContent(String jsonFile) {
    this.rootContent = new Content("", "INIT", "", []);

    if(jsonFile != null) {
      for (dynamic jsonContentModule in json.decode(jsonFile)) {
        Content content = new Content(
          jsonContentModule["type"],
          jsonContentModule["title"],
          jsonContentModule["description"],
          _loadInformation(jsonContentModule["subsections"]),
        );

        rootContent.subsections.add(content);
      }
    }


  }

  List<Content> _loadInformation(List<dynamic> subsections) {
    List<Content> ret = [];

    for (dynamic subsection in subsections) {
      Content content = new Content(
        subsection["type"],
        subsection["title"],
        subsection["description"],
        _loadInformation(subsection["subsections"]),
      );
      ret.add(content);
    }

    return ret;
  }
}

@JsonSerializable()
class Content extends Object with _$ContentSerializerMixin{
  String type;
  String title;
  String description;
  List<Content> subsections = [];

  Content(this.type, this.title, this.description, this.subsections);


  @override
  String toString() {
    String ret = "Title: $title\nDescription: $description";

    for (Content subsection in subsections) {
      ret = ret + "\n" + subsection.toString();
    }

    return ret;
  }

  //factory Challenge.fromJson(Map<String, dynamic> json) => _$ChallengeFromJson(json);

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  //Map<String, dynamic>  toJson() => {'type' : type, 'title' : title, 'description' : description, '_subsections' : _subsections};

}
