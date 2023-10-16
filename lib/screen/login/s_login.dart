import 'package:fast_app_base/common/common.dart';
import 'package:fast_app_base/screen/dialog/d_message.dart';
import 'package:fast_app_base/screen/login/auth_controller.dart';
import 'package:fast_app_base/screen/main/s_main.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr()),
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            final userCredit = await authController.signInWithGoogle();
            if (userCredit == null) {
              MessageDialog('로그인 실패').show();
              return;
            }
            if (context.mounted) Nav.push(const MainScreen());
          },
          child: 'Sign in with Google'.text.make(),
        ),
      ),
    );
  }
}
