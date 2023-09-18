// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'karma_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

KarmaHistory _$KarmaHistoryFromJson(Map<String, dynamic> json) => KarmaHistory(
      id: json['id'] as int,
      change: json['change'] as int? ?? 0,
      text: json['text'] as String? ?? '',
      createdAt: dateFromSeconds(json['created_at']),
      type: json['type'] == null
          ? KarmaType.itemRate
          : KarmaHistory._karmaTypeFromJson(json['type'] as String),
    );

Map<String, dynamic> _$KarmaHistoryToJson(KarmaHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$KarmaTypeEnumMap[instance.type]!,
      'change': instance.change,
      'text': instance.text,
      'created_at': instance.createdAt?.toIso8601String(),
    };

const _$KarmaTypeEnumMap = {
  KarmaType.specRate: 'specRate',
  KarmaType.itemRate: 'itemRate',
};
