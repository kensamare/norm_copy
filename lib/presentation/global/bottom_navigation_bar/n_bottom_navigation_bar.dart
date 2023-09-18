// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';

class NBottomNavigationBar extends StatelessWidget {
  const NBottomNavigationBar({
    super.key,
    required this.onTap,
    this.currentIndex = 0,
    this.items = const [],
  });

  /// Current index of chosen item.
  final int currentIndex;

  /// On tap item callback.
  final Function(int) onTap;

  final List<NBottomNavigationBarItem> items;

  Widget _buildItems(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 24.h),
      child: Row(
        children: items
            .map(
              (e) => _NBottomNavigationBarItem(
                onTap: () => onTap(items.indexOf(e)),
                item: e,
                isActive: currentIndex == items.indexOf(e),
              ),
            )
            .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h + 18.h,
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: NColors.white,
        border: Border(
          top: BorderSide(color: NColors.gray2, width: 1.0),
        ),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: _buildItems(context),
      ),
    );
  }
}

class NBottomNavigationBarItem {
  const NBottomNavigationBarItem({
    required this.icon,
    required this.activeIcon,
  });

  /// Icon of item.
  final Widget icon;

  /// Icon of item.
  final Widget activeIcon;
}

class _NBottomNavigationBarItem extends StatelessWidget {
  const _NBottomNavigationBarItem({
    required this.item,
    required this.onTap,
    this.isActive = false,
  });

  final Function() onTap;

  final NBottomNavigationBarItem item;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.translucent,
        child: SizedBox(
          child: isActive ? item.activeIcon : item.icon,
        ),
      ),
    );
  }
}
