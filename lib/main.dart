import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/data/stock_api/stock_service.dart';
import 'package:primal_analytics/screen/login/auth_controller.dart';
import 'package:primal_analytics/screen/main/tab/market/tab/dropdown_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'app.dart';
import 'common/data/preference/app_preferences.dart';
import 'firebase_options.dart';

void main() async {
  final bindings = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: bindings);
  await Firebase.initializeApp(
    //파이어베이스 초기화
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Get.put(AuthController());
  Get.lazyPut<StockService>(() => StockService());
  Get.put(DropdownController());
  await dotenv.load(fileName: ".env");
  await EasyLocalization.ensureInitialized();
  await AppPreferences.init();
  timeago.setLocaleMessages('ko', timeago.KoMessages());

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ko')],
      fallbackLocale: const Locale('en'),
      path: 'assets/translations',
      useOnlyLangCode: true,
      child: const App()));
}
