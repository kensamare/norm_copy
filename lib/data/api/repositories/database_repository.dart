// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/domain/models/animal_type/animal_type.dart';
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';

class DatabaseRepository {
  Api get _api => service<Api>();

  Future<BaseResponse<List<Language>>> fetchLanguages({String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (!search.isBlank) 'q': search,
      };

      final Response? response = await _api.get(method: '/database/languages', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<Language>(
              (value as Map<String, dynamic>)['languages'], Language.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<List<Hobby>>> searchHobbies({String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (!search.isBlank) 'q': search,
      };

      final Response? response = await _api.get(method: '/database/hobbies', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) =>
              BaseResponse.evaluateListModelFromJson<Hobby>((value as Map<String, dynamic>)['hobbies'], Hobby.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<List<Animal>?>> searchAnimals({String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (!search.isBlank) 'q': search,
      };

      final Response? response = await _api.get(method: '/database/animals', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<Animal>(
              (value as Map<String, dynamic>)['animals'], Animal.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  Future<BaseResponse<List<AnimalType>?>> searchAnimalTypes({required int animalId, String? search}) async {
    try {
      final Map<String, dynamic> params = {
        if (!search.isBlank) 'q': search,
      };

      final Response? response = await _api.get(method: '/database/animal/$animalId/types', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<AnimalType>(
              (value as Map<String, dynamic>)['animal_types'], AnimalType.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }
}
