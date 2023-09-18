// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'edit_phone_number_state.g.dart';

class EditPhoneNumberState = _EditPhoneNumberStateBase with _$EditPhoneNumberState;

abstract class _EditPhoneNumberStateBase with Store {
  @computed
  User? get user => service<AuthState>().user;
}
