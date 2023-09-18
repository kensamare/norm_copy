// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

// Project imports:
import 'package:norm/domain/models/contact/contact.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import '../icons/n_icon.dart';

class ContactWrapper extends StatelessWidget {
  const ContactWrapper({
    super.key,
    required this.contact,
    this.onEdit,
    this.onDelete,
  });

  final Contact contact;

  /// On edit callback.
  final Function()? onEdit;

  /// On edit callback.
  final Function()? onDelete;

  Widget _buildEditContactButton(BuildContext context) {
    return GestureDetector(
      onTap: onEdit,
      child: NIcon(NIcons.edit_2, color: NColors.gray),
    );
  }

  Widget _buildDeleteContactButton(BuildContext context) {
    return GestureDetector(
      onTap: onDelete,
      child: NIcon(NIcons.trash, color: NColors.gray),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
        child: Row(
          children: [
            SizedBox(
              width: 24.r,
              height: 24.r,
              child: NIcon(
                NIcons.contactPath(contact.type.name),
              ),
            ),
            SizedBox(width: 16.w),
            Text(
              contact.contact,
              style: NTypography.golosRegular16.copyWith(height: 1.0),
            ),
            const Spacer(),
            Row(
              children: [
                _buildEditContactButton(context),
                SizedBox(width: 16.w),
                _buildDeleteContactButton(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
