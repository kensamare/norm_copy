// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'uploaded_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadedImage _$UploadedImageFromJson(Map<String, dynamic> json) =>
    UploadedImage(
      data: json['url'] as String,
      width: (json['w'] as num?)?.toDouble() ?? 1,
      height: (json['h'] as num?)?.toDouble() ?? 1,
    );

Map<String, dynamic> _$UploadedImageToJson(UploadedImage instance) =>
    <String, dynamic>{
      'url': instance.data,
      'w': instance.width,
      'h': instance.height,
    };
