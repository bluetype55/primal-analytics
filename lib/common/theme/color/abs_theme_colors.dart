import 'package:flutter/material.dart';
import 'package:primal_analytics/common/constant/app_colors.dart';

export 'package:primal_analytics/common/constant/app_colors.dart';

typedef ColorProvider = Color Function();

abstract class AbstractThemeColors {
  const AbstractThemeColors();

  Color get seedColor => Colors.white;

  Color get veryBrightGrey => AppColors.brightGrey;

  Color get drawerBg => const Color.fromARGB(255, 255, 255, 255);

  Color get scrollableItem => const Color.fromARGB(255, 57, 57, 57);

  Color get iconButton => const Color.fromARGB(255, 0, 0, 0);

  Color get iconButtonInactivate => const Color.fromARGB(255, 162, 162, 162);

  Color get inActivate => const Color.fromARGB(255, 200, 207, 220);

  Color get activate => const Color.fromARGB(255, 63, 72, 95);

  Color get badgeBg => AppColors.blueGreen;

  Color get textBadgeText => Colors.white;

  Color get badgeBorder => Colors.transparent;

  Color get divider => const Color.fromARGB(255, 228, 228, 228);

  Color get text => AppColors.darkGrey;

  Color get hintText => AppColors.middleGrey;

  Color get focusedBorder => AppColors.darkGrey;

  Color get confirmText => AppColors.green;

  Color get allertText => const Color.fromARGB(255, 230, 71, 83);

  Color get drawerText => text;

  Color get snackbarBgColor => AppColors.mediumBlue;

  Color get blueButtonBackground => AppColors.darkBlue;

  Color get appBarBackgroud => const Color.fromARGB(255, 255, 255, 255);

  Color get buttonBackground => const Color.fromARGB(255, 48, 48, 48);

  Color get roundedLayoutBackgorund => const Color.fromARGB(255, 236, 250, 251);

  Color get unReadColor => const Color.fromARGB(255, 48, 48, 48);

  Color get lessImportant => const Color.fromARGB(255, 77, 77, 77);

  Color get blueText => AppColors.blue;

  Color get plus => const Color.fromARGB(255, 230, 71, 83);

  Color get minus => const Color.fromARGB(255, 38, 97, 210);
}
