// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'edit_specialities_state.g.dart';

class EditSpecialitiesState = _EditSpecialitiesStateBase with _$EditSpecialitiesState;

abstract class _EditSpecialitiesStateBase with Store {
  @computed
  User? get user => service<AuthState>().user;
}
