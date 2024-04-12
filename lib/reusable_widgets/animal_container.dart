import 'package:discoveranimals/constants.dart';
import 'package:flutter/material.dart';

class AnimalContainer extends StatelessWidget {
  final String imagePath;
  final String animalName;

  const AnimalContainer({
    super.key,
    required this.imagePath,
    required this.animalName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary2, width: 4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(children: [
        Center(
          child: Image.asset(
            imagePath,
            fit: BoxFit.scaleDown,
          ),
        ),
        Text(
          animalName,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: textSize,
            fontFamily: fontType,
          ),
        ),
      ]),
    );
  }
}
