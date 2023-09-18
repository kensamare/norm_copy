// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'animal.g.dart';

@JsonSerializable(explicitToJson: true)
class Animal extends Equatable {
  const Animal({
    this.id,
    this.animalId,
    this.description = '',
    this.title = '',
    this.age = 1,
    this.customTitle,
    this.typeId,
    this.typeTitle,
  });

  factory Animal.fromJson(Map<String, dynamic> json) => _$AnimalFromJson(json);
  Map<String, dynamic> toJson() => _$AnimalToJson(this);

  final int? id;

  @JsonKey(name: 'id_animal')
  final int? animalId;

  /// Animal description.
  final String description;

  /// Animal title.
  final String title;

  /// Custom animal title.
  @JsonKey(name: 'animal_title')
  final String? customTitle;

  /// Animal type id.
  @JsonKey(name: 'id_animal_type')
  final int? typeId;

  @JsonKey(name: 'animal_type_title')
  final String? typeTitle;

  @JsonKey(name: 'years')
  final int age;

  @override
  List<Object?> get props => [id];
}
