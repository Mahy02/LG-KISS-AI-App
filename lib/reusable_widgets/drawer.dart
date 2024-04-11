import 'package:discoveranimals/constants.dart';
import 'package:flutter/material.dart';

import 'navigation_item_drawer.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Color homeColor = Colors.black;
  Color connectionColor = Colors.black;
  Color tasksColor = Colors.black;
  Color settingsColor = Colors.black;

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
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
          NavigationItem(
              imagePath: 'assets/images/home.png',
              title: 'Home',
              color: homeColor,
              onPressed: () {
                setState(() {
                  homeColor = AppColors.primary1;
                  connectionColor = Colors.black;
                  tasksColor = Colors.black;
                  settingsColor = Colors.black;
                });
              }),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
          NavigationItem(
              imagePath: 'assets/images/connection.png',
              title: 'Connection Manager',
              color: connectionColor,
              onPressed: () {
                setState(() {
                  connectionColor = AppColors.primary1;
                  homeColor = Colors.black;
                  tasksColor = Colors.black;
                  settingsColor = Colors.black;
                });
              }),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
          NavigationItem(
              imagePath: 'assets/images/lgtasks.png',
              title: 'LG Tasks',
              color: tasksColor,
              onPressed: () {
                setState(() {
                  tasksColor = AppColors.primary1;
                  connectionColor = Colors.black;
                  homeColor = Colors.black;
                  settingsColor = Colors.black;
                });
              }),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
          NavigationItem(
              imagePath: 'assets/images/settings.png',
              title: 'Settings',
              color: settingsColor,
              onPressed: () {
                setState(() {
                  settingsColor = AppColors.primary1;
                  connectionColor = Colors.black;
                  tasksColor = Colors.black;
                  homeColor = Colors.black;
                });
              }),
          const Divider(
            color: Colors.black,
            height: 1,
            thickness: 2,
          ),
        ]),
      ),
    );
  }
}
