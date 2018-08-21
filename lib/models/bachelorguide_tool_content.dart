import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'bachelorguide_tool_content.g.dart';


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
