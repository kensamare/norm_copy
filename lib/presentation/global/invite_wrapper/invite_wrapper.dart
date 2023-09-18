// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/invite/invite.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class InviteWrapper extends StatelessWidget {
  const InviteWrapper({
    super.key,
    required this.invite,
    this.index = 0,
    this.onRevoke,
  });

  final int index;
  final Invite invite;

  final Function()? onRevoke;

  Widget _buildCode(BuildContext context) {
    return Row(
      children: [
        Text(invite.code, style: NTypography.rfDewiBold20),
        SizedBox(width: 16.w),
        InkResponse(
          onTap: () => copyToClipboard(invite.code),
          child: NIcon(NIcons.copy),
        ),
      ],
    );
  }

  Widget _buildRevokeButton(BuildContext context) {
    return GestureDetector(
      onTap: onRevoke,
      child: Text(
        'Отозвать',
        style: NTypography.golosRegular14.copyWith(color: NColors.redPrimary),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          '${index + 1}. ',
          style: NTypography.golosRegular14.copyWith(color: NColors.gray),
        ),
        SizedBox(width: 18.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildCode(context),
            SizedBox(height: 2.h),
            Text(
              invite.status == InviteStatus.notactivated ? 'Неактивирован' : 'Активирован',
              style: NTypography.golosRegular12.copyWith(color: NColors.gray),
            ),
          ],
        ),
        const Spacer(),
        _buildRevokeButton(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 78.h,
      child: _buildContent(context),
    );
  }
}
