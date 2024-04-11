import 'package:flutter/material.dart';

import '../screens/home_view.dart';


class CurrentViewProvider extends ChangeNotifier {
  Widget _currentView = const HomeView(); 

  Widget get currentView => _currentView;

  set currentView(Widget view) {
    _currentView = view;
    notifyListeners(); 
  }
}
