// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/domain/models/picked_location/picked_location.dart';
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class PickLocationButton extends StatelessWidget {
  const PickLocationButton({
    super.key,
    required this.onChanged,
    this.title,
  });

  final Function(PickedLocation) onChanged;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final PickedLocation? position = await service<AppRouter>().openPickLocationPopup(context);

        if (position != null) {
          onChanged(position);
        }
      },
      child: SizedBox(
        height: 56.h,
        child: Row(
          children: [
            NIcon(NIcons.location),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                title ?? 'Добавить местоположение',
                style: NTypography.golosRegular14.copyWith(color: title == null ? NColors.gray : NColors.black),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // const Spacer(),
            NIcon(NIcons.arrow_right_2),
          ],
        ),
      ),
    );
  }
}
