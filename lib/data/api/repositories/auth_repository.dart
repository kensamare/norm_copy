// Package imports:
import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/local_storage/app_version_local_storage/app_version_local_storage.dart';
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/domain/models/session_from_token/session_from_token.dart';
import 'package:norm/internal/services/service_locator.dart';

class AuthRepository {
  Api get _api => service<Api>();
  AppVersionLocalStorage get _versionStorage => service<AppVersionLocalStorage>();

  static const String _FCM_KEY = 'fcmid';
  static const String _INVITE_CODE_KEY = 'invite_code';
  static const String _V_KEY = 'v';
  static const String _VERSION_KEY = 'version';

  Future<Map<String, dynamic>> _defaultAuthParams() async => {
        _FCM_KEY: await FirebaseMessaging.instance.getToken(),
        _V_KEY: _versionStorage.version?.major,
        _VERSION_KEY: _versionStorage.version?.raw,
      };

  /// Sends request to receive session from invitation code.
  Future<BaseResponse<SessionFromToken?>> fetchSessionFromInvitationCode({required String invitationCode}) async {
    try {
      final Map<String, dynamic> body = {
        _INVITE_CODE_KEY: invitationCode,
        ...(await _defaultAuthParams()),
      };

      final Response? response = await _api.post(method: '/users', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<SessionFromToken>(value, SessionFromToken.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Sends request to receive session from invitation code.
  Future<BaseResponse<Session?>> signIn({required String login, required String password}) async {
    try {
      final Map<String, dynamic> body = {
        'email': login,
        'password': password,
        ...(await _defaultAuthParams()),
      };

      final Response? response = await _api.post(method: '/sessions', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Session>(value, Session.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Sends request for invitation.
  Future<BaseResponse<Session?>> sendRequest(
      {required String firstName, required String lastName, required String email, required String avatar}) async {
    try {
      final Map<String, dynamic> body = {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'avatar': avatar,
        ...(await _defaultAuthParams()),
      };

      final Response? response = await _api.post(method: '/users/requests', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Session>(value, Session.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Returns whether user session is activated or not.
  Future<BaseResponse<SessionStatus?>> fetchSessionStatus() async {
    try {
      final Response? response = await _api.get(method: '/status');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => SessionStatus.values.where((status) => status.code == (value as Map)['status']).first,
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }
}
