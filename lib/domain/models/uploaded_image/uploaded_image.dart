// Package imports:
import 'package:json_annotation/json_annotation.dart';

part 'uploaded_image.g.dart';

@JsonSerializable(explicitToJson: true)
class UploadedImage {
  const UploadedImage({
    required this.data,
    this.width = 1,
    this.height = 1,
  });

  factory UploadedImage.fromJson(Map<String, dynamic> json) => _$UploadedImageFromJson(json);
  Map<String, dynamic> toJson() => _$UploadedImageToJson(this);

  @JsonKey(name: 'url')
  final String data;

  @JsonKey(name: 'w')
  final double width;

  @JsonKey(name: 'h')
  final double height;
}
