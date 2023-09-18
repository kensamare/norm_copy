// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      nickname: json['nickname'] as String? ?? '',
      avatar: json['avatar'] as String?,
      avatar250: json['avatar_250'] as String?,
      reputation: (json['reputation'] as num?)?.toDouble() ?? 1.5,
      followed:
          json['followed'] == null ? false : intToBool(json['followed'] as int),
      blocked:
          json['blocked'] == null ? false : intToBool(json['blocked'] as int),
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      about: json['about'] as String?,
      phone: json['main_phone'] as String?,
      telegramCode: json['tg_code'] as String?,
      invitedBy: json['invited_by'] == null
          ? null
          : Profile.fromJson(json['invited_by'] as Map<String, dynamic>),
      filledProfile: json['filled_profile'] as int? ?? 0,
      circle: json['circle'] as int? ?? 1,
      match: json['match'] as int? ?? 0,
      followers: json['followers'] as int? ?? 0,
      rates: json['rates'] as int? ?? 0,
      invites: json['invites'] as int? ?? 0,
      freeInvites: json['free_invites'] as int? ?? 0,
      contactsCount: json['user_contacts'] as int? ?? 0,
      mutualContacts: json['mutual_contacts'] as int? ?? 0,
      karmaLevel: json['karma_lvl'] as int? ?? 0,
      karmaPoints: json['karma_points'] as int? ?? 0,
      karmaPointsNeed: json['karma_points_need'] as int? ?? 1,
      karmaFine: json['karma_fine'] as int? ?? 0,
      karmaFineNeed: json['karma_fine_need'] as int? ?? 1,
      karmaMultiplier: (json['karma_multiplier'] as num?)?.toDouble() ?? 0,
      specs: (json['specs'] as List<dynamic>?)
              ?.map((e) => Speciality.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      languages: (json['languages'] as List<dynamic>?)
              ?.map((e) => Language.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      animals: (json['animals'] as List<dynamic>?)
              ?.map((e) => Animal.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hobbies: (json['hobby'] as List<dynamic>?)
              ?.map((e) => Hobby.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      educations: (json['education'] as List<dynamic>?)
              ?.map((e) => Education.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      career: (json['career'] as List<dynamic>?)
              ?.map((e) => Career.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      contacts: (json['contacts'] as List<dynamic>?)
              ?.map((e) => Contact.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'nickname': instance.nickname,
      'reputation': instance.reputation,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'about': instance.about,
      'email': instance.email,
      'avatar': instance.avatar,
      'avatar_250': instance.avatar250,
      'invites': instance.invites,
      'free_invites': instance.freeInvites,
      'main_phone': instance.phone,
      'filled_profile': instance.filledProfile,
      'followers': instance.followers,
      'rates': instance.rates,
      'followed': boolToInt(instance.followed),
      'blocked': boolToInt(instance.blocked),
      'contacts': instance.contacts.map((e) => e.toJson()).toList(),
      'specs': instance.specs.map((e) => e.toJson()).toList(),
      'languages': instance.languages.map((e) => e.toJson()).toList(),
      'animals': instance.animals.map((e) => e.toJson()).toList(),
      'hobby': instance.hobbies.map((e) => e.toJson()).toList(),
      'education': instance.educations.map((e) => e.toJson()).toList(),
      'career': instance.career.map((e) => e.toJson()).toList(),
      'invited_by': instance.invitedBy?.toJson(),
      'match': instance.match,
      'user_contacts': instance.contactsCount,
      'circle': instance.circle,
      'mutual_contacts': instance.mutualContacts,
      'karma_lvl': instance.karmaLevel,
      'karma_points': instance.karmaPoints,
      'karma_points_need': instance.karmaPointsNeed,
      'karma_fine': instance.karmaFine,
      'karma_fine_need': instance.karmaFineNeed,
      'karma_multiplier': instance.karmaMultiplier,
      'tg_code': instance.telegramCode,
    };

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$User on _UserBase, Store {
  late final _$firstNameAtom =
      Atom(name: '_UserBase.firstName', context: context);

  @override
  String get firstName {
    _$firstNameAtom.reportRead();
    return super.firstName;
  }

  @override
  set firstName(String value) {
    _$firstNameAtom.reportWrite(value, super.firstName, () {
      super.firstName = value;
    });
  }

  late final _$lastNameAtom =
      Atom(name: '_UserBase.lastName', context: context);

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  late final _$aboutAtom = Atom(name: '_UserBase.about', context: context);

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

  late final _$emailAtom = Atom(name: '_UserBase.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$avatarAtom = Atom(name: '_UserBase.avatar', context: context);

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
      Atom(name: '_UserBase.avatar250', context: context);

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

  late final _$invitesAtom = Atom(name: '_UserBase.invites', context: context);

  @override
  int get invites {
    _$invitesAtom.reportRead();
    return super.invites;
  }

  @override
  set invites(int value) {
    _$invitesAtom.reportWrite(value, super.invites, () {
      super.invites = value;
    });
  }

  late final _$freeInvitesAtom =
      Atom(name: '_UserBase.freeInvites', context: context);

  @override
  int get freeInvites {
    _$freeInvitesAtom.reportRead();
    return super.freeInvites;
  }

  @override
  set freeInvites(int value) {
    _$freeInvitesAtom.reportWrite(value, super.freeInvites, () {
      super.freeInvites = value;
    });
  }

  late final _$phoneAtom = Atom(name: '_UserBase.phone', context: context);

  @override
  String? get phone {
    _$phoneAtom.reportRead();
    return super.phone;
  }

  @override
  set phone(String? value) {
    _$phoneAtom.reportWrite(value, super.phone, () {
      super.phone = value;
    });
  }

  late final _$filledProfileAtom =
      Atom(name: '_UserBase.filledProfile', context: context);

  @override
  int get filledProfile {
    _$filledProfileAtom.reportRead();
    return super.filledProfile;
  }

  @override
  set filledProfile(int value) {
    _$filledProfileAtom.reportWrite(value, super.filledProfile, () {
      super.filledProfile = value;
    });
  }

  late final _$followersAtom =
      Atom(name: '_UserBase.followers', context: context);

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

  late final _$ratesAtom = Atom(name: '_UserBase.rates', context: context);

  @override
  int get rates {
    _$ratesAtom.reportRead();
    return super.rates;
  }

  @override
  set rates(int value) {
    _$ratesAtom.reportWrite(value, super.rates, () {
      super.rates = value;
    });
  }

  late final _$followedAtom =
      Atom(name: '_UserBase.followed', context: context);

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

  late final _$blockedAtom = Atom(name: '_UserBase.blocked', context: context);

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
      Atom(name: '_UserBase.contacts', context: context);

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

  late final _$specsAtom = Atom(name: '_UserBase.specs', context: context);

  @override
  List<Speciality> get specs {
    _$specsAtom.reportRead();
    return super.specs;
  }

  @override
  set specs(List<Speciality> value) {
    _$specsAtom.reportWrite(value, super.specs, () {
      super.specs = value;
    });
  }

  late final _$languagesAtom =
      Atom(name: '_UserBase.languages', context: context);

  @override
  List<Language> get languages {
    _$languagesAtom.reportRead();
    return super.languages;
  }

  @override
  set languages(List<Language> value) {
    _$languagesAtom.reportWrite(value, super.languages, () {
      super.languages = value;
    });
  }

  late final _$animalsAtom = Atom(name: '_UserBase.animals', context: context);

  @override
  List<Animal> get animals {
    _$animalsAtom.reportRead();
    return super.animals;
  }

  @override
  set animals(List<Animal> value) {
    _$animalsAtom.reportWrite(value, super.animals, () {
      super.animals = value;
    });
  }

  late final _$hobbiesAtom = Atom(name: '_UserBase.hobbies', context: context);

  @override
  List<Hobby> get hobbies {
    _$hobbiesAtom.reportRead();
    return super.hobbies;
  }

  @override
  set hobbies(List<Hobby> value) {
    _$hobbiesAtom.reportWrite(value, super.hobbies, () {
      super.hobbies = value;
    });
  }

  late final _$educationsAtom =
      Atom(name: '_UserBase.educations', context: context);

  @override
  List<Education> get educations {
    _$educationsAtom.reportRead();
    return super.educations;
  }

  @override
  set educations(List<Education> value) {
    _$educationsAtom.reportWrite(value, super.educations, () {
      super.educations = value;
    });
  }

  @override
  String toString() {
    return '''
firstName: ${firstName},
lastName: ${lastName},
about: ${about},
email: ${email},
avatar: ${avatar},
avatar250: ${avatar250},
invites: ${invites},
freeInvites: ${freeInvites},
phone: ${phone},
filledProfile: ${filledProfile},
followers: ${followers},
rates: ${rates},
followed: ${followed},
blocked: ${blocked},
contacts: ${contacts},
specs: ${specs},
languages: ${languages},
animals: ${animals},
hobbies: ${hobbies},
educations: ${educations}
    ''';
  }
}
