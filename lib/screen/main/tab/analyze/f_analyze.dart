import 'package:flutter/material.dart';

import '../market/tab/currencies/w_prepair_box.dart';

class AnalyzeFragment extends StatefulWidget {
  const AnalyzeFragment({super.key});

  @override
  State<AnalyzeFragment> createState() => _AnalyzeFragmentState();
}

class _AnalyzeFragmentState extends State<AnalyzeFragment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        title: const Text(
          '분석',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const Center(
        child: PrepareBox(),
      ),
    );
  }
}
