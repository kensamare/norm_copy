// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:auto_route/auto_route.dart';

// Project imports:
import 'package:norm/internal/services/app_router/app_router.dart';
import 'package:norm/internal/utils/infrastructure.dart';
import 'package:norm/presentation/global/bottom_navigation_bar/n_bottom_navigation_bar.dart';
import 'package:norm/presentation/global/icons/n_icon.dart';
import 'package:norm/presentation/global/icons/n_icons.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  static const String routeName = '/main-page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  static const Color _activeAppBarColor = NColors.activeBottomAppBarColor;
  static const Color _inactiveAppBarColor = NColors.inactiveBottomAppBarColor;

  Map<NBottomNavigationBarItem, PageRouteInfo<dynamic>> routeToItem() => {
        // Feed page.
        NBottomNavigationBarItem(
          icon: NIcon(NIcons.home_2, color: _inactiveAppBarColor),
          activeIcon: NIcon(NIcons.home_2, color: _activeAppBarColor),
        ): const FeedRoute(),

        // Catalog page.
        NBottomNavigationBarItem(
          icon: NIcon(NIcons.bag_2, color: _inactiveAppBarColor),
          activeIcon: NIcon(NIcons.bag_2, color: _activeAppBarColor),
        ): const CatalogRoute(),

        // Add page.
        NBottomNavigationBarItem(
          icon: NIcon(NIcons.add_circle, color: _inactiveAppBarColor),
          activeIcon: NIcon(NIcons.add_circle, color: _activeAppBarColor),
        ): const CatalogRoute(),

        // Star page.
        NBottomNavigationBarItem(
          icon: NIcon(NIcons.star, color: _inactiveAppBarColor),
          activeIcon: NIcon(NIcons.star, color: _activeAppBarColor),
        ): const CatalogRoute(),

        // Profile page.
        NBottomNavigationBarItem(
          icon: NIcon(NIcons.profile, color: _inactiveAppBarColor),
          activeIcon: NIcon(NIcons.profile, color: _activeAppBarColor),
        ): const SelfProfileRoute(),
      };

  @override
  Widget build(BuildContext context) {
    final Map<NBottomNavigationBarItem, PageRouteInfo<dynamic>> _routeToItem = routeToItem();

    return AutoTabsScaffold(
      routes: _routeToItem.values.toList(),
      bottomNavigationBuilder: (_, tabsRouter) {
        return NBottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: _routeToItem.keys.toList(),
        );
      },
    );
  }
}
