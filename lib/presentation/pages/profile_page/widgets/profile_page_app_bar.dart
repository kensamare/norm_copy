// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share_plus/share_plus.dart';

// Project imports:
import 'package:norm/domain/models/user/user.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/back_button/n_back_button.dart';
import 'package:norm/presentation/global/floating_options_button/floating_option.dart';
import 'package:norm/presentation/global/floating_options_button/floating_options_button.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';

class ProfilePageAppBar extends StatefulWidget implements PreferredSizeWidget {
  const ProfilePageAppBar({
    super.key,
    required this.username,
    this.currentUser = false,
    this.onBlock,
    this.onComplain,
    this.onLeave,
  });

  /// Profile username.
  final String username;

  /// Current user app bar.
  final bool currentUser;

  /// On block user callback.
  final Function()? onBlock;

  /// On block user callback.
  final Function()? onComplain;

  /// On logout callback.
  final Function()? onLeave;

  @override
  State<ProfilePageAppBar> createState() => _ProfilePageAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _ProfilePageAppBarState extends State<ProfilePageAppBar> {
  Widget _buildTitle(BuildContext context) {
    return Text('@${widget.username}', style: NTypography.rfDewiBold24);
  }

  Widget _buildLeading(BuildContext context) {
    if (service<AppRouter>().canPop()) {
      return const NBackButton();
    }

    if (widget.currentUser) {
      return NIcon(
        NIcons.notification,
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildMoreButton(BuildContext context) {
    return FloatingOptionsButton(
      options: [
        if (widget.currentUser)
          FloatingOption(
            icon: NIcons.settings,
            title: 'Настройки',
            onTap: () {},
          ),
        FloatingOption(
          icon: NIcons.share,
          title: 'Поделиться',
          onTap: () => Share.share(
            User.shareLink(widget.username),
          ),
        ),
        if (widget.currentUser)
          FloatingOption(
            icon: NIcons.trash,
            title: 'Выйти',
            onTap: () => widget.onLeave?.call(),
            type: FloatingOptionType.alert,
          ),
        if (!widget.currentUser) ...[
          FloatingOption(
            icon: NIcons.complain,
            title: 'Пожаловаться на пользователя',
            onTap: () => widget.onComplain?.call(),
            type: FloatingOptionType.alert,
          ),
          FloatingOption(
            icon: NIcons.lock,
            title: 'Заблокировать пользователя',
            onTap: () => widget.onBlock?.call(),
            type: FloatingOptionType.alert,
          ),
        ],
      ],
      child: NIcon(NIcons.more),
    );
  }

  Widget _buildContent(BuildContext context) {
    return PaddedContent(
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: EdgeInsets.only(bottom: 12.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: _buildLeading(context),
                ),
              ),
              _buildTitle(context),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: _buildMoreButton(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kToolbarHeight + MediaQuery.of(context).padding.top,
      decoration: const BoxDecoration(color: NColors.white),
      child: _buildContent(context),
    );
  }
}
