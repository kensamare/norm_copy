// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/domain/models/user/user.dart';

abstract class Profile {
  Profile({
    required this.id,
    this.nickname = '',
    this.reputation = 0,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    if (json['type'] == 0) {
      return User.fromJson(json);
    } else if (json['type'] == 1) {
      return Brand.fromJson(json);
    } else if (json['type'] == 2) {
      return Speciality.fromJson(json);
    }

    return User(id: 0);
  }

  Map<String, dynamic> toJson() {
    if (this is Brand) {
      return (this as Brand).toJson();
    } else if (this is User) {
      return (this as User).toJson();
    }

    return {};
  }

  /// Profile ID.
  final int id;

  /// Profile nickname.
  final String nickname;

  /// Profile avatar.
  abstract String? avatar;

  /// Profile avatar.
  @JsonKey(name: 'avatar_250')
  abstract String? avatar250;

  /// Information about profile.
  abstract String? about;

  /// Profile reputation.
  final double reputation;

  /// If blocked this profile or not.
  abstract bool blocked;

  /// If followed this profile or not.
  abstract bool followed;

  /// Number of profile followers.
  abstract int followers;
}
