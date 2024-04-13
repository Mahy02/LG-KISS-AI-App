

import 'package:flutter/material.dart';

class AnimalProvider extends ChangeNotifier {
  String _animalChoice = '';

  String get animalChoice => _animalChoice;

  set animalChoice(String animal) {
    _animalChoice = animal;
    notifyListeners();
  }
}
