// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'brand_category.g.dart';

@JsonSerializable(explicitToJson: true)
class BrandCategory {
  const BrandCategory({this.id, this.title = ''});

  factory BrandCategory.fromJson(Map<String, dynamic> json) => _$BrandCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$BrandCategoryToJson(this);

  /// Category ID.
  final int? id;

  final String title;
}
