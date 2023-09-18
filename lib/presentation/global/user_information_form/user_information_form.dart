// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/n_text_field/n_text_field.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/user_avatar/user_avatar.dart';

class UserInformationForm extends StatefulWidget {
  const UserInformationForm({
    Key? key,
    required this.onChangedName,
    required this.onChangedSurname,
    required this.onPickImageResult,
    this.name,
    this.surname,
    this.image,
    this.isLoadingImage = false,
  }) : super(key: key);

  final String? name;
  final String? surname;

  /// On changed name callback.
  final Function(String) onChangedName;

  /// On changed surname callback.
  final Function(String) onChangedSurname;

  /// Pick image result callback.
  final Function(PickImageResult) onPickImageResult;

  /// Image url.
  final String? image;

  /// If image is uploading to server or not.
  final bool isLoadingImage;

  @override
  State<UserInformationForm> createState() => _UserInformationFormState();
}

class _UserInformationFormState extends State<UserInformationForm> {
  AppRouter get router => service<AppRouter>();

  double _areaWidth = 0;

  double get textFieldWidth => (_areaWidth - 16.w) / 2;

  Future<void> pickImage() async {
    final PickImageResult result = await router.showPickImagePopup(context, canDelete: !widget.image.isBlank);

    widget.onPickImageResult(result);
  }

  Widget _buildPickImage(BuildContext context) {
    return GestureDetector(
      onTap: pickImage,
      child: Row(
        children: [
          if (widget.image.isBlank && !widget.isLoadingImage)
            Container(
              height: 64.r,
              width: 64.r,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: NColors.gray2),
              child: Center(
                child: NIcon(NIcons.gallery_add),
              ),
            )
          else
            UserAvatar(
              imageUrl: widget.isLoadingImage ? null : widget.image,
              isLoading: widget.isLoadingImage,
              size: 64.r,
            ),
          SizedBox(width: 16.w),
          Text(
            L10n.of(context)!.uploadPhoto,
            style: NTypography.golosRegular14,
          ),
        ],
      ),
    );
  }

  Widget _buildNameField(BuildContext context) {
    return Expanded(
      child: NTextField(
        initialValue: widget.name,
        onChanged: widget.onChangedName,
        width: double.infinity,
        hintText: L10n.of(context)!.name,
        capitalization: TextCapitalization.words,
        keyboardType: TextInputType.name,
      ),
    );
  }

  Widget _buildSurnameField(BuildContext context) {
    return Expanded(
      child: NTextField(
        initialValue: widget.surname,
        onChanged: widget.onChangedSurname,
        width: double.infinity,
        hintText: L10n.of(context)!.surname,
        capitalization: TextCapitalization.words,
        keyboardType: TextInputType.name,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        _areaWidth = MediaQuery.of(context).size.width - 2 * 16.w;

        return Column(
          children: [
            _buildPickImage(context),
            SizedBox(height: 40.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNameField(context),
                SizedBox(width: 16.w),
                _buildSurnameField(context),
              ],
            ),
          ],
        );
      },
    );
  }
}
