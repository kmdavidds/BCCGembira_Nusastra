import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  String token = "";
  String displayName = "";
  int currentPageIndex = 0;

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  void setDisplayName(String newDisplayName) {
    displayName = newDisplayName;
    notifyListeners();
  }

  void setCurrentPageIndex(int newIndex) {
    currentPageIndex = newIndex;
    notifyListeners();
  }
}
