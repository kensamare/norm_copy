// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Brand _$BrandFromJson(Map<String, dynamic> json) => Brand(
      id: json['id'] as int,
      nickname: json['nickname'] as String? ?? '',
      reputation: (json['reputation'] as num?)?.toDouble() ?? 0,
      avatar: json['avatar'] as String?,
      avatar250: json['avatar_250'] as String?,
      about: json['about'] as String?,
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      followers: json['followers'] as int? ?? 0,
      my: json['my'] == null ? false : intToBool(json['my'] as int),
      followed:
          json['followed'] == null ? false : intToBool(json['followed'] as int),
      blocked:
          json['blocked'] == null ? false : intToBool(json['blocked'] as int),
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$BrandToJson(Brand instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'reputation': instance.reputation,
      'avatar': instance.avatar,
      'avatar_250': instance.avatar250,
      'about': instance.about,
      'followers': instance.followers,
      'followed': boolToInt(instance.followed),
      'blocked': boolToInt(instance.blocked),
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
      'title': instance.title,
      'category': instance.category,
      'my': boolToInt(instance.my),
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Brand on _BrandBase, Store {
  late final _$avatarAtom = Atom(name: '_BrandBase.avatar', context: context);

  @override
  String? get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String? value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  late final _$avatar250Atom =
      Atom(name: '_BrandBase.avatar250', context: context);

  @override
  String? get avatar250 {
    _$avatar250Atom.reportRead();
    return super.avatar250;
  }

  @override
  set avatar250(String? value) {
    _$avatar250Atom.reportWrite(value, super.avatar250, () {
      super.avatar250 = value;
    });
  }

  late final _$aboutAtom = Atom(name: '_BrandBase.about', context: context);

  @override
  String? get about {
    _$aboutAtom.reportRead();
    return super.about;
  }

  @override
  set about(String? value) {
    _$aboutAtom.reportWrite(value, super.about, () {
      super.about = value;
    });
  }

  late final _$followersAtom =
      Atom(name: '_BrandBase.followers', context: context);

  @override
  int get followers {
    _$followersAtom.reportRead();
    return super.followers;
  }

  @override
  set followers(int value) {
    _$followersAtom.reportWrite(value, super.followers, () {
      super.followers = value;
    });
  }

  late final _$followedAtom =
      Atom(name: '_BrandBase.followed', context: context);

  @override
  bool get followed {
    _$followedAtom.reportRead();
    return super.followed;
  }

  @override
  set followed(bool value) {
    _$followedAtom.reportWrite(value, super.followed, () {
      super.followed = value;
    });
  }

  late final _$blockedAtom = Atom(name: '_BrandBase.blocked', context: context);

  @override
  bool get blocked {
    _$blockedAtom.reportRead();
    return super.blocked;
  }

  @override
  set blocked(bool value) {
    _$blockedAtom.reportWrite(value, super.blocked, () {
      super.blocked = value;
    });
  }

  late final _$contactsAtom =
      Atom(name: '_BrandBase.contacts', context: context);

  @override
  List<Contact> get contacts {
    _$contactsAtom.reportRead();
    return super.contacts;
  }

  @override
  set contacts(List<Contact> value) {
    _$contactsAtom.reportWrite(value, super.contacts, () {
      super.contacts = value;
    });
  }

  @override
  String toString() {
    return '''
avatar: ${avatar},
avatar250: ${avatar250},
about: ${about},
followers: ${followers},
followed: ${followed},
blocked: ${blocked},
contacts: ${contacts}
    ''';
  }
}
