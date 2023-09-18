// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'hobby.g.dart';

@JsonSerializable(explicitToJson: true)
class Hobby extends Equatable {
  const Hobby({
    this.hobbyId,
    this.id,
    this.description = '',
    this.title = '',
    this.icon = '',
    this.level = '',
    this.years = 1,
  });

  factory Hobby.fromJson(Map<String, dynamic> json) => _$HobbyFromJson(json);
  Map<String, dynamic> toJson() => _$HobbyToJson(this);

  Map<String, dynamic> toSaveJson() {
    return {
      if (id != null) 'id': id,
      if (hobbyId != null) 'id_hobby': hobbyId,
      if (title.isNotEmpty) 'hobby_title': title,
      'description': description,
      'years': years,
      'level': level,
    };
  }

  @JsonKey(name: 'id_hobby')
  final int? hobbyId;

  final int? id;

  /// Hobby description.
  final String description;

  /// Hobby title.
  final String title;

  /// Hobby icon.
  final String icon;

  /// Hobby level.
  final String level;

  final int? years;

  @override
  List<Object?> get props => [id];
}
