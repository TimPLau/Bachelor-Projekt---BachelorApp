// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bachelorguide_tool_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => new Content(
    json['id'] as String,
    json['type'] as String,
    json['title'] as String,
    json['description'] as String,
    (json['subsections'] as List<String>)
        ?.map((e) =>
            e == null ? null : e)
        ?.toList());

abstract class _$ContentSerializerMixin {
  String id;
  String get type;
  String get title;
  String get description;
  List<String> get subsections;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id' : id,
        'type': type,
        'title': title,
        'description': description,
        'subsections': subsections
      };
}
