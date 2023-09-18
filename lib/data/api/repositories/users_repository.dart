// Package imports:
import 'package:contacts_service/contacts_service.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/local_storage/app_user_sessions_local_storage/app_user_sessions_local_storage.dart';
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/contact/contact.dart' as c;
import 'package:norm/domain/models/education/education.dart';
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/domain/models/karma_history/karma_history.dart';
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

class UsersRepository {
  static const String _CURRENT_USER_NAME = User.CURRENT_USER_NAME;

  Api get _api => service<Api>();

  AppUserSessionsLocalStorage get _sessionsStorage => service<AppUserSessionsLocalStorage>();

  /// Receives information about user with name *username*.
  Future<BaseResponse<User?>> fetchUser({required String username}) async {
    try {
      final Response? response = await _api.get(method: '/users/$username');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson(value, User.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Receives information about current user.
  Future<BaseResponse<User?>> fetchCurrentUser() async {
    final BaseResponse<User?> response = await fetchUser(username: _CURRENT_USER_NAME);

    // If response is successful then we need to cache new user information.
    if (response.successful && response.data != null) {
      // _sessionsStorage.cacheUser(response.data!);
      service<AuthState>().updateUser(response.data!);
    }

    return response;
  }

  Future<BaseResponse<List<KarmaHistory>>> fetchUserKarma() async {
    try {
      final Map<String, dynamic> params = {
        // if (!search.isBlank) 'q': search,
      };

      final Response? response = await _api.get(method: 'users/self/karma', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateListModelFromJson<KarmaHistory>(value, KarmaHistory.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Updates user data e.g first_name, last_name, password, login etc.
  Future<BaseResponse<User?>> updateData({
    List<Language>? languages,
    List<Career>? career,
    List<Animal>? animals,
    List<Hobby>? hobbies,
    List<Education>? educations,
    List<c.Contact>? contacts,
  }) async {
    try {
      final Map<String, dynamic> body = {
        if (languages != null) 'languages': languages.map((e) => e.toJson()).toList(),
        if (career != null) 'career': career.map((e) => e.toSaveJson()).toList(),
        if (animals != null) 'animals': animals.map((e) => e.toJson()).toList(),
        if (hobbies != null) 'hobby': hobbies.map((e) => e.toSaveJson()).toList(),
        if (educations != null) 'education': educations.map((e) => e.toJson()).toList(),
        if (contacts != null) 'contacts': contacts.map((e) => e.toJson()).toList(),
      };

      final Response? response = await _api.put(method: '/users/self', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson(value, User.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Updates registration data e.g first_name, last_name, password, login etc.
  Future<BaseResponse<User?>> updateRegistrationData({
    String? firstName,
    String? lastName,
    String? password,
    String? avatar,
    String? username,
    String? email,
    String? about,
  }) async {
    try {
      final Map<String, dynamic> body = {
        if (email != null) 'email': email,
        if (password != null) 'password': password,
        if (username != null) 'nickname': username,
        if (firstName != null) 'first_name': firstName,
        if (lastName != null) 'last_name': lastName,
        if (avatar != null) 'avatar': avatar,
        if (about != null) 'about': about,
      };

      final Response? response = await _api.put(method: '/users', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(
          response.data,
          (value) => BaseResponse.evaluateModelFromJson(value, User.fromJson),
        );
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Updates user specialities.
  Future<BaseResponse> updateSpecs(List<int> specsId) async {
    try {
      final Map<String, dynamic> body = {
        'specs': specsId,
      };

      final Response? response = await _api.post(method: '/users/specs', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Provide contacts to application.
  Future<BaseResponse> provideContacts(List<Contact> contacts) async {
    try {
      final Map<String, dynamic> body = {
        'phonebook': contacts.map((e) => e.toJson).toList(),
      };

      final Response? response = await _api.post(method: '/users/phonebook', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Provide contacts to application.
  Future<BaseResponse<bool?>> getEmailvailability(String email) async {
    try {
      final Map<String, dynamic> params = {
        'email': email,
      };

      final Response? response = await _api.get(method: '/users/email/available', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
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

      final Response? response = await _api.get(method: '/users/nickname/available', params: params);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Follow user with id.
  Future<BaseResponse> followUser(int id) async {
    try {
      final Map<String, dynamic> body = {};

      final Response? response = await _api.post(method: '/users/$id/follow', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Unfollow user with id.
  Future<BaseResponse> unfollowUser(int id) async {
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

  /// Block user with id.
  Future<BaseResponse> blockUser(int id) async {
    try {
      final Map<String, dynamic> body = {};

      final Response? response = await _api.post(method: '/users/$id/block', body: body);
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Unblock user with id.
  Future<BaseResponse> unblockUser(int id) async {
    try {
      final Response? response = await _api.delete(method: '/users/$id/block');
      print(response?.data);

      if (response != null) {
        return BaseResponse.fromJson(response.data, (_) => null);
      }
    } catch (e, s) {
      return BaseResponse.exception(e, s);
    }

    return const BaseResponse();
  }

  /// Rates user with id.
  Future<BaseResponse> rateUser(
    int id, {
    required int rate,
    required int openness,
    required int responsive,
    required int conflict,
    required int selfishness,
    required int reliability,
    required int consistency,
    required int creativity,
    required int initiative,
    required bool personallyKnow,
    int? closeness,
    bool? grant,
    int? knowTime,
    required String good,
    required String bad,
  }) async {
    try {
      final Map<String, dynamic> body = {
        "rate": rate,
        "openness": openness,
        "responsive": responsive,
        "conflict": conflict,
        "selfishness": selfishness,
        "reliability": reliability,
        "consistency": consistency,
        "creativity": creativity,
        "initiative": initiative,
        "good": good,
        "bad": bad,
        "personally_know": boolToInt(personallyKnow),
        "know_time": knowTime,
        "closeness": closeness,
        if (personallyKnow) ...{
          "grant": boolToInt(grant!),
        },
      };

      final Response? response = await _api.post(method: '/user/$id/rates', body: body);
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

extension ContactsExt on Contact {
  Map<String, dynamic> get toJson {
    return {
      'name': displayName,
      'phones': phones?.map((e) => e.value).toList(),
    };
  }
}
