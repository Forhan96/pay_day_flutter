import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  int _currentNavIndex = 0;

  int get currentNavIndex => _currentNavIndex;

  set currentNavIndex(int index) {
    _currentNavIndex = index;
    notifyListeners();
  }
}
