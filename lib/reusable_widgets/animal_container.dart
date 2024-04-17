import 'package:discoveranimals/constants.dart';
import 'package:discoveranimals/helpers/api_key_shared_pref.dart';
import 'package:discoveranimals/providers/animal_provider.dart';
import 'package:discoveranimals/providers/current_view_provider.dart';
import 'package:discoveranimals/reusable_widgets/dialog_builder.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    CurrentViewProvider currViewProvider =
        Provider.of<CurrentViewProvider>(context, listen: false);
    AnimalProvider animalProvider =
        Provider.of<AnimalProvider>(context, listen: false);
    return GestureDetector(
      onTap: () {
        if (ApiKeySharedPref.getAPIKey() == '' ||
            ApiKeySharedPref.getAPIKey() == null) {
          dialogBuilder(
              context,
              'Please enter your Gemini API key to be able to continue',
              false,
              'OK', () {
            currViewProvider.currentView = 'settings';
          }, () {});
        } else {
          currViewProvider.currentView = 'animal';
          animalProvider.animalChoice = animalName;
        }
      },
      child: Container(
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
      ),
    );
  }
}
