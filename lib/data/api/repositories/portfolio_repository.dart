// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/portfolio/portfolio.dart';
import 'package:norm/internal/services/service_locator.dart';

class PortfolioRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<Portfolio?>> createPortfolio({
    required String title,
    required List<String> photos,
    int? specialityId,
    int? brandId,
    double? locationX,
    double? locationY,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'title': title,
        'photos': photos,
        if (specialityId != null) 'id_spec': specialityId,
        if (brandId != null) 'id_brand': brandId,
        if (locationX != null && locationY != null) ...{
          'location_x': locationX,
          'location_y': locationY,
        },
      };

      final Response? response = await _api.post(method: '/portfolio', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Portfolio>(value, Portfolio.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<List<Portfolio>>> fetchPortfolio({int? specialityId, int? brandId}) async {
    try {
      final Map<String, dynamic> params = {
        // if (!search.isBlank) 'q': search,
        if (specialityId != null) 'id_spec': specialityId,
        if (brandId != null) 'id_brand': brandId,
      };

      final Response? response = await _api.get(method: '/portfolio', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<Portfolio>(value, Portfolio.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }
}
