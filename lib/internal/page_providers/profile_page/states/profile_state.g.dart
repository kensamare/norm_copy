// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProfileState on _ProfileStateBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??=
          Computed<User?>(() => super.user, name: '_ProfileStateBase.user'))
      .value;

  late final _$_userAtom =
      Atom(name: '_ProfileStateBase._user', context: context);

  @override
  User? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(User? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$isLoadingUserAtom =
      Atom(name: '_ProfileStateBase.isLoadingUser', context: context);

  @override
  bool get isLoadingUser {
    _$isLoadingUserAtom.reportRead();
    return super.isLoadingUser;
  }

  @override
  set isLoadingUser(bool value) {
    _$isLoadingUserAtom.reportWrite(value, super.isLoadingUser, () {
      super.isLoadingUser = value;
    });
  }

  @override
  String toString() {
    return '''
isLoadingUser: ${isLoadingUser},
user: ${user}
    ''';
  }
}
