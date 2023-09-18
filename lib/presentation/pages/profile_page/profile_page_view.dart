// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/page_providers/profile_page/states/profile_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_about.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_actions.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_app_bar.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_extended_information.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_header.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_karma_points.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_publications.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_specialities.dart';
import 'package:norm/presentation/pages/profile_page/widgets/profile_page_values.dart';

class ProfilePageView extends StatefulWidget {
  const ProfilePageView({super.key});

  @override
  State<ProfilePageView> createState() => _ProfilePageViewState();
}

class _ProfilePageViewState extends State<ProfilePageView> {
  final RefreshController refreshController = RefreshController();

  AppRouter get router => service<AppRouter>();

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final ProfileState state = context.watch<ProfileState>();

    return ProfilePageAppBar(
      username: state.user?.nickname ?? '',
      currentUser: state.currentUser,
      onBlock: state.block,
      onLeave: () async {
        await service<AuthState>().logout();
        router.replaceWithSplashScreen();
      },
    );
  }

  Widget _buildUserInformation(BuildContext context) {
    final ProfileState state = context.watch<ProfileState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        _buildHeader(context),
        SizedBox(height: 16.h),
        if (state.currentUser) ...[
          _buildKarmaPoints(context),
          SizedBox(height: 24.h),
        ],
        if (!state.currentUser && (state.user?.about.isBlank ?? true))
          const SizedBox.shrink()
        else ...[
          _buildAbout(context),
          SizedBox(height: 8.h),
        ],
        _buildValues(context),
        SizedBox(height: 8.h),
        _buildActions(context),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildValues(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageValues(
          onTapCirclesPage: () => router.goToProfileCirclesPage(user.id, state.currentUser),
          invites: user.invites + user.freeInvites,
          followers: user.followers,
          contacts: user.contactsCount,
          mutualContacts: user.mutualContacts,
          currentUser: state.currentUser,
        );
      },
    );
  }

  Widget _buildActions(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageActions(
          contacts: user.contacts,
          currentUser: state.currentUser,
          goToGradePerson: () => router.goToGradePersonPage(user),
          userRates: intToBool(user.rates),
          blocked: user.blocked,
          followed: user.followed,
          onFollow: state.follow,
          onUnfollow: state.unfollow,
          onUnblock: state.unblock,
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageHeader(
          parent: user,
          isCurrentUser: state.currentUser,
          avatar: user.avatar250,
          firstName: user.firstName,
          lastName: user.lastName,
          invitedBy: user.invitedBy,
          reputation: user.reputation,
          karmaLevel: user.karmaLevel,
          match: user.match,
          circle: user.circle,
        );
      },
    );
  }

  Widget _buildKarmaPoints(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageKarmaPoints(
          karmaLevel: user.karmaLevel,
          karmaFine: user.karmaFine,
          karmaFineNeed: user.karmaFineNeed,
          karmaPoints: user.karmaPoints,
          karmaPointsNeed: user.karmaPointsNeed,
          karmaMultiplier: user.karmaMultiplier,
        );
      },
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageAbout(about: user.about);
      },
    );
  }

  Widget _buildSpecs(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageSpecialities(
          specs: user.specs,
          profile: user,
        );
      },
    );
  }

  Widget _buildExtendedInformation(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();
        final User? user = state.user;

        if (user == null) return const SizedBox.shrink();

        return ProfilePageExtendedInformation(
          onTap: () => user.hasExtendedInformation
              ? service<AppRouter>().goToExtendedInformationPage(user)
              : service<AppRouter>().goToEditExtendedInformationPage(),
          isEmpty: !user.hasExtendedInformation,
        );
      },
    );
  }

  Widget _buildPublications(BuildContext context) {
    return Observer(builder: (context) {
      final ProfileState state = context.watch<ProfileState>();
      final User? user = state.user;

      if (user == null) return const SizedBox.shrink();

      return ProfilePagePublications(
        currentUser: state.currentUser,
        blocked: user.blocked,
      );
    });
  }

  Widget _buildContent(BuildContext context) {
    return SmartRefresher(
      onRefresh: () async {
        final ProfileState state = context.read<ProfileState>();

        await state.refresh();
        refreshController.refreshCompleted();
      },
      controller: refreshController,
      child: SafeArea(
        child: Observer(
          builder: (context) {
            final ProfileState state = context.watch<ProfileState>();

            if (state.isLoadingUser) {
              return const Center(
                child: CupertinoActivityIndicator(),
              );
            }

            final List<Widget> widgets = [
              _buildUserInformation(context),
              if (!(state.user?.blocked ?? false)) ...[
                if (state.currentUser || (state.user?.specs.isNotEmpty ?? false)) _buildSpecs(context),
                if (state.currentUser || (state.user?.hasExtendedInformation ?? false))
                  _buildExtendedInformation(context),
              ],
              _buildPublications(context),
            ];

            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => widgets[index],
              separatorBuilder: (_, __) => const NHorizontalDivider(),
              itemCount: widgets.length,
            );
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileState state = context.watch<ProfileState>();

        return Scaffold(
          appBar: state.isLoadingUser ? null : _buildAppBar(context),
          body: _buildContent(context),
        );
      },
    );
  }
}
