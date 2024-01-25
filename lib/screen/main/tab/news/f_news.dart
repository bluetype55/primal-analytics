import 'package:flutter/material.dart';

import '../market/tab/currencies/w_prepair_box.dart';

class NewsFragment extends StatelessWidget {
  const NewsFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          '뉴스',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: PrepareBox(),
      ),
    );
  }
}
