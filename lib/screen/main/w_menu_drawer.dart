import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:primal_analytics/screen/main/tab/more/settings/w_color_switch.dart';
import 'package:primal_analytics/screen/main/tab/more/settings/w_language_option.dart';
import 'package:primal_analytics/screen/opensource/s_opensource.dart';

import '../../../screen/dialog/d_message.dart';
import '../../common/common.dart';
import '../../common/theme/theme_util.dart';

class MenuDrawer extends StatefulWidget {
  static const minHeightForScrollView = 380;

  const MenuDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<MenuDrawer> createState() => _MenuDrawerState();
}

class _MenuDrawerState extends State<MenuDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SafeArea(
        child: Tap(
          onTap: () {
            closeDrawer(context);
          },
          child: Tap(
            onTap: () {},
            child: Container(
              width: 240,
              padding: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(5),
                    bottomRight: Radius.circular(5)),
                color: context.colors.background,
              ),
              child: isSmallScreen(context)
                  ? SingleChildScrollView(
                      child: getMenus(context),
                    )
                  : getMenus(context),
            ),
          ),
        ),
      ),
    );
  }

  bool isSmallScreen(BuildContext context) =>
      context.deviceHeight < MenuDrawer.minHeightForScrollView;

  Container getMenus(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: context.deviceHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(EvaIcons.close),
                  onPressed: () {
                    closeDrawer(context);
                  },
                  padding: const EdgeInsets.only(
                    top: 0,
                    right: 20,
                    left: 20,
                  ),
                ),
              )
            ],
          ),
          const Height(10),
          const Line(),
          MenuItemWidget(
            'opensource'.tr(),
            onTap: () async {
              Nav.push(const OpensourceScreen());
            },
          ),
          const Line(),
          MenuItemWidget(
            'clear_cache'.tr(),
            onTap: () async {
              final manager = DefaultCacheManager();
              await manager.emptyCache();
              if (mounted) {
                MessageDialog('clear_cache_done'.tr()).show();
              }
            },
          ),
          const Line(),
          isSmallScreen(context) ? const Height(10) : const EmptyExpanded(),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: const ColorSwitch().pOnly(left: 20),
          ),
          const Height(10),
          const LanguageOption(),
          const Height(10),
          Row(
            children: [
              Expanded(
                child: Tap(
                  child: Container(
                      height: 30,
                      width: 100,
                      padding: const EdgeInsets.only(left: 15),
                      child: '© 2023. Bansook Nam. all rights reserved.'
                          .selectableText
                          .size(10)
                          .makeWithDefaultFont()),
                  onTap: () async {},
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void toggleTheme() {
    ThemeUtil.toggleTheme(context);
  }

  void closeDrawer(BuildContext context) {
    if (Scaffold.of(context).isDrawerOpen) {
      Scaffold.of(context).closeDrawer();
    }
  }
}

class MenuItemWidget extends StatelessWidget {
  final String text;
  final Function() onTap;

  const MenuItemWidget(this.text, {Key? key, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 55,
      child: Tap(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.only(left: 15, right: 20),
          child: Row(
            children: [
              Expanded(
                  child: text.text
                      .textStyle(defaultFontStyle())
                      .color(context.appColors.drawerText)
                      .size(20)
                      .make()),
            ],
          ),
        ),
      ),
    );
  }
}
