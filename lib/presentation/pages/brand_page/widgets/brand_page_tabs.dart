// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';
import 'package:norm/presentation/pages/brand_page/widgets/tabs/brand_page_feed.dart';
import 'package:norm/presentation/pages/brand_page/widgets/tabs/brand_page_info.dart';
import 'package:norm/presentation/pages/brand_page/widgets/tabs/brand_page_shop.dart';

class BrandPageTabs extends StatefulWidget {
  const BrandPageTabs({super.key});

  @override
  State<BrandPageTabs> createState() => _BrandPageTabsState();
}

class _BrandPageTabsState extends State<BrandPageTabs> {
  final Map<String, Widget> _tabToPage = {
    NIcons.grid_2: const BrandPageFeed(),
    NIcons.message: const BrandPageInfo(),
    NIcons.shop: const BrandPageShop(),
  };

  int currentIndex = 0;

  void _onChanged(int index) {
    if (index == currentIndex) return;

    setState(() => currentIndex = index);
  }

  Widget _buildItem(BuildContext context, {required String item, Function()? onTap}) {
    final bool currentItem = _tabToPage.keys.toList().indexOf(item) == currentIndex;

    return Expanded(
      child: Material(
        color: NColors.transparent,
        child: InkResponse(
          onTap: onTap,
          child: Center(
            child: NIcon(item, color: currentItem ? NColors.black : NColors.gray),
          ),
        ),
      ),
    );
  }

  Widget _buildItems(BuildContext context) {
    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border(
          bottom: BorderSide(color: NColors.gray2, width: 1.r),
        ),
      ),
      child: Row(
        children: _tabToPage.keys
            .map(
              (e) => _buildItem(
                context,
                item: e,
                onTap: () => _onChanged(_tabToPage.keys.toList().indexOf(e)),
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    return SizedBox(
      child: _tabToPage.values.toList()[currentIndex],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildItems(context),
        _buildPage(context),
      ],
    );
  }
}
