// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_from_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionFromToken _$SessionFromTokenFromJson(Map<String, dynamic> json) =>
    SessionFromToken(
      token: json['access_token'] as String,
      invitedBy: json['invite_by'] == null
          ? null
          : Profile.fromJson(json['invite_by'] as Map<String, dynamic>),
      active: json['active'] as bool? ?? false,
    )..user = json['user'] == null
        ? null
        : User.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$SessionFromTokenToJson(SessionFromToken instance) =>
    <String, dynamic>{
      'user': instance.user?.toJson(),
      'active': instance.active,
      'access_token': instance.token,
      'invite_by': instance.invitedBy?.toJson(),
    };
