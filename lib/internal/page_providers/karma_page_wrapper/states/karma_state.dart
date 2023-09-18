// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';

part 'karma_state.g.dart';

class KarmaState = _KarmaStateBase with _$KarmaState;

abstract class _KarmaStateBase with Store {
  @computed
  User? get user => service<AuthState>().user;
}
