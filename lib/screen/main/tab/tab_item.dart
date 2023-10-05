import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

import 'analyze/f_benefit.dart';
import 'market/f_stock.dart';
import 'more/f_all.dart';
import 'news/f_home.dart';
import 'watchlist/f_ttosspay.dart';

enum TabItem {
  market(Icons.area_chart, '시장', MarketFragment()),
  news(Icons.newspaper, '뉴스', NewsFragment()),
  analyze(Icons.language, '검색', AnalyzeFragment()),
  watchlist(Icons.star, '관심목록', WatchlistFragment()),
  more(Icons.menu, '더보기', MoreFragment());

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
        label: tabName);
  }
}
