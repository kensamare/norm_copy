// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';

part 'language.g.dart';

enum LanguageLevel { A1, A2, B1, B2, C1, C2 }

@JsonSerializable(explicitToJson: true)
class Language extends Equatable {
  const Language({this.id = -1, this.icon = '', this.level = LanguageLevel.A1, this.title = ''});

  factory Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageToJson(this);

  /// Language id.
  final int? id;

  /// User language development level.
  @JsonKey(fromJson: _languageLevelFromJson, toJson: languageLevelToJson)
  final LanguageLevel level;

  /// Language title.
  @JsonKey(toJson: anyStringToNull)
  final String title;

  /// Language icon.
  @JsonKey(toJson: anyStringToNull)
  final String icon;

  static LanguageLevel _languageLevelFromJson(String json) {
    switch (json.toUpperCase()) {
      case 'A2':
        return LanguageLevel.A2;
      case 'B1':
        return LanguageLevel.B1;
      case 'B2':
        return LanguageLevel.B2;
      case 'C1':
        return LanguageLevel.C1;
      case 'C2':
        return LanguageLevel.C2;
      case 'A1':
      default:
        return LanguageLevel.A1;
    }
  }

  static String languageLevelToJson(LanguageLevel level) => level.name;

  @override
  List<Object?> get props => [id];
}
