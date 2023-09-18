// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:norm/data/local_storage/local_storage_interface.dart';
import 'package:norm/internal/services/service_locator.dart';

class AppThemeLocalStorage implements LocalStorageInterface {
  static const String _THEME_KEY = 'theme_key';

  @override
  final String boxName = 'app_theme_box';

  @override
  Box get box => Hive.box(boxName);

  @override
  Future<void> initialize() async {
    service.registerSingleton<AppThemeLocalStorage>(this);
    await Hive.openBox(boxName);
  }
}
