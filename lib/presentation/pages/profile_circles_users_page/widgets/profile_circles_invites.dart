// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/invite/invite.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/confirm_action_popup/confirm_action_popup.dart';
import 'package:norm/presentation/global/confirm_action_popup/widgets/confirm_action.dart';
import 'package:norm/presentation/global/invite_wrapper/invite_wrapper.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ProfileCirclesInvites extends StatelessWidget {
  const ProfileCirclesInvites({
    super.key,
    this.onGenerateCode,
    this.onRevoke,
    this.availableInvites = 0,
    this.invites = const [],
    this.isLoadingInvites = false,
    this.isLoadingInvitesCount = false,
  });

  final Function()? onGenerateCode;

  final Function(Invite)? onRevoke;

  /// Available invites count.
  final int availableInvites;

  /// User available invites.
  final List<Invite> invites;

  final bool isLoadingInvites;
  final bool isLoadingInvitesCount;

  void openRevokeConfirmationPopup(BuildContext context, Invite invite) {
    service<AppRouter>().showBottomSheet(
      context,
      ConfirmActionPopup(
        title: 'Вы уверены,\nчто хотите отозвать\nинвайт код?',
        confirmWidget: ConfirmAction(
          onTap: () {
            onRevoke?.call(invite);
            AutoRouter.of(context).pop();
          },
          title: 'Да, отозвать',
        ),
        cancelWidget: ConfirmAction(
          onTap: () => AutoRouter.of(context).pop(),
          title: 'Отмена',
          inverted: true,
        ),
      ),
    );
  }

  Widget _buildActionButton(BuildContext context) {
    if (availableInvites == 0) {
      return GestureDetector(
        child: Text(
          'Как получить инвайт?',
          style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
        ),
      );
    }

    return GestureDetector(
      onTap: onGenerateCode,
      child: Text(
        'Сгенерировать код',
        style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.r),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Доступно',
                style: NTypography.golosRegular12.copyWith(color: NColors.gray, height: 1.0),
              ),
              SizedBox(height: 4.h),
              if (isLoadingInvitesCount)
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: const CupertinoActivityIndicator(),
                )
              else
                Text(
                  '$availableInvites инвайтов',
                  style: NTypography.rfDewiBold20.copyWith(letterSpacing: -1.03),
                ),
            ],
          ),
          _buildActionButton(context),
        ],
      ),
    );
  }

  Widget _buildInvitesHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: NColors.gray4,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: _buildContent(context),
    );
  }

  Widget _buildInviteCodes(BuildContext context) {
    if (isLoadingInvites) {
      return const CupertinoActivityIndicator();
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final Invite invite = invites.elementAt(index);
        return InviteWrapper(
          index: index,
          invite: invite,
          onRevoke: () => openRevokeConfirmationPopup(context, invite),
        );
      },
      separatorBuilder: (_, __) => Container(height: 0.5.r, color: NColors.gray2),
      itemCount: invites.length,
    );
  }

  @override
  Widget build(BuildContext context) {
    return PaddedContent(
      child: Column(
        children: [
          _buildInvitesHeader(context),
          SizedBox(height: 24.h),
          _buildInviteCodes(context),
        ],
      ),
    );
  }
}
