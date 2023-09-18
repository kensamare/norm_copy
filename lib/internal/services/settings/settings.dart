// Flutter imports:
import 'package:flutter/services.dart';

// Package imports:
import 'package:firebase_core/firebase_core.dart';

// Project imports:
import 'package:norm/data/local_storage/app_settings_local_storage/app_settings_local_storage.dart';
import 'package:norm/domain/models/app_version/app_version.dart';
import 'package:norm/internal/services/n_logger/n_logger.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/services/settings/settings_details.dart';
import 'package:norm/internal/services/version_handler.dart';

class Settings {
  /// Application name.
  static const String appName = 'norm';

  /// App size according to UI.
  static const Size appReferenceSize = Size(375, 812);

  /// Backend settings.
  static final BackendSettings backendSettings = BackendSettings();

  /// The url of terms of use.
  static const String termsOfUseUrl = 'https://norm.gg/legal';

  /// App version handler.
  final VersionHandler _versionHandler = VersionHandler();

  /// Current app version.
  late AppVersion _appVersion;

  /// Current app version.
  AppVersion get appVersion => _appVersion;

  /// Settings details. e.g. First time in app or not.
  late SettingsDetails _settingsDetails;

  /// Settings details. e.g. First time in app or not.
  SettingsDetails get details => _settingsDetails;

  /// App settings local storage.
  AppSettingsLocalStorage get _settingsLocalStorage => service<AppSettingsLocalStorage>();

  /// Gets current app version.
  Future<void> _initializeVersion() async {
    // Takes current and previous app versions, compares them and performs logic based on those values.
    // Returns current app version.
    _appVersion = await _versionHandler.initializeVersion();
  }

  /// Gets cached settings details.
  Future<void> _initializeSettingsDetails() async {
    _settingsDetails = _settingsLocalStorage.settings ?? const SettingsDetails();
  }

  /// Sets preffered orientation.
  Future<void> _setPrefferedOrientation() async {
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<void> _initializeFirebase() async {
    try {
      await Firebase.initializeApp();
    } catch (e, s) {
      NLogger.handleException(e, s);
    }
  }

  /// Initializes app settings.
  Future<void> initialize() async {
    await Future.wait([
      _initializeFirebase(),
      _initializeSettingsDetails(),
      _initializeVersion(),
      _setPrefferedOrientation(),
    ]);
  }
}

/// Struct to store backend settings.
class BackendSettings {
  BackendSettings();

  static const String defaultDomain = 'tgapp.live';

  /// Request retry attempts.
  final int retries = 3;

  /// Current backend domain.
  String domain = defaultDomain;

  /// Requests base url.
  String get backendUrl => 'https://api.$domain';

  void setDomain(String value) => domain = value;
}
