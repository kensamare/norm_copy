// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_invitation_form_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$UserInvitationFormState on _UserInvitationFormStateBase, Store {
  Computed<bool>? _$canGoForwardFirstComputed;

  @override
  bool get canGoForwardFirst => (_$canGoForwardFirstComputed ??= Computed<bool>(
          () => super.canGoForwardFirst,
          name: '_UserInvitationFormStateBase.canGoForwardFirst'))
      .value;
  Computed<bool>? _$canGoForwardSecondComputed;

  @override
  bool get canGoForwardSecond => (_$canGoForwardSecondComputed ??=
          Computed<bool>(() => super.canGoForwardSecond,
              name: '_UserInvitationFormStateBase.canGoForwardSecond'))
      .value;

  late final _$nameAtom =
      Atom(name: '_UserInvitationFormStateBase.name', context: context);

  @override
  String? get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String? value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$surnameAtom =
      Atom(name: '_UserInvitationFormStateBase.surname', context: context);

  @override
  String? get surname {
    _$surnameAtom.reportRead();
    return super.surname;
  }

  @override
  set surname(String? value) {
    _$surnameAtom.reportWrite(value, super.surname, () {
      super.surname = value;
    });
  }

  late final _$avatarAtom =
      Atom(name: '_UserInvitationFormStateBase.avatar', context: context);

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

  late final _$emailAtom =
      Atom(name: '_UserInvitationFormStateBase.email', context: context);

  @override
  String? get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String? value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$usernameAtom =
      Atom(name: '_UserInvitationFormStateBase.username', context: context);

  @override
  String get username {
    _$usernameAtom.reportRead();
    return super.username;
  }

  @override
  set username(String value) {
    _$usernameAtom.reportWrite(value, super.username, () {
      super.username = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_UserInvitationFormStateBase.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$isLoadingImageAtom = Atom(
      name: '_UserInvitationFormStateBase.isLoadingImage', context: context);

  @override
  bool get isLoadingImage {
    _$isLoadingImageAtom.reportRead();
    return super.isLoadingImage;
  }

  @override
  set isLoadingImage(bool value) {
    _$isLoadingImageAtom.reportWrite(value, super.isLoadingImage, () {
      super.isLoadingImage = value;
    });
  }

  late final _$errorsAtom =
      Atom(name: '_UserInvitationFormStateBase.errors', context: context);

  @override
  List<int> get errors {
    _$errorsAtom.reportRead();
    return super.errors;
  }

  @override
  set errors(List<int> value) {
    _$errorsAtom.reportWrite(value, super.errors, () {
      super.errors = value;
    });
  }

  late final _$emailErrorsAtom =
      Atom(name: '_UserInvitationFormStateBase.emailErrors', context: context);

  @override
  List<int> get emailErrors {
    _$emailErrorsAtom.reportRead();
    return super.emailErrors;
  }

  @override
  set emailErrors(List<int> value) {
    _$emailErrorsAtom.reportWrite(value, super.emailErrors, () {
      super.emailErrors = value;
    });
  }

  late final _$nicknameErrorsAtom = Atom(
      name: '_UserInvitationFormStateBase.nicknameErrors', context: context);

  @override
  List<int> get nicknameErrors {
    _$nicknameErrorsAtom.reportRead();
    return super.nicknameErrors;
  }

  @override
  set nicknameErrors(List<int> value) {
    _$nicknameErrorsAtom.reportWrite(value, super.nicknameErrors, () {
      super.nicknameErrors = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_UserInvitationFormStateBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$tgCodeAtom =
      Atom(name: '_UserInvitationFormStateBase.tgCode', context: context);

  @override
  String? get tgCode {
    _$tgCodeAtom.reportRead();
    return super.tgCode;
  }

  @override
  set tgCode(String? value) {
    _$tgCodeAtom.reportWrite(value, super.tgCode, () {
      super.tgCode = value;
    });
  }

  late final _$isNicknameAvailableAtom = Atom(
      name: '_UserInvitationFormStateBase.isNicknameAvailable',
      context: context);

  @override
  bool? get isNicknameAvailable {
    _$isNicknameAvailableAtom.reportRead();
    return super.isNicknameAvailable;
  }

  @override
  set isNicknameAvailable(bool? value) {
    _$isNicknameAvailableAtom.reportWrite(value, super.isNicknameAvailable, () {
      super.isNicknameAvailable = value;
    });
  }

  late final _$isLoadingNicknameAvailabilityAtom = Atom(
      name: '_UserInvitationFormStateBase.isLoadingNicknameAvailability',
      context: context);

  @override
  bool get isLoadingNicknameAvailability {
    _$isLoadingNicknameAvailabilityAtom.reportRead();
    return super.isLoadingNicknameAvailability;
  }

  @override
  set isLoadingNicknameAvailability(bool value) {
    _$isLoadingNicknameAvailabilityAtom
        .reportWrite(value, super.isLoadingNicknameAvailability, () {
      super.isLoadingNicknameAvailability = value;
    });
  }

  late final _$isEmailAvailableAtom = Atom(
      name: '_UserInvitationFormStateBase.isEmailAvailable', context: context);

  @override
  bool? get isEmailAvailable {
    _$isEmailAvailableAtom.reportRead();
    return super.isEmailAvailable;
  }

  @override
  set isEmailAvailable(bool? value) {
    _$isEmailAvailableAtom.reportWrite(value, super.isEmailAvailable, () {
      super.isEmailAvailable = value;
    });
  }

  late final _$isLoadingEmailAvailabilityAtom = Atom(
      name: '_UserInvitationFormStateBase.isLoadingEmailAvailability',
      context: context);

  @override
  bool get isLoadingEmailAvailability {
    _$isLoadingEmailAvailabilityAtom.reportRead();
    return super.isLoadingEmailAvailability;
  }

  @override
  set isLoadingEmailAvailability(bool value) {
    _$isLoadingEmailAvailabilityAtom
        .reportWrite(value, super.isLoadingEmailAvailability, () {
      super.isLoadingEmailAvailability = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
surname: ${surname},
avatar: ${avatar},
email: ${email},
username: ${username},
password: ${password},
isLoadingImage: ${isLoadingImage},
errors: ${errors},
emailErrors: ${emailErrors},
nicknameErrors: ${nicknameErrors},
isLoading: ${isLoading},
tgCode: ${tgCode},
isNicknameAvailable: ${isNicknameAvailable},
isLoadingNicknameAvailability: ${isLoadingNicknameAvailability},
isEmailAvailable: ${isEmailAvailable},
isLoadingEmailAvailability: ${isLoadingEmailAvailability},
canGoForwardFirst: ${canGoForwardFirst},
canGoForwardSecond: ${canGoForwardSecond}
    ''';
  }
}
