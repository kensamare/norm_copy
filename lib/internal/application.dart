// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobx/mobx.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/services/settings/settings.dart';
import 'package:norm/internal/states/localization_state/localization_state.dart';
import 'package:norm/internal/states/themes_state/themes_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  /// Router.
  AppRouter get _appRouter => service<AppRouter>();

  /// Themes state.
  ThemesState get state => service<ThemesState>();

  /// Localization state.
  LocalizationState get localizationState => service<LocalizationState>();

  /// User chosen locale.
  Locale? _userLocale;

  @override
  void initState() {
    _userLocale = localizationState.locale;

    SchedulerBinding.instance.addPostFrameCallback((_) {
      reaction(
        (_) => localizationState.locale,
        (_) => setState(() => _userLocale = localizationState.locale),
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: NColors.transparent,
        systemNavigationBarColor: NColors.black,
      ), // this will make the app bar white
      child: ScreenUtilInit(
        designSize: Settings.appReferenceSize,
        builder: (_, __) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerDelegate: _appRouter.delegate(),
          routeInformationParser: _appRouter.defaultRouteParser(),
          title: Settings.appName,
          theme: ThemeData(
            scaffoldBackgroundColor: NColors.white,
            fontFamily: 'Golos',
          ),
          locale: _userLocale,
          localizationsDelegates: const [
            L10n.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'),
            Locale('ru'),
            Locale('es'),
          ],
        ),
      ),
    );
  }
}
