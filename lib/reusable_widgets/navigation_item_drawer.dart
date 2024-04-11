import 'package:discoveranimals/constants.dart';
import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final Color color;
  final VoidCallback? onPressed;

  const NavigationItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.color,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        children: [
          Image.asset(
            imagePath,
            color: color,
          ),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: fontType,
              fontSize: 15,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
