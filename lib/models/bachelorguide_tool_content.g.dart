// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bachelorguide_tool_content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) => new Content(
    json['type'] as String,
    json['title'] as String,
    json['description'] as String,
    (json['subsections'] as List)
        ?.map((e) =>
            e == null ? null : )
        ?.toList());

abstract class _$ContentSerializerMixin {
  String get type;
  String get title;
  String get description;
  List<Content> get subsections;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'type': type,
        'title': title,
        'description': description,
        'subsections': subsections
      };
}
