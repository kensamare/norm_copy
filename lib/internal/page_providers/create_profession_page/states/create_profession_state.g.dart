// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_profession_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateProfessionState on _CreateProfessionStateBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(() => super.canSave,
          name: '_CreateProfessionStateBase.canSave'))
      .value;

  late final _$specialityAtom =
      Atom(name: '_CreateProfessionStateBase.speciality', context: context);

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

  late final _$specialityTitleAtom = Atom(
      name: '_CreateProfessionStateBase.specialityTitle', context: context);

  @override
  String? get specialityTitle {
    _$specialityTitleAtom.reportRead();
    return super.specialityTitle;
  }

  @override
  set specialityTitle(String? value) {
    _$specialityTitleAtom.reportWrite(value, super.specialityTitle, () {
      super.specialityTitle = value;
    });
  }

  late final _$levelAtom =
      Atom(name: '_CreateProfessionStateBase.level', context: context);

  @override
  SpecialityLevel? get level {
    _$levelAtom.reportRead();
    return super.level;
  }

  @override
  set level(SpecialityLevel? value) {
    _$levelAtom.reportWrite(value, super.level, () {
      super.level = value;
    });
  }

  late final _$careerAtom =
      Atom(name: '_CreateProfessionStateBase.career', context: context);

  @override
  Career? get career {
    _$careerAtom.reportRead();
    return super.career;
  }

  @override
  set career(Career? value) {
    _$careerAtom.reportWrite(value, super.career, () {
      super.career = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateProfessionStateBase.description', context: context);

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

  late final _$fromAtom =
      Atom(name: '_CreateProfessionStateBase.from', context: context);

  @override
  DateTime? get from {
    _$fromAtom.reportRead();
    return super.from;
  }

  @override
  set from(DateTime? value) {
    _$fromAtom.reportWrite(value, super.from, () {
      super.from = value;
    });
  }

  late final _$suggestedSpecsAtom =
      Atom(name: '_CreateProfessionStateBase.suggestedSpecs', context: context);

  @override
  ObservableList<Speciality> get suggestedSpecs {
    _$suggestedSpecsAtom.reportRead();
    return super.suggestedSpecs;
  }

  @override
  set suggestedSpecs(ObservableList<Speciality> value) {
    _$suggestedSpecsAtom.reportWrite(value, super.suggestedSpecs, () {
      super.suggestedSpecs = value;
    });
  }

  @override
  String toString() {
    return '''
speciality: ${speciality},
specialityTitle: ${specialityTitle},
level: ${level},
career: ${career},
description: ${description},
from: ${from},
suggestedSpecs: ${suggestedSpecs},
canSave: ${canSave}
    ''';
  }
}
