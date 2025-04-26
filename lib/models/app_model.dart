import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  String token = "";

  void setToken(String newToken) {
    token = newToken;
    notifyListeners();
  }
}
