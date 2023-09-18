// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Education _$EducationFromJson(Map<String, dynamic> json) => Education(
      id: json['id'] as int?,
      faculty: json['faculty'] as String? ?? '',
      title: json['title'] as String? ?? '',
      year: json['year'] as int? ?? 1990,
    );

Map<String, dynamic> _$EducationToJson(Education instance) => <String, dynamic>{
      'id': instance.id,
      'faculty': instance.faculty,
      'title': instance.title,
      'year': instance.year,
    };
