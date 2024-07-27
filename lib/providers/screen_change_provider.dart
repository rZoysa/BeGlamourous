import 'package:flutter/material.dart';

class ScreenChangeProvider extends ChangeNotifier {
  int _screenId = 0;

  int get screenId => _screenId;

  void setScreenId(int screenId) {
    _screenId = screenId;
    notifyListeners();
  }
}
