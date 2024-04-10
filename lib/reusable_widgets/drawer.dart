import 'package:flutter/material.dart';

import 'navigation_item_drawer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 100,
      bottom: 30,
      left: 20,
      width: 100,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Column(children: [
          NavigationItem(
              imagePath: 'assets/images/home.png',
              title: 'Home',
              onPressed: () {
                // Navigate to Home screen
              }),
          NavigationItem(
              imagePath: 'assets/images/connection.png',
              title: 'Connection Manager',
              onPressed: () {
                // Navigate to Settings screen
              }),
          NavigationItem(
              imagePath: 'assets/images/lgtasks.png',
              title: 'LG Tasks',
              onPressed: () {
                // Navigate to Profile screen
              }),
          NavigationItem(
              imagePath: 'assets/images/settings.png',
              title: 'Settings',
              onPressed: () {
                // Navigate to Notifications screen
              }),
        ]),
      ),
    );
  }
}
