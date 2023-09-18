// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/internal/services/service_locator.dart';

class PhoneRepository {
  Api get _api => service<Api>();

  /// Sends request to confirm phone number with code.
  Future<BaseResponse> confirmPhoneWithCode({required String phone, required String code}) async {
    try {
      final Map<String, dynamic> body = {
        'phone': phone,
        'code': code,
      };

      final Response? response = await _api.post(method: '/users/phone/code', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Sends request to confirm phone number.
  Future<BaseResponse> requestPhoneConfirmation({required String phone}) async {
    try {
      final Map<String, dynamic> body = {
        'phone': phone,
      };

      final Response? response = await _api.post(method: '/users/phone', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }
    return const BaseResponse();
  }
}
