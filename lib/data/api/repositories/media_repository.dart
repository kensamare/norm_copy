// Dart imports:
import 'dart:typed_data';

// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/uploaded_image/uploaded_image.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/services/settings/settings.dart';

class MediaRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<UploadedImage?>> uploadImage(Uint8List imageData, String? fileExtension) async {
    // Form Data с файлом изображения.
    final FormData formData = FormData.fromMap(
      {
        "file": MultipartFile.fromBytes(imageData, filename: 'temp.${fileExtension ?? 'png'}'),
      },
    );

    final Response? response = await _api.post(
      method: "https://media.${Settings.backendSettings.domain}",
      body: formData,
    );

    // Результат от сервера.
    final Map<String, dynamic>? data = response?.data;
    if (data == null) return const BaseResponse();

    print(data);

    return BaseResponse.fromJson(
      data,
      (value) => BaseResponse.evaluateModelFromJson<UploadedImage>(value, UploadedImage.fromJson),
    );
  }
}
