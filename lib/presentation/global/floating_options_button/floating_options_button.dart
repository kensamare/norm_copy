// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/floating_options_button/floating_option.dart';

class FloatingOptionsButton extends StatefulWidget {
  const FloatingOptionsButton({
    super.key,
    this.child,
    this.options = const [],
  });

  final Widget? child;

  /// Options.
  final List<FloatingOption> options;

  @override
  State<FloatingOptionsButton> createState() => _FloatingOptionsButtonState();
}

class _FloatingOptionsButtonState extends State<FloatingOptionsButton> {
  final GlobalKey _key = GlobalKey();

  /// Widget offset on the screen.
  Offset offset = Offset.zero;

  /// Widget child size.
  Size size = Size.zero;

  OverlayEntry? _overlay;

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      final RenderBox renderBox = _key.currentContext?.findRenderObject() as RenderBox;

      offset = renderBox.localToGlobal(Offset.zero);
      size = renderBox.size;
    });

    super.initState();
  }

  void removeOverlay() {
    _overlay?.remove();
    _overlay = null;
  }

  void openMenu(BuildContext context) {
    _overlay = _buildOverlay(context);

    // Insert overlay.
    Overlay.of(context)?.insert(_overlay!);
  }

  OverlayEntry _buildOverlay(BuildContext context) {
    return OverlayEntry(
      builder: (context) => GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => removeOverlay(),
        child: Stack(
          children: [
            Positioned(
              top: offset.dy + size.height,
              left: NConstants.sidePadding.w,
              child: Container(
                width: MediaQuery.of(context).size.width - 2 * NConstants.sidePadding.w,
                decoration: BoxDecoration(
                  color: NColors.white,
                  borderRadius: BorderRadius.circular(20.r),
                  border: Border.all(width: 1.r, color: NColors.gray3),
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, 5),
                      blurRadius: 6.r,
                      color: NColors.black.withOpacity(0.1),
                    ),
                  ],
                ),
                child: Material(
                  color: NColors.transparent,
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final FloatingOption option = widget.options.elementAt(index);

                      final bool isLast = index == widget.options.length - 1;
                      final bool isFirst = index == 0;

                      return InkWell(
                        borderRadius: BorderRadius.vertical(
                          top: isFirst ? Radius.circular(20.r) : Radius.zero,
                          bottom: isLast ? Radius.circular(20.r) : Radius.zero,
                        ),
                        onTap: () {
                          removeOverlay();
                          option.onTap();
                        },
                        child: option,
                      );
                    },
                    separatorBuilder: (_, __) => Container(height: 1.r, color: NColors.gray3),
                    itemCount: widget.options.length,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_overlay != null) {
          removeOverlay();
        } else {
          openMenu(context);
        }
      },
      key: _key,
      child: widget.child,
    );
  }
}
