// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pick_location_state.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PickLocationState on _PickLocationStateBase, Store {
  late final _$_controllerAtom =
      Atom(name: '_PickLocationStateBase._controller', context: context);

  @override
  GoogleMapController? get _controller {
    _$_controllerAtom.reportRead();
    return super._controller;
  }

  @override
  set _controller(GoogleMapController? value) {
    _$_controllerAtom.reportWrite(value, super._controller, () {
      super._controller = value;
    });
  }

  late final _$positionAtom =
      Atom(name: '_PickLocationStateBase.position', context: context);

  @override
  LatLng? get position {
    _$positionAtom.reportRead();
    return super.position;
  }

  @override
  set position(LatLng? value) {
    _$positionAtom.reportWrite(value, super.position, () {
      super.position = value;
    });
  }

  late final _$titleAtom =
      Atom(name: '_PickLocationStateBase.title', context: context);

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

  @override
  String toString() {
    return '''
position: ${position},
title: ${title}
    ''';
  }
}
