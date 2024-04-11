import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants.dart';
import '../providers/current_view_provider.dart';
import 'app_bar_widget.dart';
import 'drawer.dart';
import 'gradient_background.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     CurrentViewProvider currViewProvider =
        Provider.of<CurrentViewProvider>(context, listen: false);

    return Scaffold(
      body: Stack(
        children: [
          const GradientBackground(),
          const AppBarWidget(),
          const DrawerWidget(),
          Positioned(
            top: 100,
            bottom: 30,
            left: 150,
            right: 20,
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: AppColors.background),
                  child: currViewProvider.currentView ,
            ),
          ),
        ],
      ),
    );
  }
}
