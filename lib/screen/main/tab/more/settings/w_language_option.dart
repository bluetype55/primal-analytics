import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../../../../../common/language/language.dart';

class LanguageOption extends StatelessWidget {
  const LanguageOption({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Tap(
          child: Container(
              padding: const EdgeInsets.only(left: 5, right: 5),
              margin: const EdgeInsets.only(left: 15, right: 20),
              decoration: BoxDecoration(
                  border: Border.all(color: context.appColors.veryBrightGrey),
                  borderRadius: BorderRadius.circular(10),
                  color: context.appColors.drawerBg,
                  boxShadow: [context.appShadows.buttonShadowSmall]),
              child: Row(
                children: [
                  const Width(10),
                  DropdownButton<String>(
                    items: [
                      menu(currentLanguage, context),
                      menu(
                          Language.values
                              .where((element) => element != currentLanguage)
                              .first,
                          context),
                    ],
                    onChanged: (value) async {
                      if (value == null) {
                        return;
                      }
                      await context
                          .setLocale(Language.find(value.toLowerCase()).locale);
                    },
                    value: describeEnum(currentLanguage).capitalizeFirst,
                    underline: const SizedBox.shrink(),
                    elevation: 1,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              )),
          onTap: () async {},
        ),
      ],
    );
  }

  DropdownMenuItem<String> menu(Language language, BuildContext context) {
    return DropdownMenuItem(
      value: describeEnum(language).capitalizeFirst,
      child: Row(
        children: [
          flag(language.flagPath),
          const Width(8),
          describeEnum(language)
              .capitalizeFirst!
              .text
              .color(Theme.of(context).textTheme.bodyLarge?.color)
              .size(12)
              .makeWithDefaultFont(),
        ],
      ),
    );
  }

  Widget flag(String path) {
    return SimpleShadow(
      opacity: 0.5,
      // Default: 0.5
      color: Colors.grey,
      // Default: Black
      offset: const Offset(2, 2),
      // Default: Offset(2, 2)
      sigma: 2,
      // Default: 2
      child: Image.asset(
        path,
        width: 20,
      ),
    );
  }
}
