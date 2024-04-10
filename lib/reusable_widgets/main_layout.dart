import 'package:flutter/material.dart';

import 'app_bar_widget.dart';
import 'drawer.dart';
import 'gradient_background.dart';
import 'main_view.dart';

class MainLayout extends StatelessWidget {
  final Widget content;
  final String drawerItem;

  const MainLayout({
    super.key,
    required this.content,
    required this.drawerItem,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          const AppBarWidget(),
          const DrawerWidget(),
          MainView(content: content),
        ],
      ),
    );
  }
}
