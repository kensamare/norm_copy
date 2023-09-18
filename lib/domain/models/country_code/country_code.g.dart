// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryCode _$CountryCodeFromJson(Map<String, dynamic> json) => CountryCode(
      id: json['id'] as String,
      names: (json['name'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      phoneCode: json['phone_code'] as String? ?? '',
    );

Map<String, dynamic> _$CountryCodeToJson(CountryCode instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.names,
      'phone_code': instance.phoneCode,
    };
