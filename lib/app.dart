import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/theme/custom_theme_app.dart';
import 'package:primal_analytics/screen/main/s_main.dart';
import 'package:primal_analytics/screen/main/tab/market/search/search_provider.dart';
import 'package:primal_analytics/screen/main/tab/more/payment/payment_provider.dart';
import 'package:primal_analytics/screen/main/tab/watchlist/favorite_provider.dart';

import 'common/theme/custom_theme.dart';

class App extends StatefulWidget {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  ///light, dark 테마가 준비되었고, 시스템 테마를 따라가게 하려면 해당 필드를 제거 하시면 됩니다.
  static const defaultTheme = CustomTheme.dark;
  static bool isForeground = true;

  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> with Nav, WidgetsBindingObserver {
  @override
  GlobalKey<NavigatorState> get navigatorKey => App.navigatorKey;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  //앱 재시작
  void restartApp() {
    final paymentController = Get.put(PaymentController());
    final FavoriteController favoriteController =
        Get.find<FavoriteController>();
    final SearchDataController searchDataController =
        Get.find<SearchDataController>();
    paymentController.getCurrentSubscriptIndex();
    favoriteController.loadInitialData();
    searchDataController.getHistory();
    navigatorKey.currentState?.popUntil((route) => route.isFirst);
    navigatorKey.currentState?.pushReplacement(
        MaterialPageRoute(builder: (context) => const MainScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return CustomThemeApp(
      child: Builder(builder: (context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: App.navigatorKey,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          title: 'Image Finder',
          theme: context.themeType.themeData,
          home: const MainScreen(),
        );
      }),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        App.isForeground = true;
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        App.isForeground = false;
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
    super.didChangeAppLifecycleState(state);
  }
}
