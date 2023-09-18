// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Portfolio _$PortfolioFromJson(Map<String, dynamic> json) => Portfolio(
      id: json['id'] as int,
      title: json['title'] as String? ?? '',
      photos: (json['photos'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      reputation: (json['reputation'] as num?)?.toDouble() ?? 0,
      locationX: (json['location_x'] as num?)?.toDouble() ?? 0,
      locationY: (json['location_y'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$PortfolioToJson(Portfolio instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'photos': instance.photos,
      'reputation': instance.reputation,
      'location_x': instance.locationX,
      'location_y': instance.locationY,
    };
