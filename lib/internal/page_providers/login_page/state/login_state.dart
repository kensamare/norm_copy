// Dart imports:
import 'dart:async';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/auth_repository.dart';
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'login_state.g.dart';

class LoginState = _LoginStateBase with _$LoginState;

abstract class _LoginStateBase with Store {
  AuthRepository get _authRepository => service<AuthRepository>();
  AuthState get authState => service<AuthState>();

  @observable
  String login = '';

  @observable
  String password = '';

  /// Error message to show.
  @observable
  List<int> errors = [];

  /// If request is in progress of not.
  @observable
  bool isLoading = false;

  @computed
  bool get canGoForward => !login.isBlank && !password.isBlank;

  Future<bool> signIn() async {
    isLoading = true;

    final BaseResponse<Session?> response = await _authRepository.signIn(login: login, password: password);

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      // Save session.
      unawaited(authState.activateSession(response.data!));

      return true;
    } else {
      errors = response.errorCodes;
      print(response.errorCodes);
    }

    return false;
  }

  void setLogin(String value) => login = value;

  void setPassword(String value) => password = value;
}
