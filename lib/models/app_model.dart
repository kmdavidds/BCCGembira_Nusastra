import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  String token = "";
  String displayName = "";
  int currentPageIndex = 0;
  CameraDescription? camera;

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

  void setCamera(CameraDescription newCamera) {
    camera = newCamera;
    notifyListeners();
  }
}
