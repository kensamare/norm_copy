// Package imports:
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/services/helpers.dart';

part 'speciality.g.dart';

enum SpecialityType { profession, myBrand, work }

enum SpecialityLevel { beginner, middle, master }

@JsonSerializable(explicitToJson: true)
class Speciality extends _SpecialityBase with _$Speciality, EquatableMixin {
  static String shareLink(String username) => 'https://norm.gg/$username';

  Speciality({
    required int id,
    String nickname = '',
    String? avatar,
    String? avatar250,
    String? about,
    double reputation = 1.5,
    bool followed = false,
    bool blocked = false,
    int followers = 0,
    this.type = SpecialityType.profession,
    this.brandId = 0,
    this.specialityId = 0,
    this.title = '',
    this.category = '',
    this.description,
    this.icon = '',
    this.my = false,
    this.level,
    this.role,
    this.from,
    this.brand,
    this.spec,
    this.hasItems = false,
    this.hasPortfolio = false,
    List<Contact> contacts = const [],
  }) : super(
          id: id,
          nickname: nickname,
          reputation: reputation,
          avatar: avatar,
          avatar250: avatar250,
          about: about,
          blocked: blocked,
          followed: followed,
          followers: followers,
          contacts: contacts,
        );

  factory Speciality.fromJson(Map<String, dynamic> json) => _$SpecialityFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SpecialityToJson(this);

  /// Id of speciality.
  @JsonKey(name: 'id_spec')
  final int specialityId;

  /// Id of brand.
  @JsonKey(name: 'id_brand')
  final int brandId;

  /// Speciality level.
  @JsonKey(fromJson: _specialityLevelFromInt)
  final SpecialityLevel? level;

  /// User role at speciality.
  final String? role;

  @JsonKey(fromJson: _specialityTypefromInt)
  final SpecialityType type;

  /// Speciality title.
  final String title;

  /// Speciality brand. (if were provided).
  final Brand? brand;

  /// Speciality of speciality.
  final Speciality? spec;

  ///
  final DateTime? from;

  /// Speciality category e.g. IT, Health and Care etc.
  final String category;

  /// Speciality description.
  final String? description;

  /// Icon url.
  final String icon;

  /// My speciality or not.
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  final bool my;

  /// My speciality or not.
  @JsonKey(name: 'has_portfolio', fromJson: intToBool, toJson: boolToInt)
  final bool hasPortfolio;

  /// My speciality or not.
  @JsonKey(name: 'has_items', fromJson: intToBool, toJson: boolToInt)
  final bool hasItems;

  static SpecialityType _specialityTypefromInt(dynamic value) {
    switch (value) {
      case 0:
        return SpecialityType.profession;
      case 1:
        return SpecialityType.myBrand;
      case 2:
      default:
        return SpecialityType.work;
    }
  }

  static SpecialityLevel _specialityLevelFromInt(dynamic value) {
    switch (value) {
      case 1:
        return SpecialityLevel.middle;
      case 2:
        return SpecialityLevel.master;
      case SpecialityLevel.beginner:
      default:
        return SpecialityLevel.beginner;
    }
  }

  @override
  List<Object?> get props => [id];
}

abstract class _SpecialityBase extends Profile with Store {
  _SpecialityBase({
    required int id,
    String nickname = '',
    double reputation = 1.5,
    this.avatar,
    this.avatar250,
    this.about,
    this.blocked = false,
    this.followed = false,
    this.followers = 0,
    this.contacts = const [],
  }) : super(
          id: id,
          nickname: nickname,
          // avatar250: avatar250,
          // avatar: avatar,
          reputation: reputation,
        );

  /// Information about user.
  @override
  @observable
  String? about;

  /// Speciality avatar.
  @override
  @observable
  String? avatar;

  /// Speciality avatar.
  @override
  @observable
  @JsonKey(name: 'avatar_250')
  String? avatar250;

  /// Number of speciality followers.
  @override
  @observable
  int followers;

  /// If current user follows this speciality.
  @override
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  @observable
  bool followed;

  /// If current user blocked this speciality.
  @override
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  @observable
  bool blocked;

  @observable
  List<Contact> contacts;

  void setAvatar(String value, [String? value250]) {
    avatar = value;
    avatar250 = value250 ?? value;
  }

  void follow() {
    followed = true;
    followers++;
  }

  void unfollow() {
    followed = false;
    followers--;
  }

  void addContact(Contact contact) {
    // If user has this contact then we just need to update it.
    if (contacts.contains(contact)) {
      contacts.remove(contact);
    }

    contacts.add(contact);
  }

  void deleteContact(Contact contact) {
    if (contacts.contains(contact)) {
      contacts.remove(contact);
    } else {
      contacts.removeWhere((e) => e.id == contact.id);
    }
  }
}

extension SpecialityTypeExt on SpecialityType {
  int get asInt {
    switch (this) {
      case SpecialityType.myBrand:
        return 1;
      case SpecialityType.profession:
        return 0;
      case SpecialityType.work:
      default:
        return 2;
    }
  }
}

extension SpecialityLevelExt on SpecialityLevel {
  int get asInt {
    switch (this) {
      case SpecialityLevel.middle:
        return 1;
      case SpecialityLevel.master:
        return 2;
      case SpecialityLevel.beginner:
      default:
        return 0;
    }
  }
}
