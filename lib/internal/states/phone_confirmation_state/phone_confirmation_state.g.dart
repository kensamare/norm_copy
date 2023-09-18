// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_confirmation_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PhoneConfirmationState on _PhoneConfirmationStateBase, Store {
  Computed<bool>? _$filledCodeComputed;

  @override
  bool get filledCode =>
      (_$filledCodeComputed ??= Computed<bool>(() => super.filledCode,
              name: '_PhoneConfirmationStateBase.filledCode'))
          .value;
  Computed<String>? _$phoneComputed;

  @override
  String get phone => (_$phoneComputed ??= Computed<String>(() => super.phone,
          name: '_PhoneConfirmationStateBase.phone'))
      .value;

  late final _$countryCodeAtom =
      Atom(name: '_PhoneConfirmationStateBase.countryCode', context: context);

  @override
  CountryCode? get countryCode {
    _$countryCodeAtom.reportRead();
    return super.countryCode;
  }

  @override
  set countryCode(CountryCode? value) {
    _$countryCodeAtom.reportWrite(value, super.countryCode, () {
      super.countryCode = value;
    });
  }

  late final _$phoneNumberAtom =
      Atom(name: '_PhoneConfirmationStateBase.phoneNumber', context: context);

  @override
  String get phoneNumber {
    _$phoneNumberAtom.reportRead();
    return super.phoneNumber;
  }

  @override
  set phoneNumber(String value) {
    _$phoneNumberAtom.reportWrite(value, super.phoneNumber, () {
      super.phoneNumber = value;
    });
  }

  late final _$errorsAtom =
      Atom(name: '_PhoneConfirmationStateBase.errors', context: context);

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

  late final _$verificationCodeAtom = Atom(
      name: '_PhoneConfirmationStateBase.verificationCode', context: context);

  @override
  String get verificationCode {
    _$verificationCodeAtom.reportRead();
    return super.verificationCode;
  }

  @override
  set verificationCode(String value) {
    _$verificationCodeAtom.reportWrite(value, super.verificationCode, () {
      super.verificationCode = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_PhoneConfirmationStateBase.isLoading', context: context);

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

  @override
  String toString() {
    return '''
countryCode: ${countryCode},
phoneNumber: ${phoneNumber},
errors: ${errors},
verificationCode: ${verificationCode},
isLoading: ${isLoading},
filledCode: ${filledCode},
phone: ${phone}
    ''';
  }
}
