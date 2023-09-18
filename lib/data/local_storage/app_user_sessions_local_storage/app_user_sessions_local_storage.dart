// Dart imports:
import 'dart:convert';
import 'dart:developer';

// Package imports:
import 'package:hive/hive.dart';

// Project imports:
import 'package:norm/data/local_storage/local_storage_interface.dart';
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/service_locator.dart';

class AppUserSessionsLocalStorage implements LocalStorageInterface {
  static const String _SESSION_KEY = 'MY_SESSION_KEY';

  @override
  final String boxName = 'app_user_sessions';

  @override
  Box get box => Hive.box(boxName);

  /// Есть активные сессии.
  bool get hasSession => _session != null;

  Session? get _session {
    final String? data = box.get(_SESSION_KEY);
    if (data == null) return null;

    return Session.fromJson(jsonDecode(data) as Map<String, dynamic>);
  }

  /// Активная сессия.
  Session? get activeSession => _session;

  void remove() {
    if (_session == null) return;

    box.delete(_SESSION_KEY);
  }

  Future<void> removeAll() async => box.clear();

  /// Кэширует пользователя для текущей сессии.
  void cacheUser(User user) {
    if (activeSession == null) return;

    // Сохраняем пользователя и кэшируем сессию.
    activeSession!.setUser(user);
    cache(activeSession!);
  }

  void cache(Session session) {
    final Map<String, dynamic> data = session.toJson();
    final String encodedData = jsonEncode(data);

    // Добавляем сессию.
    box.put(_SESSION_KEY, encodedData);

    log('Current active session: ${_session?.user?.nickname.toString()}');
  }

  @override
  Future<void> initialize() async {
    service.registerLazySingleton(() => AppUserSessionsLocalStorage());
    await Hive.openBox(boxName);
  }
}
