import 'package:discoveranimals/constants.dart';
import 'package:flutter/material.dart';

///This is custom widget for the `subText` that is reused in different views through the app

class SubText extends StatelessWidget {
  final String subTextContent;
  final double fontSize;
  final bool isCentered;
  const SubText({
    required this.subTextContent,
    required this.fontSize,
    required this.isCentered,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String capitalizedText = subTextContent.isNotEmpty
        ? subTextContent[0].toUpperCase() + subTextContent.substring(1)
        : subTextContent;

    return Text(
      capitalizedText,
      style: TextStyle(
        fontSize: fontSize,
        color: AppColors.font,
        fontFamily: fontType,
        fontWeight: FontWeight.bold,
      ),
      textAlign: isCentered ? TextAlign.center : TextAlign.start,
    );
  }
}
