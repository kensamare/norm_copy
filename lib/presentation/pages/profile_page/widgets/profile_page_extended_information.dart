// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class ProfilePageExtendedInformation extends StatelessWidget {
  const ProfilePageExtendedInformation({
    super.key,
    required this.onTap,
    this.isEmpty = false,
  });

  final Function() onTap;

  /// If extended information is empty or not.
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        height: 56.h,
        child: Center(
          child: Text(
            isEmpty ? L10n.of(context)!.addExtendedInformation : L10n.of(context)!.watchExtendedInformation,
            style: NTypography.golosRegular14.copyWith(color: NColors.bluePrimary),
          ),
        ),
      ),
    );
  }
}
