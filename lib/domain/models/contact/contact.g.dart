// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      id: json['id'] as int?,
      type: json['contact_type'] == null
          ? ContactType.phone
          : Contact._contactTypeFromJson(json['contact_type'] as String),
      contact: json['contact'] as String? ?? '',
      title: json['title'] as String? ?? '',
      icon: json['icon'] as String? ?? '',
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'id': instance.id,
      'contact_type': Contact._contactTypeToJson(instance.type),
      'contact': instance.contact,
      'title': instance.title,
      'icon': instance.icon,
    };
