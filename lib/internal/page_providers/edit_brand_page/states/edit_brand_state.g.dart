// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'edit_brand_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$EditBrandState on _EditBrandStateBase, Store {
  Computed<bool>? _$canSaveComputed;

  @override
  bool get canSave => (_$canSaveComputed ??= Computed<bool>(() => super.canSave,
          name: '_EditBrandStateBase.canSave'))
      .value;

  late final _$brandAtom =
      Atom(name: '_EditBrandStateBase.brand', context: context);

  @override
  Brand get brand {
    _$brandAtom.reportRead();
    return super.brand;
  }

  @override
  set brand(Brand value) {
    _$brandAtom.reportWrite(value, super.brand, () {
      super.brand = value;
    });
  }

  late final _$nicknameErrorsAtom =
      Atom(name: '_EditBrandStateBase.nicknameErrors', context: context);

  @override
  List<int> get nicknameErrors {
    _$nicknameErrorsAtom.reportRead();
    return super.nicknameErrors;
  }

  @override
  set nicknameErrors(List<int> value) {
    _$nicknameErrorsAtom.reportWrite(value, super.nicknameErrors, () {
      super.nicknameErrors = value;
    });
  }

  late final _$isLoadingNicknameAvailabilityAtom = Atom(
      name: '_EditBrandStateBase.isLoadingNicknameAvailability',
      context: context);

  @override
  bool get isLoadingNicknameAvailability {
    _$isLoadingNicknameAvailabilityAtom.reportRead();
    return super.isLoadingNicknameAvailability;
  }

  @override
  set isLoadingNicknameAvailability(bool value) {
    _$isLoadingNicknameAvailabilityAtom
        .reportWrite(value, super.isLoadingNicknameAvailability, () {
      super.isLoadingNicknameAvailability = value;
    });
  }

  late final _$isNicknameAvailableAtom =
      Atom(name: '_EditBrandStateBase.isNicknameAvailable', context: context);

  @override
  bool? get isNicknameAvailable {
    _$isNicknameAvailableAtom.reportRead();
    return super.isNicknameAvailable;
  }

  @override
  set isNicknameAvailable(bool? value) {
    _$isNicknameAvailableAtom.reportWrite(value, super.isNicknameAvailable, () {
      super.isNicknameAvailable = value;
    });
  }

  late final _$isLoadingImageAtom =
      Atom(name: '_EditBrandStateBase.isLoadingImage', context: context);

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

  late final _$nicknameAtom =
      Atom(name: '_EditBrandStateBase.nickname', context: context);

  @override
  String get nickname {
    _$nicknameAtom.reportRead();
    return super.nickname;
  }

  @override
  set nickname(String value) {
    _$nicknameAtom.reportWrite(value, super.nickname, () {
      super.nickname = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_EditBrandStateBase.description', context: context);

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

  late final _$titleAtom =
      Atom(name: '_EditBrandStateBase.title', context: context);

  @override
  String? get title {
    _$titleAtom.reportRead();
    return super.title;
  }

  @override
  set title(String? value) {
    _$titleAtom.reportWrite(value, super.title, () {
      super.title = value;
    });
  }

  late final _$categoryAtom =
      Atom(name: '_EditBrandStateBase.category', context: context);

  @override
  BrandCategory? get category {
    _$categoryAtom.reportRead();
    return super.category;
  }

  @override
  set category(BrandCategory? value) {
    _$categoryAtom.reportWrite(value, super.category, () {
      super.category = value;
    });
  }

  late final _$categoryTitleAtom =
      Atom(name: '_EditBrandStateBase.categoryTitle', context: context);

  @override
  String? get categoryTitle {
    _$categoryTitleAtom.reportRead();
    return super.categoryTitle;
  }

  @override
  set categoryTitle(String? value) {
    _$categoryTitleAtom.reportWrite(value, super.categoryTitle, () {
      super.categoryTitle = value;
    });
  }

  late final _$urlAtom =
      Atom(name: '_EditBrandStateBase.url', context: context);

  @override
  String? get url {
    _$urlAtom.reportRead();
    return super.url;
  }

  @override
  set url(String? value) {
    _$urlAtom.reportWrite(value, super.url, () {
      super.url = value;
    });
  }

  late final _$suggestedBrandCategoriesAtom = Atom(
      name: '_EditBrandStateBase.suggestedBrandCategories', context: context);

  @override
  ObservableList<BrandCategory> get suggestedBrandCategories {
    _$suggestedBrandCategoriesAtom.reportRead();
    return super.suggestedBrandCategories;
  }

  @override
  set suggestedBrandCategories(ObservableList<BrandCategory> value) {
    _$suggestedBrandCategoriesAtom
        .reportWrite(value, super.suggestedBrandCategories, () {
      super.suggestedBrandCategories = value;
    });
  }

  late final _$isSavingAtom =
      Atom(name: '_EditBrandStateBase.isSaving', context: context);

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

  late final _$isDeletingAtom =
      Atom(name: '_EditBrandStateBase.isDeleting', context: context);

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

  @override
  String toString() {
    return '''
brand: ${brand},
nicknameErrors: ${nicknameErrors},
isLoadingNicknameAvailability: ${isLoadingNicknameAvailability},
isNicknameAvailable: ${isNicknameAvailable},
isLoadingImage: ${isLoadingImage},
nickname: ${nickname},
description: ${description},
title: ${title},
category: ${category},
categoryTitle: ${categoryTitle},
url: ${url},
suggestedBrandCategories: ${suggestedBrandCategories},
isSaving: ${isSaving},
isDeleting: ${isDeleting},
canSave: ${canSave}
    ''';
  }
}
