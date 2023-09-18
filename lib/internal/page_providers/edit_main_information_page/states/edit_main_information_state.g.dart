// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_main_information_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditMainInformationState on _EditMainInformationStateBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(() => super.canSave,
          name: '_EditMainInformationStateBase.canSave'))
      .value;

  late final _$nameAtom =
      Atom(name: '_EditMainInformationStateBase.name', context: context);

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
      Atom(name: '_EditMainInformationStateBase.surname', context: context);

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

  late final _$emailAtom =
      Atom(name: '_EditMainInformationStateBase.email', context: context);

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

  late final _$nicknameAtom =
      Atom(name: '_EditMainInformationStateBase.nickname', context: context);

  @override
  String get nickname {
    _$nicknameAtom.reportRead();
    return super.nickname;
  }

  @override
  set nickname(String value) {
    _$nicknameAtom.reportWrite(value, super.nickname, () {
      super.nickname = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_EditMainInformationStateBase.description', context: context);

  @override
  String? get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String? value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  late final _$isNicknameAvailableAtom = Atom(
      name: '_EditMainInformationStateBase.isNicknameAvailable',
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
      name: '_EditMainInformationStateBase.isLoadingNicknameAvailability',
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
      name: '_EditMainInformationStateBase.isEmailAvailable', context: context);

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
      name: '_EditMainInformationStateBase.isLoadingEmailAvailability',
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

  late final _$emailErrorsAtom =
      Atom(name: '_EditMainInformationStateBase.emailErrors', context: context);

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
      name: '_EditMainInformationStateBase.nicknameErrors', context: context);

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

  late final _$isSavingAtom =
      Atom(name: '_EditMainInformationStateBase.isSaving', context: context);

  @override
  bool get isSaving {
    _$isSavingAtom.reportRead();
    return super.isSaving;
  }

  @override
  set isSaving(bool value) {
    _$isSavingAtom.reportWrite(value, super.isSaving, () {
      super.isSaving = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
surname: ${surname},
email: ${email},
nickname: ${nickname},
description: ${description},
isNicknameAvailable: ${isNicknameAvailable},
isLoadingNicknameAvailability: ${isLoadingNicknameAvailability},
isEmailAvailable: ${isEmailAvailable},
isLoadingEmailAvailability: ${isLoadingEmailAvailability},
emailErrors: ${emailErrors},
nicknameErrors: ${nicknameErrors},
isSaving: ${isSaving},
canSave: ${canSave}
    ''';
  }
}
