import 'package:flutter/material.dart';

class OrderProvider extends ChangeNotifier {
  bool isActive = false;

  onChangeIsActive(value) {
    isActive = value;
    notifyListeners();
  }
}
