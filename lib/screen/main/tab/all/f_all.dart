import 'package:fast_app_base/common/common.dart';
import 'package:flutter/material.dart';

class AllFragment extends StatefulWidget {
  const AllFragment({super.key});

  @override
  State<AllFragment> createState() => _AllFragmentState();
}

class _AllFragmentState extends State<AllFragment> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                color: context.themeType.themeData.scaffoldBackgroundColor,
              ),
            ),
            title: '전체'.text.make(),
          ),
        ],
      ),
    );
  }
}
