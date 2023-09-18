// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';

part 'session.g.dart';

enum SessionStatus {
  /// Session status when user form is filled and account is activated.
  activated,

  /// Session status when user has been invited, but user form is not filled up.
  invited,

  /// User sent a request.
  request,
}

@JsonSerializable(explicitToJson: true)
class Session extends _SessionBase with _$Session {
  Session({
    required this.token,
    User? user,
    bool active = false,
  }) : super(
          user: user,
          active: active,
        );

  factory Session.fromJson(Map<String, dynamic> json) => _$SessionFromJson(json);
  Map<String, dynamic> toJson() => _$SessionToJson(this);

  /// User session token.
  @JsonKey(name: 'access_token')
  final String token;
}

abstract class _SessionBase with Store {
  _SessionBase({
    this.user,
    this.active = false,
  });

  /// User data.
  @observable
  User? user;

  /// Whether this session is active or not
  bool active;

  void setActiveStatus(bool value) {
    active = value;
  }

  void setUser(User user) {
    this.user = user;
  }

  // @override
  // List<Object?> get props => [token];
}

extension SessionStatusExt on SessionStatus {
  int get code {
    switch (this) {
      case SessionStatus.request:
        return -1;
      case SessionStatus.invited:
        return 0;
      case SessionStatus.activated:
      default:
        return 1;
    }
  }
}
