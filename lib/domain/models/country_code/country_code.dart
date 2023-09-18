// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'country_code.g.dart';

@JsonSerializable(explicitToJson: true)
class CountryCode {
  const CountryCode({
    required this.id,
    this.names = const {},
    this.phoneCode = '',
  });

  factory CountryCode.fromJson(Map<String, dynamic> json) => _$CountryCodeFromJson(json);
  Map<String, dynamic> toJson() => _$CountryCodeToJson(this);

  /// Country id or its country code.
  final String id;

  /// Country names.
  @JsonKey(name: 'name')
  final Map<String, String> names;

  /// Country phone number.
  @JsonKey(name: 'phone_code')
  final String phoneCode;
}
