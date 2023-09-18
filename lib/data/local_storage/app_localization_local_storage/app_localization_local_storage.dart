// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:norm/data/local_storage/local_storage_interface.dart';
import 'package:norm/internal/services/service_locator.dart';

class AppLocalizationLocalStorage implements LocalStorageInterface {
  static const String _LOCALIZATION_KEY = 'localization_key';

  @override
  final String boxName = 'app_localization_box';

  @override
  Box get box => Hive.box(boxName);

  /// Cached app version.
  String? get localization {
    final String? data = box.get(_LOCALIZATION_KEY);

    return data;
  }

  void cacheLocale(String locale) {
    box.put(_LOCALIZATION_KEY, locale);
  }

  @override
  Future<void> initialize() async {
    service.registerSingleton<AppLocalizationLocalStorage>(this);
    await Hive.openBox(boxName);
  }
}
