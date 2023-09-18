// Package imports:
import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/internal/services/helpers.dart';

part 'career.g.dart';

@JsonSerializable(explicitToJson: true)
class Career extends Equatable {
  const Career({
    this.id,
    this.position = '',
    this.description = '',
    this.customTitle,
    this.brand,
    this.from,
    this.to,
  });

  factory Career.fromJson(Map<String, dynamic> json) => _$CareerFromJson(json);
  Map<String, dynamic> toJson() => _$CareerToJson(this);

  Map<String, dynamic> toSaveJson() {
    return {
      if (id != null) 'id': id,
      if (brand != null) 'id_brand': brand!.id,
      if (customTitle != null) 'company_title': customTitle,
      'position': position,
      'description': description,
      if (from != null) 'from': DateFormat(datePattern).format(from!),
      if (to != null) 'to': DateFormat(datePattern).format(to!),
    };
  }

  final int? id;

  /// Career position.
  final String position;

  /// Career title.
  final String description;

  final String? customTitle;

  final Brand? brand;

  /// Date of beggining of this career.
  final DateTime? from;

  /// Date of end of this career.
  final DateTime? to;

  @override
  List<Object?> get props => [id];
}
