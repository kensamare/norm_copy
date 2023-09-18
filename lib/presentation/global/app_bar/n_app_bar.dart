// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/back_button/n_back_button.dart';

class NAppBar extends StatefulWidget implements PreferredSizeWidget {
  const NAppBar({
    super.key,
    this.title,
    this.actions,
    this.popValue,
  });

  /// App bar title;
  final String? title;

  final List<Widget>? actions;

  /// Value to return when pop.
  final dynamic popValue;

  @override
  State<NAppBar> createState() => _NAppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _NAppBarState extends State<NAppBar> {
  late bool canPop;

  @override
  void initState() {
    // Memorize can pop state.
    canPop = AutoRouter.of(context).canPop();

    super.initState();
  }

  Widget _buildTitle(BuildContext context) {
    return Text(widget.title!, style: NTypography.rfDewiBold24);
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
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
                  child: canPop ? NBackButton(value: widget.popValue) : const SizedBox.shrink(),
                ),
              ),
              if (widget.title != null) _buildTitle(context),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: widget.actions == null
                      ? const SizedBox.shrink()
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: widget.actions!,
                        ),
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
