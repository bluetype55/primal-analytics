import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/main/tab/market/search/s_search_stock.dart';
import 'package:fast_app_base/screen/main/tab/market/tab/f_my_stock.dart';
import 'package:fast_app_base/screen/main/tab/market/tab/f_today_discovery.dart';
import 'package:flutter/material.dart';

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
          title: '시장'.text.make(),
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
              tabBar,
              if (currentIndex == 0)
                const MyStockFragment()
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
              labelColor: context.appColors.text,
              labelStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              labelPadding: const EdgeInsets.symmetric(vertical: 20),
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 20),
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: Colors.white,
              controller: tabController,
              tabs: [
                "내주식".text.make(),
                '오늘의 발견'.text.make(),
              ],
            ),
            const Line(),
          ],
        ),
      );
}
