// Package imports:
import 'package:dio/dio.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';

class SpecsRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<List<Speciality>>> fetchSpecialities({String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (!search.isBlank) 'q': search,
      };

      final Response? response = await _api.get(method: '/database/specs', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<Speciality>(
              (value as Map<String, dynamic>)['specs'], Speciality.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<Speciality?>> createSpeciality({
    required SpecialityType type,
    int? brandId,
    String? brandTitle,
    int? specialityId,
    String? specialityTitle,
    String? description,
    String? role,
    SpecialityLevel? level,
    DateTime? from,
  }) async {
    try {
      final Map<String, dynamic> body = {
        'type': type.asInt,
        if (brandId != null) 'id_brand': brandId,
        if (brandTitle != null) 'brand_title': brandTitle,
        if (specialityId != null) 'id_spec': specialityId,
        if (specialityTitle != null) 'spec_title': specialityTitle,
        if (role != null) 'role': role,
        if (description != null) 'description': description,
        if (from != null) 'from': DateFormat(datePattern).format(from),
        if (level != null) 'level': level.asInt,
      };

      final Response? response = await _api.post(method: '/specs', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Speciality>(value, Speciality.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse> deleteSpec({required int id}) async {
    try {
      final Response? response = await _api.delete(method: '/specs/$id');
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<Speciality?>> updateData(
    int specId, {
    String? avatar,
    int? brandId,
    int? specialityId,
    String? specialityTitle,
    String? description,
    String? role,
    DateTime? from,
    SpecialityLevel? level,
    List<Contact>? contacts,
  }) async {
    try {
      final Map<String, dynamic> body = {
        if (avatar != null) 'avatar': avatar,
        if (brandId != null) 'id_brand': brandId,
        if (specialityId != null) 'id_spec': specialityId,
        if (specialityTitle != null) 'spec_title': specialityTitle,
        if (role != null) 'role': role,
        if (description != null) 'description': description,
        if (from != null) 'from': DateFormat(datePattern).format(from),
        if (level != null) 'level': level.asInt,
        if (contacts != null) 'contacts': contacts.map((e) => e.toJson()).toList(),
      };

      final Response? response = await _api.put(method: '/specs/$specId', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson(value, Speciality.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Follow speciality with id.
  Future<BaseResponse> followSpec(int id) async {
    try {
      final Map<String, dynamic> body = {};

      final Response? response = await _api.post(method: '/specs/$id/follow', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Unfollow speciality with id.
  Future<BaseResponse> unfollowSpec(int id) async {
    try {
      final Response? response = await _api.delete(method: '/users/$id/follow');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<Speciality?>> fetchSpeciality({required int id}) async {
    try {
      final Response? response = await _api.get(method: '/specs/$id');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson<Speciality>(value, Speciality.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }
}
