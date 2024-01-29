import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';

import 'market/f_market.dart';
import 'more/f_more.dart';
import 'news/f_news.dart';
import 'watchlist/f_watchlist.dart';

enum TabItem {
  market(Icons.area_chart, 'market', MarketFragment()),
  news(Icons.newspaper, 'news', NewsFragment()),
  watchlist(Icons.star, 'watchlist', WatchlistFragment()),
  more(Icons.menu, 'more', MoreFragment());

  final IconData activeIcon;
  final IconData inActiveIcon;
  final String tabName;
  final Widget firstPage;

  const TabItem(this.activeIcon, this.tabName, this.firstPage,
      {IconData? inActiveIcon})
      : inActiveIcon = inActiveIcon ?? activeIcon;

  BottomNavigationBarItem toNavigationBarItem(BuildContext context,
      {required bool isActivated}) {
    return BottomNavigationBarItem(
        icon: Icon(
          key: ValueKey(tabName),
          isActivated ? activeIcon : inActiveIcon,
          color: isActivated
              ? context.appColors.iconButton
              : context.appColors.iconButtonInactivate,
        ),
        label: tabName.tr());
  }
}
