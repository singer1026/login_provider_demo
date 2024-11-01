import 'package:flutter/material.dart';

class TabProvider extends ChangeNotifier {
  final TabController _tabController;
  var currentIndex = 0;
  TabProvider(this._tabController);

  void changeIndex(int index) {
    _tabController.index = index;
    currentIndex = index;
    notifyListeners();
  }
}
