// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/brand/brand.dart';
import 'package:norm/domain/models/interfaces/profile.dart';
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/n_button/n_button.dart';
import 'package:norm/presentation/global/registration_template_page/registration_template_page.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class UserInvitationConfirmationPageView extends StatelessWidget {
  const UserInvitationConfirmationPageView({
    Key? key,
    required this.invitedBy,
  }) : super(key: key);

  /// The user actual user has been invited by.
  final Profile invitedBy;

  AppRouter get router => service<AppRouter>();

  Widget _buildConfirmButton(BuildContext context) {
    return NButton(
      onPressed: () => router.replaceWithInvitationFormPage(),
      title: L10n.of(context)!.confirm,
      width: double.infinity,
    );
  }

  Widget _buildUser(BuildContext context) {
    return Row(
      children: [
        UserAvatar(
          size: 64.r,
          imageUrl: invitedBy.avatar250,
        ),
        SizedBox(width: 16.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              (invitedBy is Brand)
                  ? (invitedBy as Brand).title
                  : '${(invitedBy as User).firstName} ${(invitedBy as User).lastName}',
              style: NTypography.golosMedium16,
            ),
            SizedBox(height: 2.h),
            Text(
              '@${invitedBy.nickname}',
              style: NTypography.golosMedium14.copyWith(color: NColors.graySecondaryText),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 70.h),
            _buildUser(context),
            const Spacer(),
            _buildConfirmButton(context),
            SizedBox(height: 54.h),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RegistrationTemplatePage(
      // Вас пригласил {Имя}?
      header: L10n.of(context)!.haveYouBeenInvitedBy(
        (invitedBy is Brand) ? (invitedBy as Brand).title : (invitedBy as User).firstName,
      ),

      // Вы будете включены в ближайший социальный круг данного пользователя.
      subtitle: L10n.of(context)!.youWillBeIncludedInInnerCircle,

      content: _buildContent(context),
      includeSpacer: false,
    );
  }
}
