// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'connect_telegram_and_phone_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ConnectTelegramAndPhoneState
    on _ConnectTelegramAndPhoneStateBase, Store {
  late final _$connectedTelegramAtom = Atom(
      name: '_ConnectTelegramAndPhoneStateBase.connectedTelegram',
      context: context);

  @override
  bool get connectedTelegram {
    _$connectedTelegramAtom.reportRead();
    return super.connectedTelegram;
  }

  @override
  set connectedTelegram(bool value) {
    _$connectedTelegramAtom.reportWrite(value, super.connectedTelegram, () {
      super.connectedTelegram = value;
    });
  }

  late final _$connectedPhoneAtom = Atom(
      name: '_ConnectTelegramAndPhoneStateBase.connectedPhone',
      context: context);

  @override
  bool get connectedPhone {
    _$connectedPhoneAtom.reportRead();
    return super.connectedPhone;
  }

  @override
  set connectedPhone(bool value) {
    _$connectedPhoneAtom.reportWrite(value, super.connectedPhone, () {
      super.connectedPhone = value;
    });
  }

  @override
  String toString() {
    return '''
connectedTelegram: ${connectedTelegram},
connectedPhone: ${connectedPhone}
    ''';
  }
}
