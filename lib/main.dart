// Flutter imports:
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:sentry_flutter/sentry_flutter.dart';

// Project imports:
import 'package:norm/data/api/api.dart';
import 'package:norm/data/api/repositories/auth_repository.dart';
import 'package:norm/data/api/repositories/brands_repository.dart';
import 'package:norm/data/api/repositories/circles_repository.dart';
import 'package:norm/data/api/repositories/database_repository.dart';
import 'package:norm/data/api/repositories/invites_repository.dart';
import 'package:norm/data/api/repositories/items_repository.dart';
import 'package:norm/data/api/repositories/media_repository.dart';
import 'package:norm/data/api/repositories/phone_repository.dart';
import 'package:norm/data/api/repositories/portfolio_repository.dart';
import 'package:norm/data/api/repositories/specs_repository.dart';
import 'package:norm/data/api/repositories/users_repository.dart';
import 'package:norm/data/local_storage/local_storage.dart';
import 'package:norm/internal/application.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/services/settings/settings.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/states/country_codes_state/country_codes_state.dart';
import 'package:norm/internal/states/localization_state/localization_state.dart';
import 'package:norm/internal/states/phone_confirmation_state/phone_confirmation_state.dart';
import 'package:norm/internal/states/themes_state/themes_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Google maps key: AIzaSyAG7m0axWbErEo4b8iOeadJNelRa_HZmsw.

  // If app is runned in debug mode then we don't need to send errors to Sentry.
  if (kDebugMode) {
    return _runApp();
  } else {
    const String SENTRY_KEY =
        'https://be8cb5e86cd241d8bc038c8ad13781d7@o4504372168425472.ingest.sentry.io/4504413970169856';

    return await SentryFlutter.init(
      (options) {
        options.dsn = SENTRY_KEY;
        // Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring.
        // We recommend adjusting this value in production.
        options.tracesSampleRate = 1.0;
      },
      appRunner: () => _runApp(),
    );
  }
}

Future<void> _runApp() async {
  // Api.
  final Api api = Api(
    baseUrl: Settings.backendSettings.backendUrl,
    retries: Settings.backendSettings.retries,
  );

  service.registerSingleton(api);

  // Local storage.
  final LocalStorage storage = LocalStorage();
  await storage.initialize();
  service.registerSingleton(storage);

  // Settings.
  final Settings settings = Settings();
  await settings.initialize();
  service.registerSingleton(settings);

  // Router.
  final AppRouter appRouter = AppRouter();
  service.registerSingleton(appRouter);

  // States.
  service.registerLazySingleton(() => AuthState()..initialize());
  service.registerLazySingleton(() => ThemesState());
  service.registerLazySingleton(() => LocalizationState()..initialize());

  // Register country codes state instantly for instant initialization.
  service.registerSingleton(CountryCodesState()..initialize());

  // Register phone confirmation state instantly for instant initialization.
  service.registerSingleton(PhoneConfirmationState()..initialize());

  // Repositories.
  service.registerLazySingleton(() => AuthRepository());
  service.registerLazySingleton(() => MediaRepository());
  service.registerLazySingleton(() => SpecsRepository());
  service.registerLazySingleton(() => UsersRepository());
  service.registerLazySingleton(() => BrandRepository());
  service.registerLazySingleton(() => PhoneRepository());
  service.registerLazySingleton(() => CirclesRepository());
  service.registerLazySingleton(() => InvitesRepository());
  service.registerLazySingleton(() => DatabaseRepository());
  service.registerLazySingleton(() => PortfolioRepository());
  service.registerLazySingleton(() => ItemsRepository());

  runApp(const Application());
}
