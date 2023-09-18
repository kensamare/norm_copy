// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_shop_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditShopState on _EditShopStateBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??=
          Computed<User?>(() => super.user, name: '_EditShopStateBase.user'))
      .value;
  Computed<List<Speciality>>? _$specialitiesComputed;

  @override
  List<Speciality> get specialities => (_$specialitiesComputed ??=
          Computed<List<Speciality>>(() => super.specialities,
              name: '_EditShopStateBase.specialities'))
      .value;

  late final _$specialityAtom =
      Atom(name: '_EditShopStateBase.speciality', context: context);

  @override
  Speciality? get speciality {
    _$specialityAtom.reportRead();
    return super.speciality;
  }

  @override
  set speciality(Speciality? value) {
    _$specialityAtom.reportWrite(value, super.speciality, () {
      super.speciality = value;
    });
  }

  late final _$itemsAtom =
      Atom(name: '_EditShopStateBase.items', context: context);

  @override
  List<Item> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(List<Item> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  @override
  String toString() {
    return '''
speciality: ${speciality},
items: ${items},
user: ${user},
specialities: ${specialities}
    ''';
  }
}
