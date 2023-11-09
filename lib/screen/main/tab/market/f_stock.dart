import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/market/search/s_search_stock.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/f_my_stock.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/f_today_discovery.dart';

class MarketFragment extends StatefulWidget {
  const MarketFragment({super.key});

  @override
  State<MarketFragment> createState() => _MarketFragmentState();
}

class _MarketFragmentState extends State<MarketFragment>
    with SingleTickerProviderStateMixin {
  late final tabController = TabController(length: 2, vsync: this);
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              color: context.themeType.themeData.scaffoldBackgroundColor,
            ),
          ),
          leading: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              width10,
              tabBar,
            ],
          ),
          leadingWidth: double.maxFinite,
          actions: [
            IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  Nav.push(const SearchStockScreen());
                }),
          ],
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              if (currentIndex == 0)
                MyStockFragment()
              else
                const TodayDiscoveryFragment()
            ],
          ),
        ),
      ],
    );
  }

  Widget get tabBar => Container(
        child: Column(
          children: [
            TabBar(
              onTap: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              isScrollable: true,
              tabAlignment: TabAlignment.start,
              dividerColor: Colors.transparent,
              labelColor: context.appColors.text,
              labelStyle:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              labelPadding:
                  const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              indicatorColor: context.appColors.text,
              indicatorSize: TabBarIndicatorSize.label,
              controller: tabController,
              tabs: [
                "내주식".text.make(),
                '오늘의 발견'.text.make(),
              ],
            ),
          ],
        ),
      );
}
