// Dart imports:
import 'dart:io';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

// Project imports:
import 'package:norm/internal/services/n_logger/n_logger.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/padded_content/padded_content.dart';
import 'package:norm/presentation/global/pick_image_popup/state/pick_image_state.dart';

class CropImageDialog extends StatefulWidget {
  const CropImageDialog({
    Key? key,
    required this.image,
  }) : super(key: key);

  final File image;

  @override
  State<CropImageDialog> createState() => _CropImageDialogState();
}

class _CropImageDialogState extends State<CropImageDialog> {
  final GlobalKey<ExtendedImageEditorState> editorKey = GlobalKey<ExtendedImageEditorState>();

  bool showImage = false;

  bool isCropping = false;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback(
      // Await for image to pre-crop.
      (_) async {
        await Future.delayed(NConstants.aSecond * 0.6);

        setState(() => showImage = true);
      },
    );

    super.initState();
  }

  Future<CropResult> _cropImage() async {
    setState(() => isCropping = true);

    final Rect? rect = editorKey.currentState?.getCropRect();
    if (rect == null) return CropResultNone();

    var data = editorKey.currentState?.rawImageData.toList() ?? [];
    img.Image? src = await compute(img.decodeImage, data);

    if (src == null) return CropResultNone();

    src = img.copyCrop(src, rect.left.toInt(), rect.top.toInt(), rect.width.toInt(), rect.height.toInt());

    var fileData = await compute(img.encodeJpg, src);

    try {
      final Directory dir = await getTemporaryDirectory();
      final File file = File('${dir.path}/temp.jpg')
        ..createSync()
        ..writeAsBytesSync(fileData);

      return CropResultCropped(image: file);
    } catch (e, s) {
      NLogger.handleException(e, s);
    }

    return CropResultNone();
  }

  Widget _buildImageCrop(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(400.r),
      child: Container(
        height: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
        width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
        decoration: const BoxDecoration(color: NColors.gray, shape: BoxShape.circle),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const CupertinoActivityIndicator(),
            AnimatedOpacity(
              opacity: showImage ? 1 : 0.01,
              duration: NConstants.defaultAnimationDuration * 2,
              child: ExtendedImage.file(
                widget.image,
                fit: BoxFit.contain,
                mode: ExtendedImageMode.editor,
                extendedImageEditorKey: editorKey,
                cacheRawData: true,
                initEditorConfigHandler: (state) {
                  // state?.reLoadImage();

                  return EditorConfig(
                    lineColor: NColors.transparent,
                    cornerColor: NColors.transparent,
                    maxScale: 2.0,
                    cropRectPadding: EdgeInsets.zero,
                    hitTestSize: 20.0,
                    tickerDuration: const Duration(milliseconds: 50),
                    animationDuration: const Duration(milliseconds: 50),
                    cropAspectRatio: CropAspectRatios.ratio1_1,
                    initialCropAspectRatio: CropAspectRatios.ratio1_1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(CropResultNone()),
      child: Text(
        'Отменить',
        style: NTypography.golosRegular16,
      ),
    );
  }

  Widget _buildSaveButton(BuildContext context) {
    if (isCropping) {
      return SizedBox(
        width: 84.w,
        child: const Center(
          child: CupertinoActivityIndicator(color: NColors.greenPrimary),
        ),
      );
    }

    return GestureDetector(
      onTap: () async => Navigator.of(context).pop(await _cropImage()),
      child: Text(
        'Сохранить',
        style: NTypography.golosRegular16.copyWith(color: NColors.greenPrimary),
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return PaddedContent(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCancelButton(context),
          _buildSaveButton(context),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 16.h),
        Text('Обрезать', style: NTypography.golosRegular16),
        const Spacer(),
        _buildImageCrop(context),
        const Spacer(),
        _buildActions(context),
        SizedBox(height: 64.h),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Navigator.of(context).pop();

    return Material(
      color: NColors.transparent,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: MediaQuery.of(context).size.height - 48.h,
            width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
            decoration: BoxDecoration(
              color: NColors.gray2,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height - 64.h,
            decoration: BoxDecoration(
              color: NColors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
            ),
            child: Center(
              child: _buildContent(context),
            ),
          ),
          // if (isCropping)
          //   Container(
          //     height: MediaQuery.of(context).size.height,
          //     decoration: BoxDecoration(
          //       borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          //       color: NColors.black.withOpacity(0.1),
          //     ),
          //     child: const Center(
          //       child: CupertinoActivityIndicator(color: NColors.greenPrimary),
          //     ),
          //   ),
        ],
      ),
    );
  }
}
