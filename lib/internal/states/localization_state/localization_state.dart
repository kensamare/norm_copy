// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:intl/intl_standalone.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/data/local_storage/app_localization_local_storage/app_localization_local_storage.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

// ignore: depend_on_referenced_packages

class LocalizationState = _LocalizationStateBase with _$LocalizationState;

abstract class _LocalizationStateBase with Store implements Initializable {
  /// Localization storage.
  AppLocalizationLocalStorage get _localizationStorage => service<AppLocalizationLocalStorage>();

  /// System language.
  @observable
  Locale? _systemLocale;

  /// Saved localization.
  @observable
  Locale? _savedLocale;

  /// Localization which will be used in app.
  @computed
  Locale? get locale => _savedLocale ?? _systemLocale;

  /// Равна ли локализация аргументу *languageCode*.
  @action
  bool isActive(String languageCode) => languageCode == locale?.languageCode;

  /// Setting new preffered locale.
  @action
  Future<void> setLocale(String languageCode) async {
    _savedLocale = Locale.fromSubtags(languageCode: languageCode);
    _localizationStorage.cacheLocale(_savedLocale.toString());
  }

  @override
  Future<void> initialize() async {
    // Defining system language.
    _systemLocale = Locale.fromSubtags(languageCode: await findSystemLocale());

    // Getting chosen (saved) language.
    if (!_localizationStorage.localization.isBlank) {
      _savedLocale = Locale.fromSubtags(languageCode: _localizationStorage.localization!);
    }
  }
}

mixin _$LocalizationState on _LocalizationStateBase, Store {
  Computed<dynamic>? _$localeComputed;

  @override
  Locale? get locale =>
      (_$localeComputed ??= Computed<Locale?>(() => super.locale, name: '_LocalizationStateBase.locale')).value;

  late final _$_systemLocaleAtom = Atom(name: '_LocalizationStateBase._systemLocale', context: context);

  @override
  Locale? get _systemLocale {
    _$_systemLocaleAtom.reportRead();
    return super._systemLocale;
  }

  @override
  set _systemLocale(Locale? value) {
    _$_systemLocaleAtom.reportWrite(value, super._systemLocale, () {
      super._systemLocale = value;
    });
  }

  late final _$_savedLocaleAtom = Atom(name: '_LocalizationStateBase._savedLocale', context: context);

  @override
  Locale? get _savedLocale {
    _$_savedLocaleAtom.reportRead();
    return super._savedLocale;
  }

  @override
  set _savedLocale(Locale? value) {
    _$_savedLocaleAtom.reportWrite(value, super._savedLocale, () {
      super._savedLocale = value;
    });
  }

  late final _$setLocaleAsyncAction = AsyncAction('_LocalizationStateBase.setLocale', context: context);

  @override
  Future<void> setLocale(String languageCode) {
    return _$setLocaleAsyncAction.run(() => super.setLocale(languageCode));
  }

  late final _$_LocalizationStateBaseActionController =
      ActionController(name: '_LocalizationStateBase', context: context);

  @override
  bool isActive(String languageCode) {
    final _$actionInfo = _$_LocalizationStateBaseActionController.startAction(name: '_LocalizationStateBase.isActive');
    try {
      return super.isActive(languageCode);
    } finally {
      _$_LocalizationStateBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
locale: ${locale}
    ''';
  }
}
