// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable(explicitToJson: true)
class Item {
  const Item({
    required this.id,
    this.title = '',
    this.photos = const [],
    this.reputation = 0,
    this.locationX = 0,
    this.locationY = 0,
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
  Map<String, dynamic> toJson() => _$ItemToJson(this);

  /// Item id.
  final int id;

  /// Item title.
  final String title;

  /// Attached photos.
  final List<String> photos;

  /// Item reputation.
  final double reputation;

  @JsonKey(name: 'location_x')
  final double? locationX;

  @JsonKey(name: 'location_y')
  final double? locationY;
}
