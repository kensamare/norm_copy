// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';

class CirclesRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<List<User>>> fetchCircleUsers({required String circleId, required int userId}) async {
    try {
      final Map<String, dynamic> params = {
        'id_user': userId,
        'type': circleId,
      };

      final Response? response = await _api.get(method: '/circles', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<User>(value, User.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }
}
