// Dart imports:
import 'dart:developer';

// Package imports:
import 'package:package_info/package_info.dart';

// Project imports:
import 'package:norm/data/local_storage/app_version_local_storage/app_version_local_storage.dart';
import 'package:norm/domain/models/app_version/app_version.dart';
import 'package:norm/internal/services/service_locator.dart';

// Project imports:

class VersionHandler {
  /// App version storage.
  AppVersionLocalStorage get _appVersionStorage => service<AppVersionLocalStorage>();

  /// Backward compabilities.
  static final List<VersionBackwardCompability> _backwardCompabilities = [];

  Future<void> _handleAppVersion(AppVersion currentVersion, AppVersion? previousVersion) async {
    if (previousVersion == null) return;

    for (VersionBackwardCompability backwardCompability in _backwardCompabilities) {
      // If backward compability version is higher then current.
      if (backwardCompability.version.isHigher(previousVersion)) {
        await backwardCompability.perform();
      }
    }
  }

  /// Gets current app version.
  Future<AppVersion> initializeVersion() async {
    // Takes current application app version.
    AppVersion currentAppVersion = AppVersion(await PackageInfo.fromPlatform().then((value) => value.version));
    log('Current app version is ${currentAppVersion.raw}', name: 'VERSION');

    // Takes stored app version.
    String? previousAppVersion = _appVersionStorage.version?.raw;
    log('Cached app version is $previousAppVersion', name: 'VERSION');

    // Handles app version changes.
    _handleAppVersion(currentAppVersion, previousAppVersion == null ? null : AppVersion(previousAppVersion));

    // Caches current app version.
    _appVersionStorage.cacheVersion(currentAppVersion);

    return currentAppVersion;
  }
}

/// Backward compability interface.
abstract class VersionBackwardCompability {
  /// The version where changes appeared.
  AppVersion get version;

  /// Method to reach backward compability with that version.
  Future<void> perform();
}
