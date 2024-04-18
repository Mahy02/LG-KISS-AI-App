import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/providers/current_view_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'navigation_item_drawer.dart';

class DrawerWidget extends StatefulWidget {
  //final bool isDefault;

  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  Color homeColor = Colors.black;
  Color connectionColor = Colors.black;
  Color tasksColor = Colors.black;
  Color settingsColor = Colors.black;
  bool isDefault = true;

  @override
  Widget build(BuildContext context) {
    CurrentViewProvider currViewProvider =
        Provider.of<CurrentViewProvider>(context, listen: true);

    if (currViewProvider.currentView == 'settings') {
      setState(() {
        settingsColor = AppColors.primary1;
        homeColor = Colors.black;
        isDefault = false;
      });
    }
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
              color: isDefault ? AppColors.primary1 : homeColor,
              onPressed: () {
                setState(() {
                  homeColor = AppColors.primary1;
                  connectionColor = Colors.black;
                  tasksColor = Colors.black;
                  settingsColor = Colors.black;
                  isDefault = false;
                  currViewProvider.currentView = 'home';
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
                  isDefault = false;
                  currViewProvider.currentView = 'connection';
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
                  isDefault = false;
                  currViewProvider.currentView = 'tasks';
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
                  isDefault = false;
                  currViewProvider.currentView = 'settings';
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
