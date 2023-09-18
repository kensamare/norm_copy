// Dart imports:
import 'dart:async';
import 'dart:developer';
import 'dart:io';

// Package imports:
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:norm/data/local_storage/app_localization_local_storage/app_localization_local_storage.dart';
import 'package:norm/data/local_storage/app_settings_local_storage/app_settings_local_storage.dart';
import 'package:norm/data/local_storage/app_theme_local_storage/app_theme_local_storage.dart';
import 'package:norm/data/local_storage/app_user_sessions_local_storage/app_user_sessions_local_storage.dart';
import 'package:norm/data/local_storage/app_version_local_storage/app_version_local_storage.dart';
import 'package:norm/data/local_storage/local_storage_interface.dart';
import 'package:norm/internal/states/interfaces/initializable.dart';

class LocalStorage implements Initializable {
  static const String _BASE_PATH = '/6hhn9kxd4nbh6k1v298m0_';

  /// Hive boxes.
  static final List<LocalStorageInterface> _instances = [
    AppVersionLocalStorage(),
    AppThemeLocalStorage(),
    AppLocalizationLocalStorage(),
    AppSettingsLocalStorage(),
    AppUserSessionsLocalStorage(),
  ];

  /// Initializing subinstances of HIVE boxes.
  Future<void> _initializeInstances() async {
    for (LocalStorageInterface instance in _instances) {
      await instance.initialize();

      log('Box ${instance.runtimeType} has been initialized!', name: 'HIVE');
    }
  }

  /// Initializes current app local storage.
  @override
  Future<void> initialize() async {
    // Current application documents directory.
    final Directory directory = await getApplicationDocumentsDirectory();

    // Path where the data will be stored.
    final String path = directory.path + _BASE_PATH;

    // Initializing HIVE database.
    Hive.init(path);
    log('Local storage has been initialized!', name: 'HIVE');

    // Initializing subinstances of HIVE database.
    await _initializeInstances();
  }
}
