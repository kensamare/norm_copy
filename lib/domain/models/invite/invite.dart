// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invite.g.dart';

enum InviteStatus { activated, notactivated }

@JsonSerializable(explicitToJson: true)
class Invite extends Equatable {
  const Invite({
    required this.id,
    required this.code,
    this.status = InviteStatus.notactivated,
  });

  factory Invite.fromJson(Map<String, dynamic> json) => _$InviteFromJson(json);
  Map<String, dynamic> toJson() => _$InviteToJson(this);

  /// Invite ID.
  final int id;

  /// Invite code.
  final String code;

  /// Invite status.
  @JsonKey(fromJson: _inviteStatusFromJson)
  final InviteStatus status;

  static InviteStatus _inviteStatusFromJson(int json) {
    switch (json) {
      case 1:
        return InviteStatus.activated;
      case 0:
      default:
        return InviteStatus.notactivated;
    }
  }

  @override
  List<Object?> get props => [id];
}
