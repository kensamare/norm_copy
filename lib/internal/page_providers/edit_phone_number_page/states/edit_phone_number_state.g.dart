// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_phone_number_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditPhoneNumberState on _EditPhoneNumberStateBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??= Computed<User?>(() => super.user,
          name: '_EditPhoneNumberStateBase.user'))
      .value;

  @override
  String toString() {
    return '''
user: ${user}
    ''';
  }
}