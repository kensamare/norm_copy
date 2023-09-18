// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'education.g.dart';

@JsonSerializable(explicitToJson: true)
class Education extends Equatable {
  const Education({
    this.id,
    this.faculty = '',
    this.title = '',
    this.year = 1990,
  });

  factory Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);
  Map<String, dynamic> toJson() => _$EducationToJson(this);

  /// Education id.
  final int? id;

  /// Education faculty.
  final String faculty;

  /// Education title.
  final String title;

  final int year;

  @override
  List<Object?> get props => [id];
}
