import 'package:flutter/material.dart';
import 'package:primal_analytics/common/theme/color/abs_theme_colors.dart';

class DarkAppColors extends AbstractThemeColors {
  const DarkAppColors();

  @override
  Color get seedColor => AppColors.mediumBlue;

  @override
  Color get activate => Colors.white;

  @override
  Color get badgeBg => AppColors.darkOrange;

  @override
  Color get divider => const Color.fromARGB(255, 80, 80, 80);

  @override
  Color get drawerBg => const Color.fromARGB(255, 42, 42, 42);

  @override
  Color get hintText => AppColors.grey;

  @override
  Color get iconButton => const Color.fromARGB(255, 255, 255, 255);

  @override
  Color get iconButtonInactivate => const Color.fromARGB(255, 110, 110, 110);

  @override
  Color get inActivate => const Color.fromARGB(255, 65, 68, 74);

  @override
  Color get text => Colors.white;

  @override
  Color get focusedBorder => AppColors.darkGrey;

  @override
  Color get confirmText => AppColors.brightBlue;

  @override
  Color get blueButtonBackground => AppColors.blue;

  @override
  Color get roundedLayoutBackgorund => const Color.fromARGB(255, 24, 24, 24);

  @override
  Color get appBarBackgroud => const Color.fromARGB(255, 18, 18, 18);

  @override
  Color get lessImportant => const Color.fromARGB(255, 162, 162, 162);

  @override
  // TODO: implement plus
  Color get plus => const Color.fromARGB(255, 230, 71, 83);

  @override
  // TODO: implement minus
  Color get minus => const Color.fromARGB(255, 38, 97, 210);
}
