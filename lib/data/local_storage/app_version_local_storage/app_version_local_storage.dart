// Dart imports:
import 'dart:async';

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:norm/data/local_storage/local_storage_interface.dart';
import 'package:norm/domain/models/app_version/app_version.dart';
import 'package:norm/internal/services/service_locator.dart';

class AppVersionLocalStorage implements LocalStorageInterface {
  static const String _VERSION_KEY = 'version_key';

  @override
  final String boxName = 'app_version_box';

  @override
  Box get box => Hive.box(boxName);

  /// Cached app version.
  AppVersion? get version {
    final String? data = box.get(_VERSION_KEY);
    if (data == null) return null;

    return AppVersion(data);
  }

  /// Caches app version.
  void cacheVersion(AppVersion version) => unawaited(box.put(_VERSION_KEY, version.raw));

  @override
  Future<void> initialize() async {
    service.registerSingleton<AppVersionLocalStorage>(this);
    await Hive.openBox(boxName);
  }
}
