import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/common/data/preference/app_preferences.dart';
import 'package:primal_analytics/screen/login/s_login.dart';
import 'package:primal_analytics/screen/main/tab/more/settings/w_color_switch.dart';

import '../../../login/auth_controller.dart';

class MoreAppBar extends StatefulWidget {
  static const double appBarHeight = 60;
  const MoreAppBar({super.key});

  @override
  State<MoreAppBar> createState() => _MoreAppBarState();
}

class _MoreAppBarState extends State<MoreAppBar> {
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MoreAppBar.appBarHeight,
      color: context.appColors.appBarBackgroud,
      child: Row(
        children: [
          width20,
          Obx(() {
            final User? user = authController.firebaseUser.value;
            if (user == null) {
              return ElevatedButton(
                onPressed: () {
                  Nav.push(LoginScreen());
                },
                child: Text('login'.tr()),
              );
            } else {
              return Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(user.photoURL!),
                  ),
                  width10,
                  "${user.displayName} 님".text.make(),
                ],
              );
            }
          }),
          emptyExpanded,
          const ColorSwitch(),
          width20,
        ],
      ),
    );
  }
}
