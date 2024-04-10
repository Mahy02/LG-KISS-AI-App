import 'package:flutter/material.dart';

import '../constants.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.content,
  });

  final Widget content;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      bottom: 30,
      left: 150,
      right: 20,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: AppColors.background),
        child: content,
      ),
    );
  }
}
