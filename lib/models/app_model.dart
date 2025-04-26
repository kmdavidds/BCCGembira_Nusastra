import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  String token = "";
  String displayName = "";

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }

  void setDisplayName(String newDisplayName) {
    displayName = newDisplayName;
    notifyListeners();
  }
}
