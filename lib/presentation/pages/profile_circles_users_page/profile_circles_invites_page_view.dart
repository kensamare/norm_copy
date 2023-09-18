// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:norm/internal/page_providers/profile_circles_page/states/profile_circles_state.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/states/auth_state/auth_state.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/app_bar/n_app_bar.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/user_wrapper/user_wrapper.dart';
import 'package:norm/presentation/pages/profile_circles_users_page/widgets/profile_circles_invites.dart';

class ProfileCirclesInvitesPageView extends StatelessWidget {
  const ProfileCirclesInvitesPageView({super.key});

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return NAppBar(
      title: context.read<ProfileCirclesState>().circle?.title,
    );
  }

  Widget _buildTitle(BuildContext context) {
    return PaddedContent(
      child: Text(
        'Текст о том, что такое инвайт и зачем они тебе Текст о том, что такое инвайт',
        style: NTypography.golosRegular16.copyWith(color: NColors.gray),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildInvites(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileCirclesState state = context.watch<ProfileCirclesState>();

        return ProfileCirclesInvites(
          availableInvites: service<AuthState>().user?.invites ?? 0,
          invites: state.invites,
          isLoadingInvitesCount: state.isLoadingInvitesCount,
          isLoadingInvites: state.isLoadingInvites,
          onGenerateCode: state.generateCode,
          onRevoke: state.revokeInvite,
        );
      },
    );
  }

  Widget _buildInvitedUsers(BuildContext context) {
    return Observer(
      builder: (context) {
        final ProfileCirclesState state = context.watch<ProfileCirclesState>();

        if (state.invitedUsers.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
              child: Text(
                'Приглашенные пользователи',
                style: NTypography.golosRegular14.copyWith(color: NColors.gray),
              ),
            ),
            SizedBox(height: 8.h),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return UserWrapper(
                  user: state.invitedUsers.elementAt(index),
                );
              },
              itemCount: state.invitedUsers.length,
            ),
          ],
        );
      },
    );
  }

  Widget _buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _buildTitle(context),
          SizedBox(height: 24.h),
          _buildInvites(context),
          SizedBox(height: 40.h),
          _buildInvitedUsers(context),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildContent(context),
    );
  }
}
