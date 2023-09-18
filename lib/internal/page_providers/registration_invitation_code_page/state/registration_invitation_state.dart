// Dart imports:
import 'dart:async';

// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/api/models/base_response.dart';
import 'package:norm/data/api/repositories/auth_repository.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/session_from_token/session_from_token.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'registration_invitation_state.g.dart';

class RegistrationInvitationState = _RegistrationInvitationStateBase with _$RegistrationInvitationState;

abstract class _RegistrationInvitationStateBase with Store {
  AuthRepository get _authRepository => service<AuthRepository>();
  AuthState get authState => service<AuthState>();

  /// Invitation code user has inputed.
  @observable
  String invitationCode = '';

  /// Error message to show.
  @observable
  List<int> errors = [];

  @observable
  bool agreedToTerms = false;

  /// If request is in progress of not.
  @observable
  bool isLoading = false;

  /// Whether user completed code input or not.
  @computed
  bool get filledCode => invitationCode.length == AuthState.INPUT_CODE_LENGTH;

  /// Invitation initiator.
  Profile? invitedBy;

  Future<bool> requestSessionFromToken() async {
    isLoading = true;

    final BaseResponse<SessionFromToken?> response =
        await _authRepository.fetchSessionFromInvitationCode(invitationCode: invitationCode);

    isLoading = false;

    // If response is successful.
    if (response.successful) {
      invitedBy = response.data?.invitedBy;

      // Save session.
      unawaited(authState.activateSession(response.data!));

      return true;
    } else {
      errors = response.errorCodes;
      print(response.errorCodes);
    }

    return false;
  }

  void setAgreedToTerms(bool value) => agreedToTerms = value;

  /// Sets invitation code.
  void setCode(String code) {
    invitationCode = code;
  }

  void resetCode() {
    invitationCode = '';
  }
}
