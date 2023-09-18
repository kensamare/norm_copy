// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_career_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateCareerState on _CreateCareerStateBase, Store {
  Computed<bool>? _$canPopWithResultComputed;

  @override
  bool get canPopWithResult => (_$canPopWithResultComputed ??= Computed<bool>(
          () => super.canPopWithResult,
          name: '_CreateCareerStateBase.canPopWithResult'))
      .value;

  late final _$descriptionAtom =
      Atom(name: '_CreateCareerStateBase.description', context: context);

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

  late final _$positionAtom =
      Atom(name: '_CreateCareerStateBase.position', context: context);

  @override
  String? get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(String? value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$brandAtom =
      Atom(name: '_CreateCareerStateBase.brand', context: context);

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

  late final _$brandTitleAtom =
      Atom(name: '_CreateCareerStateBase.brandTitle', context: context);

  @override
  String? get brandTitle {
    _$brandTitleAtom.reportRead();
    return super.brandTitle;
  }

  @override
  set brandTitle(String? value) {
    _$brandTitleAtom.reportWrite(value, super.brandTitle, () {
      super.brandTitle = value;
    });
  }

  late final _$rangeAtom =
      Atom(name: '_CreateCareerStateBase.range', context: context);

  @override
  DateTimeRange? get range {
    _$rangeAtom.reportRead();
    return super.range;
  }

  @override
  set range(DateTimeRange? value) {
    _$rangeAtom.reportWrite(value, super.range, () {
      super.range = value;
    });
  }

  late final _$suggestedBrandsAtom =
      Atom(name: '_CreateCareerStateBase.suggestedBrands', context: context);

  @override
  ObservableList<Brand> get suggestedBrands {
    _$suggestedBrandsAtom.reportRead();
    return super.suggestedBrands;
  }

  @override
  set suggestedBrands(ObservableList<Brand> value) {
    _$suggestedBrandsAtom.reportWrite(value, super.suggestedBrands, () {
      super.suggestedBrands = value;
    });
  }

  @override
  String toString() {
    return '''
description: ${description},
position: ${position},
brand: ${brand},
brandTitle: ${brandTitle},
range: ${range},
suggestedBrands: ${suggestedBrands},
canPopWithResult: ${canPopWithResult}
    ''';
  }
}
