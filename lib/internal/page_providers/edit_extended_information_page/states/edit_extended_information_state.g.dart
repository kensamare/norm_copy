// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_extended_information_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditExtendedInformationState
    on _EditExtendedInformationStateBase, Store {
  Computed<User?>? _$userComputed;

  @override
  User? get user => (_$userComputed ??= Computed<User?>(() => super.user,
          name: '_EditExtendedInformationStateBase.user'))
      .value;

  late final _$languagesAtom = Atom(
      name: '_EditExtendedInformationStateBase.languages', context: context);

  @override
  ObservableList<Language> get languages {
    _$languagesAtom.reportRead();
    return super.languages;
  }

  @override
  set languages(ObservableList<Language> value) {
    _$languagesAtom.reportWrite(value, super.languages, () {
      super.languages = value;
    });
  }

  late final _$suggestedBrandsAtom = Atom(
      name: '_EditExtendedInformationStateBase.suggestedBrands',
      context: context);

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

  late final _$suggestedHobbiesAtom = Atom(
      name: '_EditExtendedInformationStateBase.suggestedHobbies',
      context: context);

  @override
  ObservableList<Hobby> get suggestedHobbies {
    _$suggestedHobbiesAtom.reportRead();
    return super.suggestedHobbies;
  }

  @override
  set suggestedHobbies(ObservableList<Hobby> value) {
    _$suggestedHobbiesAtom.reportWrite(value, super.suggestedHobbies, () {
      super.suggestedHobbies = value;
    });
  }

  late final _$suggestedAnimalsAtom = Atom(
      name: '_EditExtendedInformationStateBase.suggestedAnimals',
      context: context);

  @override
  ObservableList<Animal> get suggestedAnimals {
    _$suggestedAnimalsAtom.reportRead();
    return super.suggestedAnimals;
  }

  @override
  set suggestedAnimals(ObservableList<Animal> value) {
    _$suggestedAnimalsAtom.reportWrite(value, super.suggestedAnimals, () {
      super.suggestedAnimals = value;
    });
  }

  late final _$suggestedAnimalTypesAtom = Atom(
      name: '_EditExtendedInformationStateBase.suggestedAnimalTypes',
      context: context);

  @override
  ObservableList<AnimalType> get suggestedAnimalTypes {
    _$suggestedAnimalTypesAtom.reportRead();
    return super.suggestedAnimalTypes;
  }

  @override
  set suggestedAnimalTypes(ObservableList<AnimalType> value) {
    _$suggestedAnimalTypesAtom.reportWrite(value, super.suggestedAnimalTypes,
        () {
      super.suggestedAnimalTypes = value;
    });
  }

  @override
  String toString() {
    return '''
languages: ${languages},
suggestedBrands: ${suggestedBrands},
suggestedHobbies: ${suggestedHobbies},
suggestedAnimals: ${suggestedAnimals},
suggestedAnimalTypes: ${suggestedAnimalTypes},
user: ${user}
    ''';
  }
}
