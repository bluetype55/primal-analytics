import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/more/settings/w_language_option.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: '설정'.text.make(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            '언어설정'.text.size(20).make().pOnly(left: 20),
            LanguageOption(),
          ],
        ),
      ),
    );
  }
}
