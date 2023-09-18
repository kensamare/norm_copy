// Dart imports:
import 'dart:developer';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/session/session.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/services/settings/settings.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/pages/splash_screen/widgets/splash_screen_assembly_animation.dart';

class SplashScreenPageView extends StatefulWidget {
  const SplashScreenPageView({Key? key}) : super(key: key);

  @override
  State<SplashScreenPageView> createState() => _SplashScreenPageViewState();
}

class _SplashScreenPageViewState extends State<SplashScreenPageView> {
  Settings get settings => service<Settings>();
  AppRouter get router => service<AppRouter>();
  AuthState get authState => service<AuthState>();

  @override
  void initState() {
    // Handle user session.
    _handleSessionStatus().whenComplete(
      () => {},
    );

    super.initState();
  }

  Future<void> _handleSessionStatus() async {
    final SessionStatus? status = await authState.getSessionStatus();
    if (status == null) return;

    if (status == SessionStatus.activated) {
      log('User session is activated. Route to main page.');
      // Replace with main page.
      router.replaceWithMainPage();
    } else if (status == SessionStatus.request) {
      log('User has sent a request. Route to request confirmation page.');
      // Replace with accepted request page.
      router.replaceWithRequestConfirmationPage();
    } else if (status == SessionStatus.invited) {
      log('User has been invited but didn\'t fill the form. Route to fill form page.');
      router.replaceWithInvitationFormPage();
      // Replace with fill user form page.
    }
  }

  Widget _buildSignInButton(BuildContext context) {
    return NButton(
      onPressed: () => router.goToLoginPage(),

      // Вход.
      title: L10n.of(context)!.login,
    );
  }

  Widget _buildSignUpButton(BuildContext context) {
    return NButton(
      onPressed: () => router.goToRegistrationWithInvitationCodePage(),

      // Регистрация.
      title: L10n.of(context)!.registration,
      inverted: true,
    );
  }

  /// Sign in and sign up buttons.
  Widget _buildActions(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildSignInButton(context),
          SizedBox(height: 16.h),
          _buildSignUpButton(context),
          SizedBox(height: 52.h),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Stack(
      children: [
        _buildActions(context),

        /// Aproximately 3 seconds assembly animation.
        const SplashScreenAssemblyAnimation(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: NColors.background,
      body: _buildContent(context),
    );
  }
}
