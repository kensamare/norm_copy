// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/brand_category/brand_category.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/services/service_locator.dart';

class BrandRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<Brand?>> updateData(
    int brandId, {
    String? title,
    String? avatar,
    String? nickname,
    String? url,
    String? about,
    List<Contact>? contacts,
  }) async {
    try {
      final Map<String, dynamic> body = {
        if (url != null) 'url': url,
        if (title != null) 'title': title,
        if (nickname != null) 'nickname': nickname,
        if (avatar != null) 'avatar': avatar,
        if (about != null) 'about': about,
        if (contacts != null) 'contacts': contacts.map((e) => e.toJson()).toList(),
      };

      final Response? response = await _api.put(method: '/brands/$brandId', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson(value, Brand.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse> deleteBrand({required int id}) async {
    try {
      final Response? response = await _api.delete(method: '/brands/$id');
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Get nickname availability.
  Future<BaseResponse<bool?>> getNicknameAvailability(String nickname) async {
    try {
      final Map<String, dynamic> params = {
        'nickname': nickname,
      };

      final Response? response = await _api.get(method: '/brands/nickname/available', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<Brand?>> create(
      {required String title,
      required String nickname,
      BrandCategory? category,
      String? categoryTitle,
      String? avatar,
      String? since}) async {
    try {
      final Map<String, dynamic> body = {
        'title': title,
        'nickname': nickname,
        if (category != null) 'id_category': category.id,
        if (categoryTitle != null) 'category_title': categoryTitle,
        if (avatar != null) 'avatar': avatar,
        if (since != null) 'since': since,
      };

      final Response? response = await _api.post(method: '/brands', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Brand>(value, Brand.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Receives information about brands.
  Future<BaseResponse<List<Brand>?>> fetchBrands({String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (search != null) 'q': search,
      };

      final Response? response = await _api.get(method: '/brands', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<Brand>(value, Brand.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Receives information about brand categories.
  Future<BaseResponse<List<BrandCategory>?>> fetchBrandCategories({String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (search != null) 'q': search,
      };

      final Response? response = await _api.get(method: '/database/brand/categories', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<BrandCategory>(
              (value as Map<String, dynamic>)['categories'], BrandCategory.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Receives information about brand with *id*.
  Future<BaseResponse<Brand?>> fetchBrand({required int id}) async {
    try {
      final Response? response = await _api.get(method: '/brands/$id');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson(value, Brand.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Follow brand with id.
  Future<BaseResponse> followBrand(int id) async {
    try {
      final Map<String, dynamic> body = {};

      final Response? response = await _api.post(method: '/brands/$id/follow', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Unfollow brand with id.
  Future<BaseResponse> unfollowBrand(int id) async {
    try {
      final Response? response = await _api.delete(method: '/brands/$id/follow');
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
