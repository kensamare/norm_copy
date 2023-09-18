// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/services/helpers.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class UserAvatar extends StatelessWidget {
  const UserAvatar({
    Key? key,
    this.imageUrl,
    this.size,
    this.isLoading = false,
    this.letter,
  }) : super(key: key);

  static const double defaultSize = 96.0;

  double get _size => size ?? defaultSize.r;

  /// Ссылка на аватар пользователя.
  final String? imageUrl;

  /// Размер аватарки.
  final double? size;

  /// Загружается изображение или нет.
  final bool isLoading;

  /// Буква вместо иконки.
  final String? letter;

  Widget _buildImage(BuildContext context) {
    if (imageUrl.isBlank) {
      return Container(
        height: _size,
        width: _size,
        decoration: BoxDecoration(
          color: NColors.gray2,
          border: Border.all(color: NColors.background, width: 0.5.r),
        ),
        child: Center(
          child: isLoading
              ? Transform.scale(
                  scale: _size / defaultSize,
                  child: const CupertinoActivityIndicator(color: NColors.black),
                )
              : (letter == null
                  ? NIcon(NIcons.profile, size: _size / 3, color: NColors.gray)
                  : Text(
                      letter!.toUpperCase(),
                      style: NTypography.rfDewiBold24.copyWith(fontSize: _size / 2, color: NColors.gray, height: 1.0),
                    )),
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl!,
      height: _size,
      width: _size,
      fit: BoxFit.cover,
      placeholder: (_, __) => Container(color: NColors.gray2),
      errorWidget: (_, __, ___) => Container(color: NColors.gray2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(_size),
      child: _buildImage(context),
    );
  }
}
