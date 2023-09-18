// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'portfolio.g.dart';

@JsonSerializable(explicitToJson: true)
class Portfolio {
  const Portfolio({
    required this.id,
    this.title = '',
    this.photos = const [],
    this.reputation = 0,
    this.locationX = 0,
    this.locationY = 0,
  });

  factory Portfolio.fromJson(Map<String, dynamic> json) => _$PortfolioFromJson(json);
  Map<String, dynamic> toJson() => _$PortfolioToJson(this);

  /// Portfolio id.
  final int id;

  /// Portfolio title.
  final String title;

  /// Attached photos.
  final List<String> photos;

  /// Work reputation.
  final double reputation;

  @JsonKey(name: 'location_x')
  final double? locationX;

  @JsonKey(name: 'location_y')
  final double? locationY;
}
