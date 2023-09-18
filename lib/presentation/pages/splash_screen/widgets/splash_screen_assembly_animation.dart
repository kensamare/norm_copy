// Flutter imports:
import 'package:flutter/material.dart';

class SplashScreenAssemblyAnimation extends StatefulWidget {
  const SplashScreenAssemblyAnimation({Key? key}) : super(key: key);

  @override
  State<SplashScreenAssemblyAnimation> createState() => _SplashScreenAssemblyAnimationState();
}

class _SplashScreenAssemblyAnimationState extends State<SplashScreenAssemblyAnimation>
    with SingleTickerProviderStateMixin {
  /// Screen assembly animation duration.
  static const Duration screenAnimationDuration = Duration(seconds: 3);

  /// Number of background parts.
  static const int _BACKGROUND_PARTS_COUNT = 8;

  /// Number of text parts.
  static const int _TEXT_PARTS_COUNT = 4;

  /// Number of horizontal items.
  static const _HORIZONTAL_ITEMS_COUNT = 2;

  /// Number of vertical items.
  static const _VERTICAL_ITEMS_COUNT = 4;

  /// Text asset with number.
  String _textAsset(int number) => 'assets/splash/text_$number.png';

  // /// Backgrund asset with number.
  // String _backgroundAsset(int number) => 'assets/splash/background_$number.png';

  /// Grid items aspect ratio.
  double get _gridAspectRatio {
    return (MediaQuery.of(context).size.width / _HORIZONTAL_ITEMS_COUNT) /
        (MediaQuery.of(context).size.height / _VERTICAL_ITEMS_COUNT);
  }

  // Widget _buildBackgroundGrid(BuildContext context) {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     padding: EdgeInsets.zero,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: _HORIZONTAL_ITEMS_COUNT, childAspectRatio: _gridAspectRatio),
  //     itemBuilder: (context, index) {
  //       return Container(
  //         color: Color(Random().nextInt(0xFFFFFFFF)),
  //       );
  //     },
  //     itemCount: _BACKGROUND_PARTS_COUNT,
  //   );
  // }

  // Widget _buildTextGrid(BuildContext context) {
  //   return GridView.builder(
  //     shrinkWrap: true,
  //     physics: const NeverScrollableScrollPhysics(),
  //     padding: EdgeInsets.zero,
  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
  //         crossAxisCount: _HORIZONTAL_ITEMS_COUNT, childAspectRatio: _gridAspectRatio),
  //     itemBuilder: (context, index) {
  //       return Image.asset(
  //         _textAsset(index + 1),
  //         fit: BoxFit.cover,
  //       );
  //     },
  //     itemCount: _TEXT_PARTS_COUNT,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          // _buildBackgroundGrid(context),
          // _buildTextGrid(context),
          Image.asset('assets/splash/final.png'),
        ],
      ),
    );
  }
}
