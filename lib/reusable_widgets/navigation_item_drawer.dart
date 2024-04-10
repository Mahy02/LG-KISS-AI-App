import 'package:flutter/material.dart';

class NavigationItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final VoidCallback? onPressed;

  const NavigationItem({
    super.key,
    required this.imagePath,
    required this.title,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.asset(imagePath),
      title: Text(title),
      onTap: onPressed,
    );
  }
}
