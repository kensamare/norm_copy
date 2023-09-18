// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_request_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegistrationRequestState on _RegistrationRequestStateBase, Store {
  Computed<ObservableList<Speciality>>? _$notPickedSpecialitiesComputed;

  @override
  ObservableList<Speciality> get notPickedSpecialities =>
      (_$notPickedSpecialitiesComputed ??= Computed<ObservableList<Speciality>>(
              () => super.notPickedSpecialities,
              name: '_RegistrationRequestStateBase.notPickedSpecialities'))
          .value;
  Computed<bool>? _$canGoForwardToEmailComputed;

  @override
  bool get canGoForwardToEmail => (_$canGoForwardToEmailComputed ??=
          Computed<bool>(() => super.canGoForwardToEmail,
              name: '_RegistrationRequestStateBase.canGoForwardToEmail'))
      .value;

  late final _$nameAtom =
      Atom(name: '_RegistrationRequestStateBase.name', context: context);

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  late final _$surnameAtom =
      Atom(name: '_RegistrationRequestStateBase.surname', context: context);

  @override
  String get surname {
    _$surnameAtom.reportRead();
    return super.surname;
  }

  @override
  set surname(String value) {
    _$surnameAtom.reportWrite(value, super.surname, () {
      super.surname = value;
    });
  }

  late final _$avatarAtom =
      Atom(name: '_RegistrationRequestStateBase.avatar', context: context);

  @override
  String get avatar {
    _$avatarAtom.reportRead();
    return super.avatar;
  }

  @override
  set avatar(String value) {
    _$avatarAtom.reportWrite(value, super.avatar, () {
      super.avatar = value;
    });
  }

  late final _$emailAtom =
      Atom(name: '_RegistrationRequestStateBase.email', context: context);

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

  late final _$searchAtom =
      Atom(name: '_RegistrationRequestStateBase.search', context: context);

  @override
  String? get search {
    _$searchAtom.reportRead();
    return super.search;
  }

  @override
  set search(String? value) {
    _$searchAtom.reportWrite(value, super.search, () {
      super.search = value;
    });
  }

  late final _$agreedToTermsAtom = Atom(
      name: '_RegistrationRequestStateBase.agreedToTerms', context: context);

  @override
  bool get agreedToTerms {
    _$agreedToTermsAtom.reportRead();
    return super.agreedToTerms;
  }

  @override
  set agreedToTerms(bool value) {
    _$agreedToTermsAtom.reportWrite(value, super.agreedToTerms, () {
      super.agreedToTerms = value;
    });
  }

  late final _$isLoadingImageAtom = Atom(
      name: '_RegistrationRequestStateBase.isLoadingImage', context: context);

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

  late final _$specsErrorsAtom =
      Atom(name: '_RegistrationRequestStateBase.specsErrors', context: context);

  @override
  List<int> get specsErrors {
    _$specsErrorsAtom.reportRead();
    return super.specsErrors;
  }

  @override
  set specsErrors(List<int> value) {
    _$specsErrorsAtom.reportWrite(value, super.specsErrors, () {
      super.specsErrors = value;
    });
  }

  late final _$formErrorsAtom =
      Atom(name: '_RegistrationRequestStateBase.formErrors', context: context);

  @override
  List<int> get formErrors {
    _$formErrorsAtom.reportRead();
    return super.formErrors;
  }

  @override
  set formErrors(List<int> value) {
    _$formErrorsAtom.reportWrite(value, super.formErrors, () {
      super.formErrors = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_RegistrationRequestStateBase.isLoading', context: context);

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

  late final _$specialitiesAtom = Atom(
      name: '_RegistrationRequestStateBase.specialities', context: context);

  @override
  ObservableList<Speciality> get specialities {
    _$specialitiesAtom.reportRead();
    return super.specialities;
  }

  @override
  set specialities(ObservableList<Speciality> value) {
    _$specialitiesAtom.reportWrite(value, super.specialities, () {
      super.specialities = value;
    });
  }

  late final _$pickedSpecialitiesAtom = Atom(
      name: '_RegistrationRequestStateBase.pickedSpecialities',
      context: context);

  @override
  ObservableList<Speciality> get pickedSpecialities {
    _$pickedSpecialitiesAtom.reportRead();
    return super.pickedSpecialities;
  }

  @override
  set pickedSpecialities(ObservableList<Speciality> value) {
    _$pickedSpecialitiesAtom.reportWrite(value, super.pickedSpecialities, () {
      super.pickedSpecialities = value;
    });
  }

  @override
  String toString() {
    return '''
name: ${name},
surname: ${surname},
avatar: ${avatar},
email: ${email},
search: ${search},
agreedToTerms: ${agreedToTerms},
isLoadingImage: ${isLoadingImage},
specsErrors: ${specsErrors},
formErrors: ${formErrors},
isLoading: ${isLoading},
specialities: ${specialities},
pickedSpecialities: ${pickedSpecialities},
notPickedSpecialities: ${notPickedSpecialities},
canGoForwardToEmail: ${canGoForwardToEmail}
    ''';
  }
}
