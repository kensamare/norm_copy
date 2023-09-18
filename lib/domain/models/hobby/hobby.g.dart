// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hobby.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Hobby _$HobbyFromJson(Map<String, dynamic> json) => Hobby(
      hobbyId: json['id_hobby'] as int?,
      id: json['id'] as int?,
      description: json['description'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
      level: json['level'] as String? ?? '',
      years: json['years'] as int? ?? 1,
    );

Map<String, dynamic> _$HobbyToJson(Hobby instance) => <String, dynamic>{
      'id_hobby': instance.hobbyId,
      'id': instance.id,
      'description': instance.description,
      'title': instance.title,
      'icon': instance.icon,
      'level': instance.level,
      'years': instance.years,
    };
