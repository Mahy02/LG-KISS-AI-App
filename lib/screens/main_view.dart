import 'package:discoveranimals/providers/animal_provider.dart';
import 'package:discoveranimals/providers/current_view_provider.dart';
import 'package:discoveranimals/screens/animal_info_view.dart';
import 'package:discoveranimals/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<CurrentViewProvider, AnimalProvider>(
        builder: (context, viewProvider, animalProvider, child) {
      if (viewProvider.currentView == 'home') {
        return const HomeView();
      } else if (viewProvider.currentView == 'animal') {
        return AnimalInfoView(animal: animalProvider.animalChoice);
      } else if (viewProvider.currentView == 'connection') {
        return Text('connection');
      } else if (viewProvider.currentView == 'tasks') {
        return Text('tasks');
      } else if (viewProvider.currentView == 'settings') {
        return Text('settings');
      }
      return const Placeholder();
    });
  }
}
