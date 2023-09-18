// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_brand_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateBrandState on _CreateBrandStateBase, Store {
  Computed<bool>? _$canAddComputed;

  @override
  bool get canAdd => (_$canAddComputed ??= Computed<bool>(() => super.canAdd,
          name: '_CreateBrandStateBase.canAdd'))
      .value;

  late final _$imageAtom =
      Atom(name: '_CreateBrandStateBase.image', context: context);

  @override
  String? get image {
    _$imageAtom.reportRead();
    return super.image;
  }

  @override
  set image(String? value) {
    _$imageAtom.reportWrite(value, super.image, () {
      super.image = value;
    });
  }

  late final _$nicknameAtom =
      Atom(name: '_CreateBrandStateBase.nickname', context: context);

  @override
  String? get nickname {
    _$nicknameAtom.reportRead();
    return super.nickname;
  }

  @override
  set nickname(String? value) {
    _$nicknameAtom.reportWrite(value, super.nickname, () {
      super.nickname = value;
    });
  }

  late final _$isLoadingImageAtom =
      Atom(name: '_CreateBrandStateBase.isLoadingImage', context: context);

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

  late final _$titleAtom =
      Atom(name: '_CreateBrandStateBase.title', context: context);

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
      Atom(name: '_CreateBrandStateBase.category', context: context);

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
      Atom(name: '_CreateBrandStateBase.categoryTitle', context: context);

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

  late final _$yearAtom =
      Atom(name: '_CreateBrandStateBase.year', context: context);

  @override
  int? get year {
    _$yearAtom.reportRead();
    return super.year;
  }

  @override
  set year(int? value) {
    _$yearAtom.reportWrite(value, super.year, () {
      super.year = value;
    });
  }

  late final _$nicknameErrorsAtom =
      Atom(name: '_CreateBrandStateBase.nicknameErrors', context: context);

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
      name: '_CreateBrandStateBase.isLoadingNicknameAvailability',
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
      Atom(name: '_CreateBrandStateBase.isNicknameAvailable', context: context);

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

  late final _$suggestedBrandCategoriesAtom = Atom(
      name: '_CreateBrandStateBase.suggestedBrandCategories', context: context);

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

  @override
  String toString() {
    return '''
image: ${image},
nickname: ${nickname},
isLoadingImage: ${isLoadingImage},
title: ${title},
category: ${category},
categoryTitle: ${categoryTitle},
year: ${year},
nicknameErrors: ${nicknameErrors},
isLoadingNicknameAvailability: ${isLoadingNicknameAvailability},
isNicknameAvailable: ${isNicknameAvailable},
suggestedBrandCategories: ${suggestedBrandCategories},
canAdd: ${canAdd}
    ''';
  }
}
