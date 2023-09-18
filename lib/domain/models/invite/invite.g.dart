// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invite _$InviteFromJson(Map<String, dynamic> json) => Invite(
      id: json['id'] as int,
      code: json['code'] as String,
      status: json['status'] == null
          ? InviteStatus.notactivated
          : Invite._inviteStatusFromJson(json['status'] as int),
    );

Map<String, dynamic> _$InviteToJson(Invite instance) => <String, dynamic>{
      'id': instance.id,
      'code': instance.code,
      'status': _$InviteStatusEnumMap[instance.status]!,
    };

const _$InviteStatusEnumMap = {
  InviteStatus.activated: 'activated',
  InviteStatus.notactivated: 'notactivated',
};
