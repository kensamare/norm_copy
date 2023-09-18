// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'settings_details.g.dart';

@JsonSerializable(explicitToJson: true)
class SettingsDetails {
  const SettingsDetails({
    this.firstTimeInApp = true,
  });

  factory SettingsDetails.fromJson(Map<String, dynamic> json) => _$SettingsDetailsFromJson(json);
  Map<String, dynamic> toJson() => _$SettingsDetailsToJson(this);

  @JsonKey(name: 'first_time_in_app')
  final bool firstTimeInApp;
}
