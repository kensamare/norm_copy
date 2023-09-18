// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Speciality _$SpecialityFromJson(Map<String, dynamic> json) => Speciality(
      id: json['id'] as int,
      nickname: json['nickname'] as String? ?? '',
      avatar: json['avatar'] as String?,
      avatar250: json['avatar_250'] as String?,
      about: json['about'] as String?,
      reputation: (json['reputation'] as num?)?.toDouble() ?? 1.5,
      followed:
          json['followed'] == null ? false : intToBool(json['followed'] as int),
      blocked:
          json['blocked'] == null ? false : intToBool(json['blocked'] as int),
      followers: json['followers'] as int? ?? 0,
      type: json['type'] == null
          ? SpecialityType.profession
          : Speciality._specialityTypefromInt(json['type']),
      brandId: json['id_brand'] as int? ?? 0,
      specialityId: json['id_spec'] as int? ?? 0,
      title: json['title'] as String? ?? '',
      category: json['category'] as String? ?? '',
      description: json['description'] as String?,
      icon: json['icon'] as String? ?? '',
      my: json['my'] == null ? false : intToBool(json['my'] as int),
      level: Speciality._specialityLevelFromInt(json['level']),
      role: json['role'] as String?,
      from:
          json['from'] == null ? null : DateTime.parse(json['from'] as String),
      brand: json['brand'] == null
          ? null
          : Brand.fromJson(json['brand'] as Map<String, dynamic>),
      spec: json['spec'] == null
          ? null
          : Speciality.fromJson(json['spec'] as Map<String, dynamic>),
      hasItems: json['has_items'] == null
          ? false
          : intToBool(json['has_items'] as int),
      hasPortfolio: json['has_portfolio'] == null
          ? false
          : intToBool(json['has_portfolio'] as int),
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SpecialityToJson(Speciality instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'reputation': instance.reputation,
      'about': instance.about,
      'avatar': instance.avatar,
      'avatar_250': instance.avatar250,
      'followers': instance.followers,
      'followed': boolToInt(instance.followed),
      'blocked': boolToInt(instance.blocked),
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
      'id_spec': instance.specialityId,
      'id_brand': instance.brandId,
      'level': _$SpecialityLevelEnumMap[instance.level],
      'role': instance.role,
      'type': _$SpecialityTypeEnumMap[instance.type]!,
      'title': instance.title,
      'brand': instance.brand?.toJson(),
      'spec': instance.spec?.toJson(),
      'from': instance.from?.toIso8601String(),
      'category': instance.category,
      'description': instance.description,
      'icon': instance.icon,
      'my': boolToInt(instance.my),
      'has_portfolio': boolToInt(instance.hasPortfolio),
      'has_items': boolToInt(instance.hasItems),
    };

const _$SpecialityLevelEnumMap = {
  SpecialityLevel.beginner: 'beginner',
  SpecialityLevel.middle: 'middle',
  SpecialityLevel.master: 'master',
};

const _$SpecialityTypeEnumMap = {
  SpecialityType.profession: 'profession',
  SpecialityType.myBrand: 'myBrand',
  SpecialityType.work: 'work',
};

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$Speciality on _SpecialityBase, Store {
  late final _$aboutAtom =
      Atom(name: '_SpecialityBase.about', context: context);

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

  late final _$avatarAtom =
      Atom(name: '_SpecialityBase.avatar', context: context);

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
      Atom(name: '_SpecialityBase.avatar250', context: context);

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

  late final _$followersAtom =
      Atom(name: '_SpecialityBase.followers', context: context);

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
      Atom(name: '_SpecialityBase.followed', context: context);

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

  late final _$blockedAtom =
      Atom(name: '_SpecialityBase.blocked', context: context);

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
      Atom(name: '_SpecialityBase.contacts', context: context);

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
about: ${about},
avatar: ${avatar},
avatar250: ${avatar250},
followers: ${followers},
followed: ${followed},
blocked: ${blocked},
contacts: ${contacts}
    ''';
  }
}
