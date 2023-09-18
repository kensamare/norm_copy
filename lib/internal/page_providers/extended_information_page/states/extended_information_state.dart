// Package imports:
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';

part 'extended_information_state.g.dart';

class ExtendedInformationState = _ExtendedInformationStateBase with _$ExtendedInformationState;

abstract class _ExtendedInformationStateBase with Store {
  _ExtendedInformationStateBase({
    required this.user,
  });

  final User user;
}
