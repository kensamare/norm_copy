// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/invite/invite.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';

class InvitesRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<Invite?>> generateInviteCode() async {
    try {
      final Map<String, dynamic> body = {};

      final Response? response = await _api.post(method: '/invites/code', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Invite>(value, Invite.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse> revokeInvite({required int id}) async {
    try {
      final Response? response = await _api.delete(method: '/invites/$id');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<List<Invite>>> fetchInvites() async {
    try {
      final Map<String, dynamic> params = {};

      final Response? response = await _api.get(method: '/invites', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<Invite>(
              (value as Map<String, dynamic>)['invites'], Invite.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<List<User>>> fetchInvitedUsers() async {
    try {
      final Map<String, dynamic> params = {};

      final Response? response = await _api.get(method: '/invites/users', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) =>
              BaseResponse.evaluateListModelFromJson<User>((value as Map<String, dynamic>)['users'], User.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }
}
