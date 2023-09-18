// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_gen/gen_l10n/l10n.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/services/service_locator.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';
import 'package:norm/presentation/global/pick_image_popup/widgets/crop_image_dialog.dart';

class PickImagePopup extends StatefulWidget {
  const PickImagePopup({
    Key? key,
    this.canDelete = false,
    this.multiple = false,
  }) : super(key: key);

  final bool canDelete;
  final bool multiple;

  @override
  State<PickImagePopup> createState() => _PickImagePopupState();
}

class _PickImagePopupState extends State<PickImagePopup> {
  /// Pick image state.
  PickImageState get state => service<PickImageState>();

  AppRouter get router => service<AppRouter>();

  Map<Widget, Function> options(BuildContext context) => {
        _buildOption(NIcons.gallery, L10n.of(context)!.choosePhoto): pickImageFromGallery,
        if (!widget.multiple) _buildOption(NIcons.camera, L10n.of(context)!.makePhoto): pickImageFromCamera,
        if (widget.canDelete)
          _buildOption(NIcons.trash, L10n.of(context)!.deletePhoto, NColors.redPrimary): deleteImage,
      };

  Future<PickImageResult> _pickImage(ImageSource source) async {
    final PickImageResult result = await state.pickImage(source, widget.multiple);

    if (result is PickImageResultPickedMultiple) {
      return result;
    }

    if (result is PickImageResultPicked) {
      final CropResult? cropResult = await showCupertinoModalPopup(
        context: context,
        builder: (context) => CropImageDialog(image: result.image),
      );

      if (cropResult is CropResultCropped) {
        return PickImageResultPicked(image: cropResult.image);
      }
    }

    return PickImageResultNone();
  }

  Future<void> pickImageFromGallery() async => Navigator.of(context).pop(
        await _pickImage(ImageSource.gallery),
      );

  Future<void> pickImageFromCamera() async => Navigator.of(context).pop(
        await _pickImage(ImageSource.camera),
      );

  Future<void> deleteImage() async => Navigator.of(context).pop(
        await state.deleteImage(),
      );

  Widget _buildOption(String icon, String title, [Color? color]) {
    return Ink(
      height: 56.h,
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: NConstants.sidePadding.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              NIcon(icon, size: 24.r, color: color ?? NColors.black),
              SizedBox(width: 12.w),
              Text(
                title,
                style: NTypography.golosRegular16.copyWith(height: 1.0, color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final Map<Widget, Function> _options = options(context);

    return SizedBox(
      child: ListView.separated(
        padding: EdgeInsets.only(bottom: 24.h),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          final Widget item = _options.keys.elementAt(index);

          return InkWell(
            onTap: () => _options[item]?.call(),
            child: item,
          );
        },
        itemCount: _options.keys.length,
        separatorBuilder: (_, __) => Container(height: 1.h, color: NColors.gray2),
      ),
    );
  }
}
