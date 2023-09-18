// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'brand_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$BrandState on _BrandStateBase, Store {
  late final _$brandAtom =
      Atom(name: '_BrandStateBase.brand', context: context);

  @override
  Brand? get brand {
    _$brandAtom.reportRead();
    return super.brand;
  }

  @override
  set brand(Brand? value) {
    _$brandAtom.reportWrite(value, super.brand, () {
      super.brand = value;
    });
  }

  late final _$isLoadingBrandAtom =
      Atom(name: '_BrandStateBase.isLoadingBrand', context: context);

  @override
  bool get isLoadingBrand {
    _$isLoadingBrandAtom.reportRead();
    return super.isLoadingBrand;
  }

  @override
  set isLoadingBrand(bool value) {
    _$isLoadingBrandAtom.reportWrite(value, super.isLoadingBrand, () {
      super.isLoadingBrand = value;
    });
  }

  @override
  String toString() {
    return '''
brand: ${brand},
isLoadingBrand: ${isLoadingBrand}
    ''';
  }
}
