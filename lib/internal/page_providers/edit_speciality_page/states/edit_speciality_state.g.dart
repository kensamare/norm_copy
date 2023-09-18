// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_speciality_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditSpecialityState on _EditSpecialityStateBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(() => super.canSave,
          name: '_EditSpecialityStateBase.canSave'))
      .value;

  late final _$specialityAtom =
      Atom(name: '_EditSpecialityStateBase.speciality', context: context);

  @override
  Speciality get speciality {
    _$specialityAtom.reportRead();
    return super.speciality;
  }

  @override
  set speciality(Speciality value) {
    _$specialityAtom.reportWrite(value, super.speciality, () {
      super.speciality = value;
    });
  }

  late final _$specAtom =
      Atom(name: '_EditSpecialityStateBase.spec', context: context);

  @override
  Speciality? get spec {
    _$specAtom.reportRead();
    return super.spec;
  }

  @override
  set spec(Speciality? value) {
    _$specAtom.reportWrite(value, super.spec, () {
      super.spec = value;
    });
  }

  late final _$isLoadingImageAtom =
      Atom(name: '_EditSpecialityStateBase.isLoadingImage', context: context);

  @override
  bool get isLoadingImage {
    _$isLoadingImageAtom.reportRead();
    return super.isLoadingImage;
  }

  @override
  set isLoadingImage(bool value) {
    _$isLoadingImageAtom.reportWrite(value, super.isLoadingImage, () {
      super.isLoadingImage = value;
    });
  }

  late final _$isDeletingAtom =
      Atom(name: '_EditSpecialityStateBase.isDeleting', context: context);

  @override
  bool get isDeleting {
    _$isDeletingAtom.reportRead();
    return super.isDeleting;
  }

  @override
  set isDeleting(bool value) {
    _$isDeletingAtom.reportWrite(value, super.isDeleting, () {
      super.isDeleting = value;
    });
  }

  late final _$specialityTitleAtom =
      Atom(name: '_EditSpecialityStateBase.specialityTitle', context: context);

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
      Atom(name: '_EditSpecialityStateBase.level', context: context);

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

  late final _$fromAtom =
      Atom(name: '_EditSpecialityStateBase.from', context: context);

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

  late final _$careerAtom =
      Atom(name: '_EditSpecialityStateBase.career', context: context);

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
      Atom(name: '_EditSpecialityStateBase.description', context: context);

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

  late final _$isSavingAtom =
      Atom(name: '_EditSpecialityStateBase.isSaving', context: context);

  @override
  bool get isSaving {
    _$isSavingAtom.reportRead();
    return super.isSaving;
  }

  @override
  set isSaving(bool value) {
    _$isSavingAtom.reportWrite(value, super.isSaving, () {
      super.isSaving = value;
    });
  }

  late final _$suggestedSpecsAtom =
      Atom(name: '_EditSpecialityStateBase.suggestedSpecs', context: context);

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
spec: ${spec},
isLoadingImage: ${isLoadingImage},
isDeleting: ${isDeleting},
specialityTitle: ${specialityTitle},
level: ${level},
from: ${from},
career: ${career},
description: ${description},
isSaving: ${isSaving},
suggestedSpecs: ${suggestedSpecs},
canSave: ${canSave}
    ''';
  }
}
