// Dart imports:
import 'dart:async';
import 'dart:convert';

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:norm/data/local_storage/local_storage_interface.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/services/settings/settings_details.dart';

class AppSettingsLocalStorage implements LocalStorageInterface {
  static const String _SETTINGS_KEY = 'settings_key';

  @override
  final String boxName = 'app_settings_box';

  @override
  Box get box => Hive.box(boxName);

  /// Cached app settings.
  SettingsDetails? get settings {
    final String? data = box.get(_SETTINGS_KEY);
    if (data == null) return null;

    return SettingsDetails.fromJson(jsonDecode(data));
  }

  /// Caches app settings.
  void cacheSettings(SettingsDetails settings) => unawaited(
        box.put(_SETTINGS_KEY, jsonEncode(settings.toJson())),
      );

  @override
  Future<void> initialize() async {
    service.registerSingleton<AppSettingsLocalStorage>(this);
    await Hive.openBox(boxName);
  }
}
