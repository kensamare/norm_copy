// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/internal/services/helpers.dart';

part 'brand.g.dart';

@JsonSerializable(explicitToJson: true)
class Brand extends _BrandBase with _$Brand {
  static String shareLink(String username) => 'https://norm.gg/$username';

  Brand({
    required int id,
    String nickname = '',
    double reputation = 0,
    String? avatar,
    String? avatar250,
    String? about,
    this.title = '',
    this.category = '',
    int followers = 0,
    this.my = false,
    bool followed = false,
    bool blocked = false,
    List<Contact> contacts = const [],
  }) : super(
          id: id,
          nickname: nickname,
          avatar250: avatar250,
          avatar: avatar,
          reputation: reputation,
          followers: followers,
          blocked: blocked,
          followed: followed,
          about: about,
          contacts: contacts,
        );

  factory Brand.fromJson(Map<String, dynamic> json) => _$BrandFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$BrandToJson(this);

  /// Brand title.
  final String title;

  /// Brand category e.g. IT, Health and Care etc.
  final String category;

  /// My brand or not.
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  final bool my;
}

abstract class _BrandBase extends Profile with Store {
  _BrandBase({
    required int id,
    String nickname = '',
    double reputation = 0,
    this.avatar,
    this.avatar250,
    this.about,
    this.followers = 0,
    this.followed = false,
    this.blocked = false,
    this.contacts = const [],
  }) : super(
          id: id,
          nickname: nickname,
          reputation: reputation,
        );

  @override
  @observable
  String? avatar;

  @override
  @observable
  @JsonKey(name: 'avatar_250')
  String? avatar250;

  /// Information about brand.
  @override
  @observable
  String? about;

  /// Number of user followers.
  @override
  @observable
  int followers;

  /// If current user follows this brand.
  @override
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  @observable
  bool followed;

  /// If current user blocked this brand.
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
