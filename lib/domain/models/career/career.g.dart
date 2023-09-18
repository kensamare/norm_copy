// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'career.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Career _$CareerFromJson(Map<String, dynamic> json) => Career(
      id: json['id'] as int?,
      position: json['position'] as String? ?? '',
      description: json['description'] as String? ?? '',
      customTitle: json['customTitle'] as String?,
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      to: json['to'] == null ? null : DateTime.parse(json['to'] as String),
    );

Map<String, dynamic> _$CareerToJson(Career instance) => <String, dynamic>{
      'id': instance.id,
      'position': instance.position,
      'description': instance.description,
      'customTitle': instance.customTitle,
      'brand': instance.brand?.toJson(),
      'from': instance.from?.toIso8601String(),
      'to': instance.to?.toIso8601String(),
    };
