// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'speciality_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SpecialityState on _SpecialityStateBase, Store {
  late final _$specialityAtom =
      Atom(name: '_SpecialityStateBase.speciality', context: context);

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

  late final _$isLoadingSpecialityAtom =
      Atom(name: '_SpecialityStateBase.isLoadingSpeciality', context: context);

  @override
  bool get isLoadingSpeciality {
    _$isLoadingSpecialityAtom.reportRead();
    return super.isLoadingSpeciality;
  }

  @override
  set isLoadingSpeciality(bool value) {
    _$isLoadingSpecialityAtom.reportWrite(value, super.isLoadingSpeciality, () {
      super.isLoadingSpeciality = value;
    });
  }

  @override
  String toString() {
    return '''
speciality: ${speciality},
isLoadingSpeciality: ${isLoadingSpeciality}
    ''';
  }
}
