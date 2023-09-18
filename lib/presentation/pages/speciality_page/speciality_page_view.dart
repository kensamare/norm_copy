// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/speciality/speciality.dart';
import 'package:norm/internal/page_providers/speciality_page/states/speciality_state.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/presentation/global/divider/n_horizontal_divider.dart';
import 'package:norm/presentation/pages/speciality_page/widgets/speciality_page_about.dart';
import 'package:norm/presentation/pages/speciality_page/widgets/speciality_page_actions.dart';
import 'package:norm/presentation/pages/speciality_page/widgets/speciality_page_app_bar.dart';
import 'package:norm/presentation/pages/speciality_page/widgets/speciality_page_header.dart';
import 'package:norm/presentation/pages/speciality_page/widgets/speciality_page_tabs.dart';

class SpecialityPageView extends StatelessWidget {
  const SpecialityPageView({
    super.key,
    this.fromProfile,
  });

  /// Parent profile route.
  final Profile? fromProfile;

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    final SpecialityState state = context.watch<SpecialityState>();

    return SpecialityPageAppBar(
      fromProfile: fromProfile,
      my: state.speciality!.my,
      nickname: state.speciality!.nickname,
    );
  }

  Widget _buildTabs(BuildContext context) {
    return SpecialityPageTabs();
  }

  Widget _buildSpecialityHeader(BuildContext context) {
    return Observer(
      builder: (context) {
        final SpecialityState state = context.watch<SpecialityState>();
        final Speciality? speciality = state.speciality;

        if (speciality == null) return const SizedBox.shrink();

        return SpecialityPageHeader(
          avatar: speciality.avatar250 ?? speciality.avatar,
          title: speciality.title,
          reputation: speciality.reputation,
          followers: speciality.followers,
          category: speciality.category,
        );
      },
    );
  }

  Widget _buildActions(BuildContext context) {
    return Observer(
      builder: (context) {
        final SpecialityState state = context.watch<SpecialityState>();
        final Speciality? speciality = state.speciality;

        if (speciality == null) return const SizedBox.shrink();

        return SpecialityPageActions(
          contacts: speciality.contacts,
          my: speciality.my,
          blocked: speciality.blocked,
          followed: speciality.followed,
          onFollow: state.follow,
          onUnfollow: state.unfollow,
          onEdit: () async {
            final Speciality? editedSpeciality =
                await service<AppRouter>().goToEditSpecialityPage(speciality: speciality);

            if (editedSpeciality != null) {
              state.updateSpeciality(editedSpeciality);
            }
          },
          onEditContacts: () async {
            final Speciality? editedSpeciality =
                await service<AppRouter>().jumpToEditSpecialityContactsPage(speciality: speciality);

            if (editedSpeciality != null) {
              state.updateSpeciality(editedSpeciality);
            }
          },
        );
      },
    );
  }

  Widget _buildAbout(BuildContext context) {
    return Observer(
      builder: (context) {
        final SpecialityState state = context.watch<SpecialityState>();
        final Speciality? speciality = state.speciality;

        if (speciality == null) return const SizedBox.shrink();

        return SpecialityPageAbout(
          about: speciality.description,
          onTapAddDescription: () =>
              service<AppRouter>().jumpToEditSpecialityMainInformationPage(speciality: speciality),
        );
      },
    );
  }

  Widget _buildSpecialityInformation(BuildContext context) {
    final SpecialityState state = context.watch<SpecialityState>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 8.h),
        _buildSpecialityHeader(context),
        SizedBox(height: 16.h),
        if (!state.speciality!.my && (state.speciality?.about.isBlank ?? true))
          const SizedBox.shrink()
        else ...[
          _buildAbout(context),
          SizedBox(height: 16.h),
        ],
        _buildActions(context),
        SizedBox(height: 20.h),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return SafeArea(
      child: Observer(
        builder: (context) {
          final SpecialityState state = context.watch<SpecialityState>();

          if (state.isLoadingSpeciality) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }

          final List<Widget> widgets = [
            _buildSpecialityInformation(context),
            _buildTabs(context),
          ];

          return ListView.separated(
            itemBuilder: (context, index) => widgets[index],
            separatorBuilder: (_, __) => const NHorizontalDivider(),
            itemCount: widgets.length,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final SpecialityState state = context.watch<SpecialityState>();

        return Scaffold(
          appBar: state.isLoadingSpeciality ? null : _buildAppBar(context),
          body: _buildContent(context),
        );
      },
    );
  }
}
