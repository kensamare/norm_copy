// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Language _$LanguageFromJson(Map<String, dynamic> json) => Language(
      id: json['id'] as int? ?? -1,
      icon: json['icon'] as String? ?? '',
      level: json['level'] == null
          ? LanguageLevel.A1
          : Language._languageLevelFromJson(json['level'] as String),
      title: json['title'] as String? ?? '',
    );

Map<String, dynamic> _$LanguageToJson(Language instance) => <String, dynamic>{
      'id': instance.id,
      'level': Language.languageLevelToJson(instance.level),
      'title': anyStringToNull(instance.title),
      'icon': anyStringToNull(instance.icon),
    };
