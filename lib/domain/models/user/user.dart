// Package imports:
import 'package:json_annotation/json_annotation.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/domain/models/animal/animal.dart';
import 'package:norm/domain/models/career/career.dart';
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/domain/models/education/education.dart';
import 'package:norm/domain/models/hobby/hobby.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/language/language.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/services/helpers.dart';

part 'user.g.dart';

enum Reputation { low, medium, high, veryHigh }

@JsonSerializable(explicitToJson: true)
class User extends _UserBase with _$User {
  static const String CURRENT_USER_NAME = 'self';
  static String shareLink(String username) => 'https://norm.gg/$username';

  User({
    required int id,
    String nickname = '',
    String? avatar,
    String? avatar250,
    double reputation = 1.5,
    bool followed = false,
    bool blocked = false,
    String firstName = '',
    String lastName = '',
    String email = '',
    String? about,
    String? phone,
    this.telegramCode,
    this.invitedBy,
    int filledProfile = 0,
    this.circle = 1,
    this.match = 0,
    int followers = 0,
    int rates = 0,
    int invites = 0,
    int freeInvites = 0,
    this.contactsCount = 0,
    this.mutualContacts = 0,
    this.karmaLevel = 0,
    this.karmaPoints = 0,
    this.karmaPointsNeed = 1,
    this.karmaFine = 0,
    this.karmaFineNeed = 1,
    this.karmaMultiplier = 0,
    List<Speciality> specs = const [],
    List<Language> languages = const [],
    List<Animal> animals = const [],
    List<Hobby> hobbies = const [],
    List<Education> educations = const [],
    List<Career> career = const [],
    List<Contact> contacts = const [],
  }) : super(
          id: id,
          nickname: nickname,
          firstName: firstName,
          lastName: lastName,
          about: about,
          email: email,
          avatar250: avatar250,
          avatar: avatar,
          phone: phone,
          reputation: reputation,
          followed: followed,
          followers: followers,
          rates: rates,
          blocked: blocked,
          filledProfile: filledProfile,
          specs: specs,
          languages: languages,
          animals: animals,
          hobbies: hobbies,
          educations: educations,
          career: career,
          contacts: contacts,
          invites: invites,
          freeInvites: freeInvites,
        );

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  /// Model of user who invited current user.
  @JsonKey(name: 'invited_by')
  final Profile? invitedBy;

  /// How much do current user match with this user.
  final int match;

  /// How many contacts this user has.
  @JsonKey(name: 'user_contacts')
  final int contactsCount;

  final int circle;

  /// How many mutual contacts this user has.
  @JsonKey(name: 'mutual_contacts')
  final int mutualContacts;

  /// Karma level of user.
  @JsonKey(name: 'karma_lvl')
  final int karmaLevel;

  /// User karma points.
  @JsonKey(name: 'karma_points')
  final int karmaPoints;

  /// User karma points need.
  @JsonKey(name: 'karma_points_need')
  final int karmaPointsNeed;

  /// User karma fine.
  @JsonKey(name: 'karma_fine')
  final int karmaFine;

  /// User karma fine need.
  @JsonKey(name: 'karma_fine_need')
  final int karmaFineNeed;

  /// Karma multiplier.
  @JsonKey(name: 'karma_multiplier')
  final double karmaMultiplier;

  @JsonKey(name: 'tg_code')
  final String? telegramCode;

  bool get hasExtendedInformation =>
      hobbies.isNotEmpty || educations.isNotEmpty || career.isNotEmpty || animals.isNotEmpty || languages.isNotEmpty;

  static Reputation reputationFromValue(double? reputation) {
    if (reputation == null) return Reputation.low;

    if (reputation >= 0 && reputation <= 2.5) {
      return Reputation.low;
    } else if (reputation > 2.5 && reputation <= 5) {
      return Reputation.medium;
    } else if (reputation > 5 && reputation <= 7.5) {
      return Reputation.high;
    } else {
      return Reputation.veryHigh;
    }
  }
}

abstract class _UserBase extends Profile with Store {
  _UserBase({
    required int id,
    String nickname = '',
    double reputation = 1.5,
    this.avatar,
    this.avatar250,
    this.firstName = '',
    this.lastName = '',
    this.about,
    this.email = '',
    this.followers = 0,
    this.rates = 0,
    this.followed = false,
    this.blocked = false,
    this.filledProfile = 0,
    this.invites = 0,
    this.freeInvites = 0,
    this.phone,
    this.specs = const [],
    this.languages = const [],
    this.animals = const [],
    this.hobbies = const [],
    this.educations = const [],
    this.career = const [],
    this.contacts = const [],
  }) : super(
          id: id,
          nickname: nickname,
          // avatar250: avatar250,
          // avatar: avatar,
          reputation: reputation,
        );

  /// User first name.
  @JsonKey(name: 'first_name')
  @observable
  String firstName;

  /// User last name.
  @JsonKey(name: 'last_name')
  @observable
  String lastName;

  /// Information about user.
  @override
  @observable
  String? about;

  /// User email.
  @observable
  String email;

  @override
  @observable
  String? avatar;

  @override
  @observable
  @JsonKey(name: 'avatar_250')
  String? avatar250;

  /// How many users this user can invite.
  @observable
  int invites;

  /// How many users this user can invite.
  @observable
  @JsonKey(name: 'free_invites')
  int freeInvites;

  /// User main contact phone.
  @observable
  @JsonKey(name: 'main_phone')
  String? phone;

  /// Filled profile in percent.
  @JsonKey(name: 'filled_profile')
  @observable
  int filledProfile;

  /// Number of user followers.
  @override
  @observable
  int followers;

  /// Current user, rated the selected user.
  @JsonKey(name: 'rates')
  @observable
  int rates;

  /// If current user follows this user.
  @override
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  @observable
  bool followed;

  /// If current user blocked this user.
  @override
  @JsonKey(fromJson: intToBool, toJson: boolToInt)
  @observable
  bool blocked;

  /// User contacts.
  @observable
  List<Contact> contacts;

  /// User specialities.
  @observable
  List<Speciality> specs;

  /// User languages.
  @observable
  List<Language> languages;

  /// User animals.
  @observable
  List<Animal> animals;

  /// User hobbies.
  @JsonKey(name: 'hobby')
  @observable
  List<Hobby> hobbies;

  /// User educations.
  @JsonKey(name: 'education')
  @observable
  List<Education> educations;

  /// User career.
  List<Career> career;

  void setPhone(String value) => phone = value;

  void addSpeciality(Speciality speciality) {
    specs.add(speciality);
  }

  void addLanguage(Language language) {
    // If user has this language then we just need to update it.
    if (languages.contains(language)) {
      languages.remove(language);
    }

    languages.insert(0, language);
  }

  void deleteLanguage(Language language) {
    if (languages.contains(language)) {
      languages.remove(language);
    } else {
      languages.removeWhere((e) => e.id == language.id);
    }
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

  void addCareer(Career career) {
    // If user has this career then we just need to update it.
    if (this.career.contains(career)) {
      this.career.remove(career);
    }

    this.career.add(career);
  }

  void deleteCareer(Career career) {
    if (this.career.contains(career)) {
      this.career.remove(career);
    } else {
      this.career.removeWhere((e) => e.id == career.id);
    }
  }

  void addAnimal(Animal animal) {
    // If user has this animal then we just need to update it.
    if (animals.contains(animal)) {
      animals.remove(animal);
    }

    animals.add(animal);
  }

  void deleteAnimal(Animal animal) {
    if (animals.contains(animal)) {
      animals.remove(animal);
    } else {
      animals.removeWhere((e) => e.id == animal.id);
    }
  }

  void addHobby(Hobby hobby) {
    // If user has this hobby then we just need to update it.
    if (hobbies.contains(hobby)) {
      hobbies.remove(hobby);
    }

    hobbies.add(hobby);
  }

  void deleteHobby(Hobby hobby) {
    if (hobbies.contains(hobby)) {
      hobbies.remove(hobby);
    } else {
      hobbies.removeWhere((e) => e.id == hobby.id);
    }
  }

  void addEducation(Education education) {
    // If user has this education then we just need to update it.
    if (educations.contains(education)) {
      educations.remove(education);
    }

    educations.add(education);
  }

  void deleteEducation(Education education) {
    if (educations.contains(education)) {
      educations.remove(education);
    } else {
      educations.removeWhere((e) => e.id == education.id);
    }
  }

  void setAvatar(String value, [String? value250]) {
    avatar = value;
    avatar250 = value250 ?? value;
  }

  void block() {
    blocked = true;
  }

  void unblock() {
    blocked = false;
  }

  void follow() {
    followed = true;
    followers++;
  }

  void unfollow() {
    followed = false;
    followers--;
  }

  void increaseInvites() => invites++;
  void decreaseInvites() => invites--;
}
