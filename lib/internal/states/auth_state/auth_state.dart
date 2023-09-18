// Dart imports:
import 'dart:async';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/auth_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/data/local_storage/app_user_sessions_local_storage/app_user_sessions_local_storage.dart';
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/n_logger/n_logger.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

part 'auth_state.g.dart';

class AuthState extends _AuthStateBase with _$AuthState {
  /// Required code length.
  static const int INPUT_CODE_LENGTH = 6;
}

abstract class _AuthStateBase with Store implements Initializable {
  Api get _api => service<Api>();
  AuthRepository get _authRepository => service<AuthRepository>();
  UsersRepository get _usersRepository => service<UsersRepository>();
  AppUserSessionsLocalStorage get _sessionsStorage => service<AppUserSessionsLocalStorage>();

  /// Currently active user session.
  @observable
  Session? session;

  @computed
  User? get user => session?.user;

  Future<SessionStatus?> getSessionStatus() async {
    final BaseResponse<SessionStatus?> response = await _authRepository.fetchSessionStatus();
    if (response.successful) return response.data;

    return null;
  }

  Future<void> updateUser(User user) async {
    session?.setUser(user);
    _sessionsStorage.cacheUser(user);
  }

  /// Activates session.
  Future<void> activateSession(Session session) async {
    try {
      // Set current session.
      this.session = session;

      // Update access token.
      _api.setToken(session.token);

      // Get user for session.
      final BaseResponse<User?> response = await _usersRepository.fetchCurrentUser();

      // If we received user for current session then we need to cache it.
      if (response.successful) {
        session.setUser(response.data!);
      }

      // Session becomes active.
      session.setActiveStatus(true);

      // Cache session in local storage.
      _sessionsStorage.cache(session);
    } catch (e, s) {
      NLogger.handleException(e, s);
    }
  }

  Future<void> activateTestSession() async {
    await activateSession(
      // Session(token: 'byLOc5fspwS17bn0oHLAFjkA1xrwG5ka'),
      Session(token: 'TEST_TOKEN'),
    );
  }

  Future<void> logout() async {
    if (session == null) return;

    /// Remove all sessions.
    await _sessionsStorage.removeAll();
    session = null;

    // Clear api token.
    _api.clearToken();
  }

  @override
  Future<void> initialize() async {
    // return await activateTestSession();

    // Если на устройстве сохранены сессии, тогда нужно активировать одну из сессий.
    if (_sessionsStorage.hasSession) {
      // Если есть активная сессия, то используем ее, иначе используем первую.
      await activateSession(_sessionsStorage.activeSession!);
    }
  }
}
