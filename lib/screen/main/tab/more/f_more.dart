import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:primal_analytics/common/data/preference/app_preferences.dart';
import 'package:primal_analytics/screen/dialog/d_confirm.dart';
import 'package:primal_analytics/screen/login/auth_controller.dart';
import 'package:primal_analytics/screen/main/tab/more/w_more_app_bar.dart';
import 'package:primal_analytics/screen/main/tab/more/w_more_menu_item_list.dart';

import '../../../../common/common.dart';
import '../../s_main.dart';
import '../../w_menu_drawer.dart';

class MoreFragment extends StatefulWidget {
  const MoreFragment({super.key});

  @override
  State<MoreFragment> createState() => _MoreFragmentState();
}

class _MoreFragmentState extends State<MoreFragment> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        RefreshIndicator(
          edgeOffset: MoreAppBar.appBarHeight,
          onRefresh: () async {
            await sleepAsync(500.ms);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: MoreAppBar.appBarHeight,
              bottom: MainScreenState.bottomNavigatorHeight,
            ),
            child: Column(
              children: [
                const MoreMenuItemList(),
                Obx(() {
                  if (authController.firebaseUser.value != null) {
                    return Column(
                      children: [
                        MenuItemWidget("logout".tr(), onTap: () {
                          ConfirmDialog(
                            message: "SignOutMessage".tr(),
                            confirmButtonText: "logout".tr(),
                            confirmButtonColor: context.appColors.allertText,
                            function: authController.signOut,
                          ).show();
                        }),
                        const Line(),
                      ],
                    );
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ),
        const MoreAppBar(),
      ],
    );
  }
}
