// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_item_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CreateItemState on _CreateItemStateBase, Store {
  Computed<bool>? _$canAddComputed;

  @override
  bool get canAdd => (_$canAddComputed ??= Computed<bool>(() => super.canAdd,
          name: '_CreateItemStateBase.canAdd'))
      .value;

  late final _$titleAtom =
      Atom(name: '_CreateItemStateBase.title', context: context);

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

  late final _$linkAtom =
      Atom(name: '_CreateItemStateBase.link', context: context);

  @override
  String? get link {
    _$linkAtom.reportRead();
    return super.link;
  }

  @override
  set link(String? value) {
    _$linkAtom.reportWrite(value, super.link, () {
      super.link = value;
    });
  }

  late final _$descriptionAtom =
      Atom(name: '_CreateItemStateBase.description', context: context);

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
      Atom(name: '_CreateItemStateBase.position', context: context);

  @override
  PickedLocation? get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(PickedLocation? value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$onlineAtom =
      Atom(name: '_CreateItemStateBase.online', context: context);

  @override
  bool get online {
    _$onlineAtom.reportRead();
    return super.online;
  }

  @override
  set online(bool value) {
    _$onlineAtom.reportWrite(value, super.online, () {
      super.online = value;
    });
  }

  late final _$photosAtom =
      Atom(name: '_CreateItemStateBase.photos', context: context);

  @override
  ObservableList<String> get photos {
    _$photosAtom.reportRead();
    return super.photos;
  }

  @override
  set photos(ObservableList<String> value) {
    _$photosAtom.reportWrite(value, super.photos, () {
      super.photos = value;
    });
  }

  late final _$isLoadingImagesAtom =
      Atom(name: '_CreateItemStateBase.isLoadingImages', context: context);

  @override
  bool get isLoadingImages {
    _$isLoadingImagesAtom.reportRead();
    return super.isLoadingImages;
  }

  @override
  set isLoadingImages(bool value) {
    _$isLoadingImagesAtom.reportWrite(value, super.isLoadingImages, () {
      super.isLoadingImages = value;
    });
  }

  @override
  String toString() {
    return '''
title: ${title},
link: ${link},
description: ${description},
position: ${position},
online: ${online},
photos: ${photos},
isLoadingImages: ${isLoadingImages},
canAdd: ${canAdd}
    ''';
  }
}
