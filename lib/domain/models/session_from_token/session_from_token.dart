// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/domain/models/user/user.dart';

part 'session_from_token.g.dart';

@JsonSerializable(explicitToJson: true)
class SessionFromToken extends Session {
  SessionFromToken({
    required String token,
    this.invitedBy,
    bool active = false,
  }) : super(
          token: token,
          active: active,
        );

  factory SessionFromToken.fromJson(Map<String, dynamic> json) => _$SessionFromTokenFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SessionFromTokenToJson(this);

  /// The user this user has been invited by.
  @JsonKey(name: 'invite_by')
  final Profile? invitedBy;
}
