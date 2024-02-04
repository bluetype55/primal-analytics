import 'package:flutter/material.dart';
import 'package:primal_analytics/common/common.dart';
import 'package:primal_analytics/screen/main/tab/more/developer_info/s_developer_info.dart';
import 'package:primal_analytics/screen/main/tab/more/opensource/s_opensource.dart';
import 'package:primal_analytics/screen/main/tab/more/payment/s_payment_screen.dart';
import 'package:primal_analytics/screen/main/tab/more/settings/s_setting_screen.dart';

import '../../w_menu_drawer.dart';

class MoreMenuItemList extends StatelessWidget {
  const MoreMenuItemList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Line(),
        MenuItemWidget(
          'opensource'.tr(),
          onTap: () async {
            Nav.push(const OpensourceScreen());
          },
        ),
        const Line(),
        MenuItemWidget(
          'subscription'.tr(),
          onTap: () async {
            Nav.push(PaymentScreen());
          },
        ),
        const Line(),
        MenuItemWidget(
          'setting'.tr(),
          onTap: () async {
            Nav.push(const SettingScreen());
          },
        ),
        const Line(),
        MenuItemWidget(
          'developerInfo'.tr(),
          onTap: () async {
            Nav.push(const DeveloperInfoScreen());
          },
        ),
        const Line(),
      ],
    );
  }
}
