import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:primal_analytics/common/common.dart';

import '../../../../../common/theme/theme_util.dart';
import '../../../../../common/widget/w_mode_switch.dart';

class ColorSwitch extends StatelessWidget {
  const ColorSwitch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ModeSwitch(
      value: context.isDarkMode,
      onChanged: (value) {
        ThemeUtil.toggleTheme(context);
        if (value) {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // 스테이터스 바 색상 (투명으로 설정)
            statusBarIconBrightness: Brightness.light, // 아이콘 색상 (어두운 아이콘)
          ));
        } else {
          SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // 스테이터스 바 색상 (투명으로 설정)
            statusBarIconBrightness: Brightness.dark,
          ));
        }
      },
      height: 30,
      activeThumbImage: Image.asset('$basePath/darkmode/moon.png'),
      inactiveThumbImage: Image.asset('$basePath/darkmode/sun.png'),
      activeThumbColor: Colors.transparent,
      inactiveThumbColor: Colors.transparent,
    );
  }
}
