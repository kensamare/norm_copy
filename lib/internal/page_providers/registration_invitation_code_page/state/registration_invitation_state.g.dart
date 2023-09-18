// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'registration_invitation_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegistrationInvitationState on _RegistrationInvitationStateBase, Store {
  Computed<bool>? _$filledCodeComputed;

  @override
  bool get filledCode =>
      (_$filledCodeComputed ??= Computed<bool>(() => super.filledCode,
              name: '_RegistrationInvitationStateBase.filledCode'))
          .value;

  late final _$invitationCodeAtom = Atom(
      name: '_RegistrationInvitationStateBase.invitationCode',
      context: context);

  @override
  String get invitationCode {
    _$invitationCodeAtom.reportRead();
    return super.invitationCode;
  }

  @override
  set invitationCode(String value) {
    _$invitationCodeAtom.reportWrite(value, super.invitationCode, () {
      super.invitationCode = value;
    });
  }

  late final _$errorsAtom =
      Atom(name: '_RegistrationInvitationStateBase.errors', context: context);

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

  late final _$agreedToTermsAtom = Atom(
      name: '_RegistrationInvitationStateBase.agreedToTerms', context: context);

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

  late final _$isLoadingAtom = Atom(
      name: '_RegistrationInvitationStateBase.isLoading', context: context);

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
invitationCode: ${invitationCode},
errors: ${errors},
agreedToTerms: ${agreedToTerms},
isLoading: ${isLoading},
filledCode: ${filledCode}
    ''';
  }
}
