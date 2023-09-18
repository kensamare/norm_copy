// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';

part 'karma_history.g.dart';

enum KarmaType { specRate, itemRate }

@JsonSerializable(explicitToJson: true)
class KarmaHistory {
  const KarmaHistory({
    required this.id,
    this.change = 0,
    this.text = '',
    this.createdAt,
    this.type = KarmaType.itemRate,
  });

  factory KarmaHistory.fromJson(Map<String, dynamic> json) => _$KarmaHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$KarmaHistoryToJson(this);

  /// Karma history record id.
  final int id;

  /// Karma record type.
  @JsonKey(fromJson: _karmaTypeFromJson)
  final KarmaType type;

  /// Change in karma.
  final int change;

  /// Text of karma record.
  final String text;

  @JsonKey(name: 'created_at', fromJson: dateFromSeconds)
  final DateTime? createdAt;

  static KarmaType _karmaTypeFromJson(String json) {
    switch (json) {
      case 'item_rate':
        return KarmaType.itemRate;
      case 'spec_rate':
      default:
        return KarmaType.specRate;
    }
  }
}
