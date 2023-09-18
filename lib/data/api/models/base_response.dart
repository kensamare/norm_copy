// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:norm/internal/services/n_logger/n_logger.dart';

part 'base_response.g.dart';

@JsonSerializable(createToJson: false, genericArgumentFactories: true)
class BaseResponse<T> {
  static const int _DEFAULT_ERROR_CODE = 65536;

  const BaseResponse({
    this.errorCodes = const [],
    this.errorText = const [],
    this.data,
  });

  /// Returns converted response result.
  /// Example of usage:
  /// ``` dart
  ///  return BaseResponse.fromJson(
  ///     response.data,
  ///     (value) => SessionStatus.values.where((status) => status.code == (value as Map)['status']).first,
  ///   );
  /// ```
  factory BaseResponse.fromJson(Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$BaseResponseFromJson(json, fromJsonT);

  factory BaseResponse.exception(Object e, [StackTrace? s]) {
    NLogger.handleException(e, s);

    return BaseResponse(
      errorCodes: [_DEFAULT_ERROR_CODE],
      errorText: [e.toString(), s.toString()],
    );
  }

  /// Error codes in case of error.
  @JsonKey(name: 'err')
  final List<int> errorCodes;

  /// Error message text.
  @JsonKey(name: 'err_msg')
  final List<String?> errorText;

  /// Custom response data.
  final T? data;

  /// Whether response has error or not.
  bool get hasError {
    if (errorCodes.isEmpty && errorText.isEmpty) return false;

    if (!errorCodes.contains(0)) return true;
    if (!errorText.contains(null)) return true;

    return false;
  }

  /// Whether request performed successfully or not.
  bool get successful => !hasError;

  static T? evaluateModelFromJson<T>(Object? model, Function fromJson) {
    if (model is Map<String, dynamic>) {
      try {
        final T? m = fromJson(model);
        return m;
      } catch (e, s) {
        NLogger.handleException(e, s);
      }
    }

    return null;
  }

  static List<T> evaluateListModelFromJson<T>(Object? models, Function fromJson) {
    if (models is List) {
      if (models.isEmpty) return [];

      try {
        final List<T> list = [];

        // Include only not-nullable elements.
        for (var e in models) {
          final T? model = fromJson(e) as T?;
          if (model == null) continue;

          list.add(model);
        }

        return list;
      } catch (e, s) {
        NLogger.handleException(e, s);
      }
    }

    return [];
  }
}

Map<String, dynamic> mockResponse(Object? data) {
  return {
    'error_code': null,
    'error_text': null,
    'data': data,
  };
}
