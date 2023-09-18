// Flutter imports:
import 'package:flutter/material.dart';

class PrecachedImages {
  static const List<String> _images = [emptyAvatar];

  static const String emptyAvatar = 'assets/images/empty_avatar.png';

  Future<void> precacheImages(BuildContext context) async {
    for (String image in _images) {
      precacheImage(AssetImage(image), context);
    }
  }
}
