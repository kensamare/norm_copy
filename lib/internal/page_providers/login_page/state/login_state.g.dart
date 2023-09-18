// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LoginState on _LoginStateBase, Store {
  Computed<bool>? _$canGoForwardComputed;

  @override
  bool get canGoForward =>
      (_$canGoForwardComputed ??= Computed<bool>(() => super.canGoForward,
              name: '_LoginStateBase.canGoForward'))
          .value;

  late final _$loginAtom =
      Atom(name: '_LoginStateBase.login', context: context);

  @override
  String get login {
    _$loginAtom.reportRead();
    return super.login;
  }

  @override
  set login(String value) {
    _$loginAtom.reportWrite(value, super.login, () {
      super.login = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_LoginStateBase.password', context: context);

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

  late final _$errorsAtom =
      Atom(name: '_LoginStateBase.errors', context: context);

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

  late final _$isLoadingAtom =
      Atom(name: '_LoginStateBase.isLoading', context: context);

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
login: ${login},
password: ${password},
errors: ${errors},
isLoading: ${isLoading},
canGoForward: ${canGoForward}
    ''';
  }
}
