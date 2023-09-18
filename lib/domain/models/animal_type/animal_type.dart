// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'animal_type.g.dart';

@JsonSerializable(explicitToJson: true)
class AnimalType {
  const AnimalType({this.id, this.title = ''});

  factory AnimalType.fromJson(Map<String, dynamic> json) => _$AnimalTypeFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalTypeToJson(this);

  /// Animal type id.
  final int? id;

  /// Animal type title.
  final String title;
}
